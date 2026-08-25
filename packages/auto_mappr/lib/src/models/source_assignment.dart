// ignore_for_file: prefer-match-file-name, prefer-single-declaration-per-file

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/helpers/emitter_helper.dart';
import 'package:auto_mappr/src/models/models.dart';
import 'package:auto_mappr/src/models/type_converter.dart';
import 'package:code_builder/code_builder.dart'
    show Expression, literalList, literalMap, literalNull, literalSet, refer;
import 'package:source_gen/source_gen.dart';

class ConstructorAssignment {
  final FormalParameterElement param;
  final int? position;

  bool get isNamed => param.isNamed;

  const ConstructorAssignment({required this.param, this.position});
}

class SourceAssignment {
  final PropertyAccessorElement? sourceField;

  final ConstructorAssignment? targetConstructorParam;
  final PropertyAccessorElement? targetField;

  final List<TypeConverter> typeConverters;

  /// Field mapping.
  ///
  /// Like filed 'name' from 'userName' etc.
  final FieldMapping? fieldMapping;

  /// Wraps the mapped value when the target field is boxed.
  final BoxingFunction? boxing;

  /// Unwraps the source value when the source field is boxed.
  final BoxingFunction? unboxing;

  /// The declared type of the source field, before unboxing.
  DartType? get rawSourceType => sourceField?.returnType;

  /// The type of the source value as it enters the mapping.
  ///
  /// Unboxed when [shouldUnbox], so that `Value<int>` is mapped as `int`.
  DartType? get sourceType => shouldUnbox ? unboxing?.unboxedTypeOf(rawSourceType) : rawSourceType;

  String? get sourceName => sourceField?.displayName;

  /// The declared type of the target field, before boxing.
  DartType get rawTargetType => targetConstructorParam?.param.type ?? targetField!.returnType;

  /// The type the mapping has to produce.
  ///
  /// Unboxed when [shouldBox], so that `Value<int>` is mapped as `int`
  /// and the result is wrapped afterwards.
  DartType get targetType => (shouldBox ? boxing?.unboxedTypeOf(rawTargetType) : null) ?? rawTargetType;

  String get targetName => targetConstructorParam?.param.displayName ?? targetField!.displayName;

  /// Whether the mapped value has to be wrapped into the box type.
  bool get shouldBox {
    if (_boxingDisabled || !_isTargetBoxed || _isSourceBoxed) return false;

    if (boxing == null) {
      final type = _displayed(rawTargetType);

      throw InvalidGenerationSourceError(
        "Target field '$targetName' is of the boxed type '$type' but no boxing function is configured.",
        todo: "Set 'boxing' on the map type, or set 'boxing: false' on the field.",
      );
    }

    return true;
  }

  /// Whether the source value has to be unwrapped from the box type.
  bool get shouldUnbox {
    if (_boxingDisabled || !_isSourceBoxed || _isTargetBoxed) return false;

    if (unboxing == null) {
      final type = _displayed(rawSourceType);

      throw InvalidGenerationSourceError(
        "Source field '$sourceName' is of the boxed type '$type' but no unboxing function is configured.",
        todo: "Set 'unboxing' on the map type, or set 'boxing: false' on the field.",
      );
    }

    // Record assignments read the source field on their own and would silently
    // skip the unboxing, so reject them instead of generating broken code.
    if (unboxing?.unboxedTypeOf(rawSourceType) is RecordType) {
      final type = _displayed(rawSourceType);

      throw InvalidGenerationSourceError(
        "Source field '$sourceName' of the boxed type '$type' cannot be unboxed: records are not supported.",
        todo: "Set 'boxing: false' on the field and map it with 'custom' instead.",
      );
    }

    return true;
  }

  /// The expression reading the source field, with unboxing applied.
  Expression get sourceExpression {
    // ignore: avoid-non-null-assertion, only used when the source field is set
    final field = sourceField!;

    final owner = field.isStatic
        // Static field.
        // ignore: avoid-non-null-assertion, should be ok
        ? EmitterHelper.current.refer(field.enclosingElement.name!, field.enclosingElement.library?.uri.toString())
        // Non static field.
        : refer('model');

    // ignore: avoid-non-null-assertion, must not be empty
    final read = owner.property(field.name!);
    final unbox = shouldUnbox ? unboxing : null;

    return unbox == null ? read : unbox.apply(read);
  }


  /// Whether boxing and unboxing are turned off for this field.
  ///
  /// A custom mapping provides the whole value, including the box.
  bool get _boxingDisabled =>
      fieldMapping?.boxing == false || (fieldMapping?.hasCustomMapping() ?? false);

  /// Either of the two functions identifies the box class.
  BoxingFunction? get _boxFunction => boxing ?? unboxing;

  bool get _isSourceBoxed => _boxFunction?.isBoxed(rawSourceType) ?? false;

  bool get _isTargetBoxed => _boxFunction?.isBoxed(rawTargetType) ?? false;

  const SourceAssignment({
    required this.sourceField,
    required this.targetField,
    this.targetConstructorParam,
    this.typeConverters = const [],
    this.fieldMapping,
    this.boxing,
    this.unboxing,
  });

  /// Wraps [value] into the box type when the target field is boxed.
  Expression maybeBox(Expression value) {
    final box = shouldBox ? boxing : null;

    return box == null ? value : box.apply(value);
  }

  bool canAssignIterable() {
    final isCoreIterable = _isCoreIterable(targetType);
    final isSpecializedIntList = targetType.isSpecializedIntListType;
    final isMappableIterable = _isMappableIterable(sourceType!);

    // The source can be mapped to the target, if the source is mappable object and the target is an iterable.
    return (isCoreIterable || isSpecializedIntList) && isMappableIterable;
  }

  bool canAssignMap() {
    // The source can be mapped to the target, if the source is mappable object and the target is map.
    return targetType.isDartCoreMap && _isMappableMap(sourceType!);
  }

  bool canAssignRecord() {
    final isSourceRecord = sourceType is RecordType;
    final isTargetRecord = targetType is RecordType;

    return isSourceRecord && isTargetRecord;
  }

  @override
  String toString() => '${_emitted(rawSourceType)} $sourceName -> ${_emitted(rawTargetType)} $targetName';

  Expression getDefaultValue() {
    if (targetType.isDartCoreList) return literalList([]);
    if (targetType.isDartCoreSet) return literalSet({});
    if (targetType.isDartCoreMap) return literalMap({});

    return literalNull;
  }

  String _emitted(DartType? type) => EmitterHelper.current.typeReferEmitted(type: type);

  /// Without import aliases, used to display errors to user.
  String _displayed(DartType? type) => type?.getDisplayString() ?? 'null';

  bool _isCoreIterable(DartType type) {
    return type.isDartCoreList || type.isDartCoreSet || type.isDartCoreIterable;
  }

  bool _isMappableIterable(DartType type) {
    if (_isCoreIterable(type)) {
      return true;
    }

    if (type is! InterfaceType) {
      return false;
    }

    return type.allSupertypes.any(_isCoreIterable);
  }

  bool _isMappableMap(DartType type) {
    if (type.isDartCoreMap) {
      return true;
    }

    if (type is! InterfaceType) {
      return false;
    }

    return type.allSupertypes.any((superType) => superType.isDartCoreMap);
  }
}
