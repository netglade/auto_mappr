// ignore_for_file: no-equal-arguments

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/builder/convert_method_builder.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/models/auto_mappr_config.dart';
import 'package:auto_mappr/src/models/field_mapping.dart';
import 'package:auto_mappr/src/models/type_conversion.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

class TypeMapping extends Equatable {
  final InterfaceType source;
  final InterfaceType target;
  final List<FieldMapping>? fieldMappings;
  final List<TypeConversion>? typeConversions;
  final Expression? whenSourceIsNullExpression;
  final String? constructor;

  bool get isEnumMapping => source.element is EnumElement || target.element is EnumElement;

  @override
  List<Object?> get props {
    return [
      source,
      target,
      fieldMappings,
      typeConversions,
      whenSourceIsNullExpression,
      constructor,
    ];
  }

  const TypeMapping({
    required this.source,
    required this.target,
    required this.fieldMappings,
    required this.typeConversions,
    required this.whenSourceIsNullExpression,
    required this.constructor,
  });

  String mappingMethodName({
    required AutoMapprConfig config,
  }) =>
      ConvertMethodBuilder.concreteConvertMethodName(
        source: source,
        target: target,
        config: config,
      );

  String nullableMappingMethodName({
    required AutoMapprConfig config,
  }) =>
      ConvertMethodBuilder.concreteNullableConvertMethodName(
        source: source,
        target: target,
        config: config,
      );

  bool hasWhenNullDefault() {
    return whenSourceIsNullExpression != null;
  }

  bool hasFieldMapping(String field) => fieldMappings?.any((x) => x.field == field) ?? false;

  FieldMapping getFieldMapping(String field) => fieldMappings!.firstWhere((x) => x.field == field);

  FieldMapping? tryGetFieldMapping(String field) => fieldMappings?.firstWhereOrNull((x) => x.field == field);

  bool fieldShouldBeIgnored(String field) => hasFieldMapping(field) && getFieldMapping(field).ignore;

  @override
  String toString() {
    // ignore: avoid-non-ascii-symbols, it is ok
    return '$source → $target';
  }

  String toStringWithLibraryAlias({
    required AutoMapprConfig config,
  }) {
    // ignore: avoid-non-ascii-symbols, it is ok
    return '${source.getDisplayStringWithLibraryAlias(
      config: config,
    )} → ${target.getDisplayStringWithLibraryAlias(
      config: config,
    )}';
  }
}
