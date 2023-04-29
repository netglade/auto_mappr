//ignore_for_file: prefer-match-file-name

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/models/models.dart';
import 'package:code_builder/code_builder.dart';

class ConstructorAssignment {
  final ParameterElement param;
  final int? position;

  bool get isNamed => param.isNamed;

  ConstructorAssignment({
    required this.param,
    this.position,
  });
}

class SourceAssignment {
  final PropertyAccessorElement? sourceField;

  final ConstructorAssignment? targetConstructorParam;
  final PropertyAccessorElement? targetField;

  /// Field mapping.
  ///
  /// Like filed 'name' from 'userName' etc.
  final FieldMapping? fieldMapping;

  /// Mapping of type.
  ///
  /// Like UserDto to User.
  final TypeMapping typeMapping;

  final AutoMapprConfig config;

  bool get shouldBeIgnored => fieldMapping?.ignore ?? false;

  DartType? get sourceType => sourceField?.returnType;

  String? get sourceName => sourceField?.displayName;

  DartType get targetType => targetConstructorParam?.param.type ?? targetField!.returnType;

  String get targetName => targetConstructorParam?.param.displayName ?? targetField!.displayName;

  SourceAssignment({
    required this.sourceField,
    required this.targetField,
    required this.typeMapping,
    required this.config,
    this.targetConstructorParam,
    this.fieldMapping,
  });

  bool shouldAssignIterable() {
    // The source can be mapped to the target, if the source is mappable object and the target is an iterable.
    return _isCoreIterable(targetType) && _isMappableIterable(sourceType!);
  }

  bool shouldAssignMap() {
    // The source can be mapped to the target, if the source is mappable object and the target is map.
    return targetType.isDartCoreMap && _isMappableMap(sourceType!);
  }

  bool shouldAssignComplexObject() => !targetType.isPrimitiveType;

  @override
  String toString() {
    final sourceTypeName = sourceType?.getDisplayStringWithLibraryAlias(withNullability: true, config: config);
    final targetTypeName = targetType.getDisplayStringWithLibraryAlias(withNullability: true, config: config);

    return '$sourceTypeName $sourceName -> $targetTypeName $targetName';
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
