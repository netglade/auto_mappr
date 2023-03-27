import 'package:auto_mappr/src/models/source_assignment.dart';
import 'package:code_builder/code_builder.dart';
import 'package:equatable/equatable.dart';
import 'package:source_gen/source_gen.dart';

class FieldMapping extends Equatable {
  final String field;
  final bool ignore;
  final String? from;
  final Expression? customExpression;
  final Expression? whenNullExpression;

  @override
  List<Object?> get props => [
        field,
        ignore,
        from,
        customExpression,
        whenNullExpression,
      ];

  const FieldMapping({
    required this.field,
    required this.ignore,
    this.from,
    this.customExpression,
    this.whenNullExpression,
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

  bool canBeApplied(SourceAssignment _) {
    if (ignore || hasCustomMapping()) return true;

    // source is null and whenNullDefault is set -> can be applied
    // if (assignment.sourceField?.type.nullabilitySuffix == NullabilitySuffix.question && whenNullDefault != null)
    //   return true;

    return false;
  }

  Expression apply(SourceAssignment assignment) {
    if (ignore) {
      return assignment.getDefaultValue();
    }

    if (hasCustomMapping()) {
      return customExpression!;
    }

    throw InvalidGenerationSourceError(
      'Field mapping for field "$field" from $assignment has ignore=false and no custom mapping.',
      todo: 'Either set ignore to true or define a custom mapping.',
    );
  }
}
