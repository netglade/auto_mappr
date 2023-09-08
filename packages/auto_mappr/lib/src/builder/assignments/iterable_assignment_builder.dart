import 'package:auto_mappr/src/builder/assignments/assignment_builder_base.dart';
import 'package:auto_mappr/src/builder/assignments/nested_object_mixin.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:auto_mappr/src/helpers/emitter_helper.dart';
import 'package:auto_mappr/src/models/models.dart';
import 'package:code_builder/code_builder.dart';

class IterableAssignmentBuilder extends AssignmentBuilderBase with NestedObjectMixin {
  const IterableAssignmentBuilder({
    required super.assignment,
    required super.mapperConfig,
    required super.mapping,
    required super.usedNullableMethodCallback,
  });

  @override
  bool canAssign() {
    return assignment.canAssignIterable();
  }

  @override
  Expression buildAssignment() {
    final sourceType = assignment.sourceType!;
    final targetType = assignment.targetType;

    final sourceNullable = sourceType.isNullable;
    final targetNullable = targetType.isNullable;

    final sourceIterableType = sourceType.genericParameterTypeOrSelf;
    final targetIterableType = targetType.genericParameterTypeOrSelf;

    final shouldFilterNullInSource = sourceIterableType.isNullable && targetIterableType.isNotNullable;

    final assignNestedObject = (!targetIterableType.isPrimitiveType && !targetIterableType.isSpecializedListType) &&
        (!targetIterableType.isSame(sourceIterableType));

    // When [sourceIterableType] is nullable and [targetIterableType] is not, remove null values.
    final sourceIterableExpression = refer('model').property(assignment.sourceField!.name).maybeWhereIterableNotNull(
          condition: shouldFilterNullInSource,
          isOnNullable: sourceNullable,
        );

    final defaultIterableValueExpression = targetType.defaultIterableExpression();

    if (assignNestedObject) {
      return sourceIterableExpression
          // Map complex nested types.
          .maybeNullSafeProperty('map', isOnNullable: sourceNullable)
          .call(
            [_map(assignment)],
            {},
            [EmitterHelper.current.typeRefer(type: targetIterableType)],
          )
          // Call toList, toSet or nothing.
          // isOnNullable is false, because if map() was called, the value is non-null
          .maybeToIterableCall(
            source: sourceType,
            target: targetType,
            forceCast: true, //map was used so we want force toIterable() call
            isOnNullable: false,
          )
          // When [sourceNullable], use default value.
          .maybeIfNullThen(defaultIterableValueExpression, isOnNullable: sourceNullable && !targetNullable);
    }

    return sourceIterableExpression
        .maybeToIterableCall(
          source: sourceType,
          target: targetType,
          forceCast: shouldFilterNullInSource, // if whereNotNull was used -> we want to force toIterable() call
          isOnNullable: !targetNullable && sourceNullable,
        )
        .maybeIfNullThen(
          defaultIterableValueExpression,
          isOnNullable: !targetNullable && sourceNullable,
        );
  }

  Expression _map(SourceAssignment assignment) {
    final targetListType = assignment.targetType.genericParameterTypeOrSelf;
    final sourceListType = assignment.sourceType!.genericParameterTypeOrSelf;

    return assignNestedObject(
      assignment: assignment,
      source: sourceListType,
      target: targetListType,
    );
  }
}
