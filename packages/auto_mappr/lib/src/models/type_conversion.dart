import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/models/source_assignment.dart';
import 'package:code_builder/code_builder.dart';
import 'package:equatable/equatable.dart';

class TypeConversion extends Equatable {
  final DartType source;
  final DartType target;
  final Expression convertExpression;
  final String? field;

  @override
  List<Object?> get props => [source, target, convertExpression, field];

  const TypeConversion({
    required this.source,
    required this.target,
    required this.convertExpression,
    required this.field,
  });

  /// Wether this type conversion applies to the the given [SourceAssignment].
  bool matchesAssignment(SourceAssignment assignment) {
    final typeMatches = assignment.sourceType != null &&
        assignment.sourceType!.isSame(source) &&
        assignment.targetType.isSame(target);
    final nameMatches = field == null || assignment.sourceName == field;

    return typeMatches && nameMatches;
  }

  Expression apply(SourceAssignment assignment) {
    if (assignment.sourceType?.nullabilitySuffix == NullabilitySuffix.question &&
        target.nullabilitySuffix == NullabilitySuffix.none) {
      return refer('model')
          .property(assignment.sourceName!)
          .notEqualTo(literalNull)
          .conditional(
            convertExpression.call([
              refer('model').property(assignment.sourceName!).nullChecked,
            ]),
            literalNull,
          );
    }

    return convertExpression.call([
      refer('model').property(assignment.sourceName!),
    ]);
  }
}
