import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart' as type;
import 'package:auto_mappr/src/builder/assignments/assignment_builder_base.dart';
import 'package:auto_mappr/src/builder/assignments/nested_object_mixin.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/helpers/emitter_helper.dart';
import 'package:auto_mappr/src/models/source_assignment.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';

class RecordAssignmentBuilder extends AssignmentBuilderBase with NestedObjectMixin {
  const RecordAssignmentBuilder({
    required super.assignment,
    required super.mapperConfig,
    required super.mapping,
    required super.usedNullableMethodCallback,
  });

  @override
  bool canAssign() {
    return assignment.canAssignRecord();
  }

  @override
  Expression buildAssignment() {
    final sourceType = assignment.sourceType!;
    final targetType = assignment.targetType;

    final sourceRecordType = sourceType as type.RecordType;
    final targetRecordType = targetType as type.RecordType;

    final sourcePositional = sourceRecordType.positionalFields;
    final targetPositional = targetRecordType.positionalFields;

    // Positional fields check.
    for (final (index, targetField) in targetPositional.indexed) {
      final sourceField = sourcePositional.elementAtOrNull(index);
      if (sourceField == null && targetField.type.nullabilitySuffix == NullabilitySuffix.none) {
        throw InvalidGenerationSourceError(
          'Cannot map positional source field to non-nullable target field for source $sourceType and target $targetType. ($mapping)',
        );
      }
    }

    // Named fields check.
    final sourceNamed = sourceRecordType.namedFields;
    final targetNamed = targetRecordType.namedFields;
    for (final targetField in targetNamed) {
      if (!sourceNamed.any((sourceField) => sourceField.name == targetField.name) &&
          targetField.type.nullabilitySuffix == NullabilitySuffix.none) {
        throw InvalidGenerationSourceError(
          "Cannot find mapping to non-nullable target record's named field $targetField. ($mapping)",
        );
      }
    }

    final positionalFields = <String>[
      for (final (index, targetField) in targetPositional.indexed)
        _mapPositionalField(
          assignment: assignment,
          source: sourcePositional.elementAtOrNull(index),
          target: targetField,
          index: index + 1,
        ).accept(EmitterHelper.current.emitter).toString(),
    ];

    final namedFields = <({String key, String value})>[
      for (final targetField in targetNamed)
        (
          key: targetField.name,
          value: _mapNamedField(
            assignment: assignment,
            source: sourceNamed.firstWhereOrNull((sourceField) => sourceField.name == targetField.name),
            target: targetField,
          ).accept(EmitterHelper.current.emitter).toString(),
        ),
    ];

    return CodeExpression(
      Code(
        '(${positionalFields.join(',')} ${positionalFields.isNotEmpty ? ',' : ''} ${namedFields.map((field) => '${field.key}: ${field.value}').join(',')})',
      ),
    );
  }

  // Handles mapping of only one named field.
  //
  // Generates
  // - mapping for primitives: `model.alpha`
  // - mapping for complex types: `_map_NestedDto_To_Nested(model.alpha)`
  // - and when nullable and if `whenNullExpression` defined, uses that as a fallback
  Expression _mapNamedField({
    required SourceAssignment assignment,
    required type.RecordTypeNamedField? source,
    required type.RecordTypeNamedField target,
  }) {
    if (source == null) return literalNull;

    final valuesAreSameType = source.type == target.type;
    final shouldAssignNestedObject = !target.type.isPrimitiveType && !valuesAreSameType;

    final targetRecordExpression = refer(assignment.sourceField!.name);

    if (!shouldAssignNestedObject) {
      return refer('model.${targetRecordExpression.accept(EmitterHelper.current.emitter)}.${source.name}');
    }

    final valueExpression = assignNestedObject(
      assignment: assignment,
      source: source.type,
      target: target.type,
      convertMethodArgument: valuesAreSameType ? null : targetRecordExpression,
    );

    return refer('${valueExpression.accept(EmitterHelper.current.emitter)})');
  }

  // Handles mapping of only one positional field.
  //
  // Generates
  // - mapping for primitives: `model.$1`
  // - mapping for complex types: `_map_NestedDto_To_Nested(model.$1)`
  // - and when nullable and if `whenNullExpression` defined, uses that as a fallback
  Expression _mapPositionalField({
    required SourceAssignment assignment,
    required type.RecordTypePositionalField? source,
    required type.RecordTypePositionalField target,
    required int index,
  }) {
    if (source == null) return literalNull;

    final valuesAreSameType = source.type == target.type;
    final shouldAssignNestedObject = !target.type.isPrimitiveType && !valuesAreSameType;

    final targetRecordExpression = refer(assignment.sourceField!.name);

    if (!shouldAssignNestedObject) {
      return refer('model.${targetRecordExpression.accept(EmitterHelper.current.emitter)}.\$$index');
    }

    final valueExpression = assignNestedObject(
      assignment: assignment,
      source: source.type,
      target: target.type,
      convertMethodArgument: valuesAreSameType ? null : targetRecordExpression,
    );

    return refer('${valueExpression.accept(EmitterHelper.current.emitter)})');
  }
}
