import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/builder/methods/method_builder_base.dart';
import 'package:auto_mappr/src/models/boxing_function.dart';
import 'package:auto_mappr/src/models/field_mapping.dart';
import 'package:auto_mappr/src/models/type_converter.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

class TypeMapping with Equatable {
  final InterfaceType source;
  final InterfaceType target;
  final List<FieldMapping> fieldMappings;
  final List<TypeConverter> typeConverters;
  final Expression? whenSourceIsNullExpression;
  final String? constructor;
  final bool? ignoreFieldNull;
  final bool? safeMapping;

  /// Wraps mapped values of boxed [target] fields.
  final BoxingFunction? boxing;

  /// Unwraps values of boxed [source] fields.
  final BoxingFunction? unboxing;

  bool get isEnumMapping => source.element is EnumElement || target.element is EnumElement;

  @override
  List<Object?> get props {
    return [
      source,
      target,
      fieldMappings,
      typeConverters,
      whenSourceIsNullExpression,
      constructor,
      ignoreFieldNull,
      safeMapping,
      boxing,
      unboxing,
    ];
  }

  const TypeMapping({
    required this.source,
    required this.target,
    required this.ignoreFieldNull,
    this.fieldMappings = const [],
    this.typeConverters = const [],
    this.whenSourceIsNullExpression,
    this.constructor,
    this.safeMapping,
    this.boxing,
    this.unboxing,
  });

  String mappingMethodName() => MethodBuilderBase.constructConvertMethodName(
        source: source,
        target: target,
      );

  String nullableMappingMethodName() => MethodBuilderBase.constructNullableConvertMethodName(
        source: source,
        target: target,
      );

  bool hasWhenNullDefault() {
    return whenSourceIsNullExpression != null;
  }

  bool hasFieldMapping(String field) => fieldMappings.any((x) => x.field == field);

  FieldMapping? getFieldMapping(String field) => fieldMappings.firstWhereOrNull((x) => x.field == field);

  FieldMapping? tryGetFieldMapping(String field) => fieldMappings.firstWhereOrNull((x) => x.field == field);

  FieldMapping? tryGetFieldMappingFromFrom(String from) => fieldMappings.firstWhereOrNull((x) => x.from == from);

  bool fieldShouldBeIgnored(String field) => hasFieldMapping(field) && (getFieldMapping(field)?.ignore ?? false);

  @override
  String toString() {
    // Without import aliases, used to display errors to user.
    final sourceAsString = source.getDisplayString();
    final targetAsString = target.getDisplayString();

    // ignore: avoid-non-ascii-symbols, it is ok
    return '$sourceAsString → $targetAsString';
  }
}
