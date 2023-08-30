import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart' as type;
import 'package:auto_mappr/src/builder/assignments/assignment_builder_base.dart';
import 'package:auto_mappr/src/builder/assignments/nested_object_mixin.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/models/source_assignment.dart';
import 'package:build/build.dart';
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
    // TODO(records): assignment.fieldMapping handle -> whenNullExpression, custom
    final sourceType = assignment.sourceType!;
    final targetType = assignment.targetType;

    final sourceRecordType = sourceType as type.RecordType;
    final targetRecordType = targetType as type.RecordType;

    log.warning('''
-- RECORDS --
${sourceRecordType.positionalFields.map((e) => '${e.type}')}
${sourceRecordType.namedFields.map((e) => '${e.type} ${e.name}')}
''');

    // Positional fields check.
    final sourcePositional = sourceRecordType.positionalFields;
    final targetPositional = targetRecordType.positionalFields;
    if (sourcePositional.length != targetPositional.length) {
      throw InvalidGenerationSourceError(
        'Positional source and target fields length mismatch for source $sourceType and target $targetType',
      );
    }

    // Named fields check.
    final sourceNamed = sourceRecordType.namedFields;
    final targetNamed = targetRecordType.namedFields;
    for (final targetField in targetNamed) {
      if (!sourceNamed.any((sourceField) => sourceField.name == targetField.name) &&
          targetField.type.nullabilitySuffix == NullabilitySuffix.none) {
        throw InvalidGenerationSourceError(
          "Cannot find mapping to non-nullable target record's named field $targetField",
        );
      }
    }

    final namedFields = <({String key, String value})>[
      for (final targetField in targetNamed)
        (
          key: targetField.name,
          value: _mapNamedField(
            assignment: assignment,
            source: sourceNamed.firstWhereOrNull((sourceField) => sourceField.name == targetField.name),
            target: targetField,
          ).accept(DartEmitter()).toString(),
        ),
    ];

    return CodeExpression(
      Code(
        '(${namedFields.map((field) => '${field.key}: ${field.value}')})',
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
      return refer('model.${targetRecordExpression.accept(DartEmitter())}.${source.name}');
    }

    final valueExpression = assignNestedObject(
      assignment: assignment,
      source: source.type,
      target: target.type,
      convertMethodArgument: valuesAreSameType ? null : targetRecordExpression,
    );

    return refer('${valueExpression.accept(DartEmitter())})');
  }
}
