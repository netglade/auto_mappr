// ignore_for_file: prefer-match-file-name, prefer-single-declaration-per-file

import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/helpers/emitter_helper.dart';
import 'package:auto_mappr/src/models/models.dart';
import 'package:auto_mappr/src/models/type_converter.dart';
import 'package:code_builder/code_builder.dart' show Expression, literalList, literalMap, literalNull, literalSet;

class ConstructorAssignment {
  final FormalParameterElement param;
  final int? position;

  bool get isNamed => param.isNamed;

  const ConstructorAssignment({required this.param, this.position});
}

class SourceAssignment {
  final PropertyAccessorElement2? sourceField;

  final ConstructorAssignment? targetConstructorParam;
  final PropertyAccessorElement2? targetField;

  final List<TypeConverter> typeConverters;

  /// Field mapping.
  ///
  /// Like filed 'name' from 'userName' etc.
  final FieldMapping? fieldMapping;

  DartType? get sourceType => sourceField?.returnType;

  String? get sourceName => sourceField?.displayName;

  DartType get targetType => targetConstructorParam?.param.type ?? targetField!.returnType;

  String get targetName => targetConstructorParam?.param.displayName ?? targetField!.displayName;

  const SourceAssignment({
    required this.sourceField,
    required this.targetField,
    this.targetConstructorParam,
    this.typeConverters = const [],
    this.fieldMapping,
  });

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
  String toString() {
    final emittedSource = EmitterHelper.current.typeReferEmitted(type: sourceType);
    final emittedTarget = EmitterHelper.current.typeReferEmitted(type: targetType);

    return '$emittedSource $sourceName -> $emittedTarget $targetName';
  }

  Expression getDefaultValue() {
    if (targetType.isDartCoreList) return literalList([]);
    if (targetType.isDartCoreSet) return literalSet({});
    if (targetType.isDartCoreMap) return literalMap({});

    return literalNull;
  }

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
