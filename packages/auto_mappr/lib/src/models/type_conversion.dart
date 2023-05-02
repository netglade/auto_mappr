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

  @override
  List<Object?> get props => [source, target, convertExpression];

  const TypeConversion({
    required this.source,
    required this.target,
    required this.convertExpression,
  });

  /// Wether this type conversion applies to the source and target types.
  bool matches(DartType? source, DartType? target) {
    return source != null && target != null && source.isSame(this.source) && target.isSame(this.target);
  }

  /// Wether this type conversion applies to the source and target types of the given assignment.
  bool matchesAssignment(SourceAssignment assignment) {
    return matches(assignment.sourceType, assignment.targetType);
  }

  Expression apply(SourceAssignment assignment) {
    if(assignment.sourceType?.nullabilitySuffix == NullabilitySuffix.question && target.nullabilitySuffix == NullabilitySuffix.none) {
      return refer('model').property(assignment.sourceName!).notEqualTo(literalNull).conditional(
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
