import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/builder/assignments/assignment_builder_base.dart';
import 'package:auto_mappr/src/builder/assignments/nested_object_mixin.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:auto_mappr/src/helpers/emitter_helper.dart';
import 'package:auto_mappr/src/models/models.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';

class MapAssignmentBuilder extends AssignmentBuilderBase with NestedObjectMixin {
  const MapAssignmentBuilder({
    required super.assignment,
    required super.mapperConfig,
    required super.mapping,
    required super.usedNullableMethodCallback,
  });

  @override
  bool canAssign() {
    return assignment.canAssignMap();
  }

  @override
  Expression buildAssignment() {
    final sourceType = assignment.sourceType!;
    final targetType = assignment.targetType;

    final sourceNullable = sourceType.isNullable;

    final sourceKeyType = (sourceType as ParameterizedType).typeArguments.firstOrNull;
    final sourceValueType = sourceType.typeArguments.lastOrNull;

    final targetKeyType = (targetType as ParameterizedType).typeArguments.firstOrNull;
    final targetValueType = targetType.typeArguments.lastOrNull;

    final sourceNullableKey = sourceKeyType?.isNullable ?? false;
    final sourceNullableValue = sourceValueType?.isNullable ?? false;
    final targetNullableKey = targetKeyType?.isNullable ?? false;
    final targetNullableValue = targetValueType?.isNullable ?? false;

    if (targetKeyType == null || targetValueType == null) {
      throw InvalidGenerationSourceError(
        'Target key or value type is null for ${targetType.getDisplayStringWithLibraryAlias(config: assignment.config)}',
      );
    }

    if (sourceKeyType == null || sourceValueType == null) {
      throw InvalidGenerationSourceError(
        'Source key or value type is null for ${sourceType.getDisplayStringWithLibraryAlias(config: assignment.config)}',
      );
    }

    final keyMapping = mapperConfig.findMapping(source: sourceKeyType, target: targetKeyType);
    final valueMapping = mapperConfig.findMapping(source: sourceValueType, target: targetValueType);

    // Keys: source is null, target is not null, and default value does not exist.
    final shouldRemoveNullsKey =
        sourceNullableKey && !targetNullableKey && (!(keyMapping?.hasWhenNullDefault() ?? false));

    // Value: source is null, target is not null, and default value does not exist.
    final shouldRemoveNullsValue =
        sourceNullableValue && !targetNullableValue && (!(valueMapping?.hasWhenNullDefault() ?? false));

    final sourceMapExpression = refer('model').property(assignment.sourceField!.name);

    final defaultMapValueExpression = literalMap(
      {},
      refer(targetKeyType.getDisplayStringWithLibraryAlias(withNullability: true, config: mapperConfig)),
      refer(targetValueType.getDisplayStringWithLibraryAlias(withNullability: true, config: mapperConfig)),
    );

    final assignNestedObjectKey = !targetKeyType.isPrimitiveType && (targetKeyType != sourceKeyType);
    final assignNestedObjectValue = !targetValueType.isPrimitiveType && (targetValueType != sourceValueType);

    final shouldDoMapCall = assignNestedObjectKey || assignNestedObjectValue;

    return sourceMapExpression
        // Filter nulls when source key/value is nullable and target is not.
        .maybeWhereMapNotNull(
      isOnNullable: sourceNullable,
      keyIsNullable: shouldRemoveNullsKey,
      valueIsNullable: shouldRemoveNullsValue,
      keyType: sourceKeyType,
      valueType: sourceValueType,
      config: mapperConfig,
    )
        .maybeCall(
      'map',
      isOnNullable: sourceNullable,
      // Call map only when actually some mapping is required.
      condition: shouldDoMapCall,
      positionalArguments: [_map(assignment)],
      typeArguments: [
        refer(targetKeyType.getDisplayStringWithLibraryAlias(withNullability: true, config: mapperConfig)),
        refer(targetValueType.getDisplayStringWithLibraryAlias(withNullability: true, config: mapperConfig)),
      ],
    )
        // When [sourceNullable], use default value.
        .maybeIfNullThen(defaultMapValueExpression, isOnNullable: sourceNullable);
  }

  Expression _map(SourceAssignment assignment) {
    final sourceKeyType = (assignment.sourceType! as ParameterizedType).typeArguments.firstOrNull;
    final sourceValueType = (assignment.sourceType! as ParameterizedType).typeArguments.lastOrNull;
    final targetKeyType = (assignment.targetType as ParameterizedType).typeArguments.firstOrNull;
    final targetValueType = (assignment.targetType as ParameterizedType).typeArguments.lastOrNull;

    if (targetKeyType == null || targetValueType == null) {
      throw InvalidGenerationSourceError(
        'Target key or value type is null for ${assignment.targetType.getDisplayStringWithLibraryAlias(config: assignment.config)}',
      );
    }

    if (sourceKeyType == null || sourceValueType == null) {
      throw InvalidGenerationSourceError(
        'Source key or value type is null for ${assignment.sourceType?.getDisplayStringWithLibraryAlias(config: assignment.config)}',
      );
    }

    final assignNestedObjectKey = !targetKeyType.isPrimitiveType && (targetKeyType != sourceKeyType);
    final assignNestedObjectValue = !targetValueType.isPrimitiveType && (targetValueType != sourceValueType);

    final keysAreSameType = sourceKeyType == targetKeyType;
    final valuesAreSameType = sourceValueType == targetValueType;

    // Returns a tear off when no nested call is needed.
    if (!assignNestedObjectKey && !assignNestedObjectValue) {
      return refer('MapEntry.new');
    }

    final sourceMapExpression = refer('key');
    final targetMapExpression = refer('value');

    final keyExpression = assignNestedObjectKey
        ? assignNestedObject(
            assignment: assignment,
            source: sourceKeyType,
            target: targetKeyType,
            convertMethodArgument: keysAreSameType ? null : sourceMapExpression,
          )
        : sourceMapExpression;

    final valueExpression = assignNestedObjectValue
        ? assignNestedObject(
            assignment: assignment,
            source: sourceValueType,
            target: targetValueType,
            convertMethodArgument: valuesAreSameType ? null : targetMapExpression,
          )
        : targetMapExpression;

    return refer(
      '(key, value) => MapEntry(${keyExpression.accept(EmitterHelper.current.emitter)}, ${valueExpression.accept(EmitterHelper.current.emitter)})',
    );
  }
}
