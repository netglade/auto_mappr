import 'package:auto_mappr/src/models/source_assignment.dart';
import 'package:auto_mappr/src/models/type_conversion.dart';
import 'package:code_builder/code_builder.dart';
import 'package:equatable/equatable.dart';
import 'package:source_gen/source_gen.dart';

class FieldMapping extends Equatable {
  final String field;
  final bool ignore;
  final String? from;
  final Expression? customExpression;
  final Expression? whenNullExpression;
  final TypeConversion? typeConversion;

  @override
  List<Object?> get props => [
        field,
        ignore,
        from,
        customExpression,
        whenNullExpression,
        typeConversion,
      ];

  const FieldMapping({
    required this.field,
    required this.ignore,
    required this.from,
    required this.customExpression,
    required this.whenNullExpression,
    required this.typeConversion,
  });

  bool isRenamed() {
    return from != null;
  }

  bool hasWhenNullDefault() {
    return whenNullExpression != null;
  }

  bool hasCustomMapping() {
    return customExpression != null;
  }

  bool hasTypeConversion(SourceAssignment assignment) {
    return typeConversion != null && typeConversion!.matchesAssignment(assignment);
  }

  bool canBeApplied(SourceAssignment assignment) {
    if (ignore || hasCustomMapping() || hasTypeConversion(assignment) || assignment.hasTypeConversion()) return true;

    return false;
  }

  Expression apply(SourceAssignment assignment) {
    if (ignore) {
      return assignment.getDefaultValue();
    }

    if (hasCustomMapping()) {
      return customExpression!;
    }

    if (hasTypeConversion(assignment)) {
      return typeConversion!.apply(assignment);
    }

    if (assignment.hasTypeConversion()) {
      return assignment.getTypeConversion().apply(assignment);
    }

    throw InvalidGenerationSourceError(
      'Field mapping for field "$field" from $assignment has ignore=false and no custom mapping.',
      todo: 'Either set ignore to true or define a custom mapping.',
    );
  }
}
