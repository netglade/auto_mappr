// ignore_for_file: no-equal-arguments

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/builder/convert_method_builder.dart';
import 'package:auto_mappr/src/models/field_mapping.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

class TypeMapping extends Equatable {
  final InterfaceType source;
  final InterfaceType target;
  final List<FieldMapping>? fieldMappings;
  final Expression? whenSourceIsNullExpression;
  final String? constructor;

  String get mappingMethodName => ConvertMethodBuilder.concreteConvertMethodName(
        source: source,
        target: target,
      );

  String get nullableMappingMethodName => ConvertMethodBuilder.concreteNullableConvertMethodName(
        source: source,
        target: target,
      );

  bool get isEnumMapping => source.element is EnumElement || target.element is EnumElement;

  @override
  List<Object?> get props {
    return [
      source,
      target,
      fieldMappings,
      whenSourceIsNullExpression,
      constructor,
    ];
  }

  const TypeMapping({
    required this.source,
    required this.target,
    this.fieldMappings,
    this.whenSourceIsNullExpression,
    this.constructor,
  });

  bool hasWhenNullDefault() {
    return whenSourceIsNullExpression != null;
  }

  String sourceName({bool withNullability = false}) => source.getDisplayString(withNullability: withNullability);

  String targetName({bool withNullability = false}) => target.getDisplayString(withNullability: withNullability);

  bool hasFieldMapping(String field) => fieldMappings?.any((x) => x.field == field) ?? false;

  FieldMapping getFieldMapping(String field) => fieldMappings!.firstWhere((x) => x.field == field);

  FieldMapping? tryGetFieldMapping(String field) => fieldMappings?.firstWhereOrNull((x) => x.field == field);

  bool fieldShouldBeIgnored(String field) => hasFieldMapping(field) && getFieldMapping(field).ignore;

  @override
  String toString() {
    // ignore: avoid-non-ascii-symbols, it is ok
    return '$source → $target';
  }
}
