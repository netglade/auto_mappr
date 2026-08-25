import 'package:auto_mappr/src/builder/assignments/assignments.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/models/models.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';

/// Decides how values are assigned.
class ValueAssignmentBuilder {
  final AutoMapprConfig mapperConfig;
  final TypeMapping mapping;
  final SourceAssignment assignment;
  // ignore: prefer-typedefs-for-callbacks, private API
  final void Function(TypeMapping? mapping)? onUsedNullableMethodCallback;

  const ValueAssignmentBuilder({
    required this.mapperConfig,
    required this.mapping,
    required this.assignment,
    required this.onUsedNullableMethodCallback,
  });

  Expression build() {
    // Boxing wraps whatever the assignment produced, so every branch below
    // maps into the unboxed target type and stays unaware of the box.
    return assignment.maybeBox(_buildValue());
  }

  Expression _buildValue() {
    final sourceField = assignment.sourceField;

    final fieldMapping = assignment.fieldMapping;

    if (sourceField == null) {
      if (fieldMapping != null && fieldMapping.canBeApplied(assignment)) {
        return fieldMapping.apply(assignment);
      }

      return assignment.getDefaultValue();
    }

    if (fieldMapping != null && fieldMapping.canBeApplied(assignment)) {
      return fieldMapping.apply(assignment);
    }

    final rightSide = assignment.sourceExpression;
    final assignmentBuilders = [
      // Type converter.
      TypeConverterBuilder(
        assignment: assignment,
        mapperConfig: mapperConfig,
        mapping: mapping,
        onUsedNullableMethodCallback: onUsedNullableMethodCallback,
        source: assignment.sourceType!,
        target: assignment.targetType,
        convertMethodArgument: rightSide,
      ),
      // Iterable.
      IterableAssignmentBuilder(
        assignment: assignment,
        mapperConfig: mapperConfig,
        mapping: mapping,
        onUsedNullableMethodCallback: onUsedNullableMethodCallback,
      ),
      // Map.
      MapAssignmentBuilder(
        assignment: assignment,
        mapperConfig: mapperConfig,
        mapping: mapping,
        onUsedNullableMethodCallback: onUsedNullableMethodCallback,
      ),
      // Record.
      RecordAssignmentBuilder(
        assignment: assignment,
        mapperConfig: mapperConfig,
        mapping: mapping,
        onUsedNullableMethodCallback: onUsedNullableMethodCallback,
      ),
      // Nested object.
      NestedObjectAssignmentBuilder(
        assignment: assignment,
        mapperConfig: mapperConfig,
        mapping: mapping,
        onUsedNullableMethodCallback: onUsedNullableMethodCallback,
        source: assignment.sourceType!,
        target: assignment.targetType,
        convertMethodArgument: rightSide,
      ),
    ];

    // Try to assign value using one of assignment builder.
    for (final builder in assignmentBuilders) {
      if (builder.canAssign()) {
        return builder.buildAssignment();
      }
    }

    // Primitive types (based on DartTypeExtension.isPrimitiveType)

    // When null.
    if (fieldMapping?.whenNullExpression != null) {
      return rightSide.ifNullThen(fieldMapping!.whenNullExpression!);
    }

    final isSourceNullable = assignment.sourceType!.isNullable;
    final isTargetNullable = assignment.targetType.isNullable;

    // BANG operator when Source is nullable and Target not
    final shouldIgnoreNull = fieldMapping?.ignoreNull ??
        mapping.ignoreFieldNull ??
        mapperConfig.mapprOptions.ignoreNullableSourceField ??
        false;

    if (shouldIgnoreNull && isSourceNullable && !isTargetNullable) {
      return rightSide.nullChecked;
    }

    if (assignment.sourceType!.isDynamic && !assignment.targetType.isDynamic) {
      log.warning("Casting dynamic source field '$assignment' when mapping '$mapping'. Consider providing a type converter or a custom mapping to avoid runtime casts.");

      return rightSide.asA(refer(assignment.targetType.getDisplayString()));
    }

    return rightSide;
  }
}
