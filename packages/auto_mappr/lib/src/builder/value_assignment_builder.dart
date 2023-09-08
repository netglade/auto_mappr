import 'package:auto_mappr/src/builder/assignments/assignments.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/helpers/emitter_helper.dart';
import 'package:auto_mappr/src/models/models.dart';
import 'package:code_builder/code_builder.dart';

/// Decides how values are assigned.
class ValueAssignmentBuilder {
  final AutoMapprConfig mapperConfig;
  final TypeMapping mapping;
  final SourceAssignment assignment;
  final void Function(TypeMapping? mapping)? usedNullableMethodCallback;

  const ValueAssignmentBuilder({
    required this.mapperConfig,
    required this.mapping,
    required this.assignment,
    required this.usedNullableMethodCallback,
  });

  Expression build() {
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

    final rightSide = (sourceField.isStatic
            // Static field.
            ? EmitterHelper.current
                .refer(sourceField.enclosingElement.name!, sourceField.enclosingElement.library?.identifier)
            // Non static field.
            : refer(sourceField.isStatic ? '${sourceField.enclosingElement.name}' : 'model'))
        .property(sourceField.name);

    final assignmentBuilders = [
      // Iterable.
      IterableAssignmentBuilder(
        assignment: assignment,
        mapperConfig: mapperConfig,
        mapping: mapping,
        usedNullableMethodCallback: usedNullableMethodCallback,
      ),
      // Map.
      MapAssignmentBuilder(
        assignment: assignment,
        mapperConfig: mapperConfig,
        mapping: mapping,
        usedNullableMethodCallback: usedNullableMethodCallback,
      ),
      // Record.
      RecordAssignmentBuilder(
        assignment: assignment,
        mapperConfig: mapperConfig,
        mapping: mapping,
        usedNullableMethodCallback: usedNullableMethodCallback,
      ),
      // Nested object.
      NestedObjectAssignmentBuilder(
        assignment: assignment,
        mapperConfig: mapperConfig,
        mapping: mapping,
        usedNullableMethodCallback: usedNullableMethodCallback,
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

    if (fieldMapping?.whenNullExpression != null) {
      return rightSide.ifNullThen(fieldMapping!.whenNullExpression!);
    }

    final sourceNullable = assignment.sourceType!.isNullable;
    final targetNullable = assignment.targetType.isNullable;

    // BANG operator when Source is nullable and Target not
    final shouldIgnoreNull = fieldMapping?.ignoreNull ??
        mapping.ignoreFieldNull ??
        mapperConfig.mapprOptions.ignoreNullableSourceField ??
        false;

    if (shouldIgnoreNull && sourceNullable && !targetNullable) {
      return refer(sourceField.isStatic ? '${sourceField.enclosingElement.name}' : 'model')
          .property(sourceField.name)
          .nullChecked;
    }

    return rightSide;
  }
}
