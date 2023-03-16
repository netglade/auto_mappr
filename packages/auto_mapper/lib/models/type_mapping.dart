import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mapper/builder/convert_method_builder.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import 'field_mapping.dart';

class TypeMapping extends Equatable {
  final DartType source;
  final DartType target;
  final List<FieldMapping>? fieldMappings;
  final Expression? whenSourceIsNullExpression;
  final String? constructor;

  String get mappingMapMethodName => ConvertMethodBuilder.concreteConvertMethodName(source, target);

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
    required this.fieldMappings,
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
    return '$source -> $target';
  }
}
