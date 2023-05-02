import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/models/source_assignment.dart';
import 'package:code_builder/code_builder.dart';
import 'package:equatable/equatable.dart';
import 'package:source_gen/source_gen.dart';

class TypeConversion extends Equatable {
  final DartType sourceType;
  final DartType targetType;
  final Expression convertExpression;
  final String? field;

  @override
  List<Object?> get props => [sourceType, targetType, convertExpression, field];

  const TypeConversion({
    required this.sourceType,
    required this.targetType,
    required this.convertExpression,
    required this.field,
  });

  /// Wether this type conversion applies to the the given [SourceAssignment].
  bool matchesAssignment(SourceAssignment assignment) {
    final typeMatches = assignment.sourceType != null &&
        assignment.sourceType!.isAssignableTo(sourceType) &&
        assignment.targetType.isAssignableTo(targetType);
    final nameMatches = field == null || assignment.sourceName == field;

    return typeMatches && nameMatches;
  }

  Expression apply(SourceAssignment assignment) {
    final assignmentSourceNullable = assignment.sourceType?.nullabilitySuffix != NullabilitySuffix.none;
    final assignmentTargetNullable = assignment.targetType.nullabilitySuffix != NullabilitySuffix.none;
    final sourceNullable = sourceType.nullabilitySuffix != NullabilitySuffix.none;
    final targetNullable = targetType.nullabilitySuffix != NullabilitySuffix.none;
    final whenNullExpression = assignment.fieldMapping?.whenNullExpression;

    final sourceExpression = refer('model').property(assignment.sourceName!);

    if((assignmentSourceNullable || targetNullable) && !assignmentTargetNullable && whenNullExpression == null) {
      throw InvalidGenerationSourceError(
        'Cannot convert nullable source type to non-nullable target type requirement without a default value.',
        element: assignment.sourceField,
      );
    }

    if(assignmentSourceNullable && !sourceNullable) {
      return sourceExpression.notEqualTo(literalNull).conditional(
        convertExpression.call([sourceExpression.nullChecked]),
        whenNullExpression ?? literalNull,
      );
    } else {
      final expression = convertExpression.call([sourceExpression]);

      if(targetNullable) {
        return expression.ifNullThen(whenNullExpression!);
      }

      return expression;
    }
  }
}
