import 'package:auto_mappr/src/models/models.dart';
import 'package:code_builder/code_builder.dart';

abstract class AssignmentBuilderBase {
  final SourceAssignment assignment;
  final AutoMapprConfig mapperConfig;
  final TypeMapping mapping;
  final void Function(TypeMapping? mapping)? usedNullableMethodCallback;

  const AssignmentBuilderBase({
    required this.assignment,
    required this.mapperConfig,
    required this.mapping,
    required this.usedNullableMethodCallback,
  });

  Expression buildAssignment();

  bool canAssign();
}
