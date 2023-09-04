import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/builder/assignments/assignment_builder_base.dart';
import 'package:auto_mappr/src/builder/assignments/nested_object_mixin.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:code_builder/code_builder.dart';

class NestedObjectAssignmentBuilder extends AssignmentBuilderBase with NestedObjectMixin {
  final DartType source;
  final DartType target;
  final Expression? convertMethodArgument;
  final bool includeGenericTypes;

  const NestedObjectAssignmentBuilder({
    required super.assignment,
    required super.mapperConfig,
    required super.mapping,
    required super.usedNullableMethodCallback,
    required this.source,
    required this.target,
    this.convertMethodArgument,
    this.includeGenericTypes = false,
  });

  @override
  bool canAssign() {
    return !assignment.targetType.isPrimitiveType;
  }

  @override
  Expression buildAssignment() {
    return assignNestedObject(
      source: source,
      target: target,
      assignment: assignment,
      convertMethodArgument: convertMethodArgument,
      includeGenericTypes: includeGenericTypes,
    );
  }
}
