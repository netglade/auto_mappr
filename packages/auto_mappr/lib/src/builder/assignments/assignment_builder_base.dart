import 'package:auto_mappr/src/models/models.dart';
import 'package:code_builder/code_builder.dart';

abstract class AssignmentBuilderBase {
  final SourceAssignment assignment;
  final AutoMapprConfig mapperConfig;
  final TypeMapping mapping;
  // ignore: prefer-typedefs-for-callbacks, private API
  final void Function(TypeMapping? mapping)? onUsedNullableMethodCallback;

  static const Reference modelReference = Reference('model');

  const AssignmentBuilderBase({
    required this.assignment,
    required this.mapperConfig,
    required this.mapping,
    required this.onUsedNullableMethodCallback,
  });

  Expression buildAssignment();

  bool canAssign();
}
