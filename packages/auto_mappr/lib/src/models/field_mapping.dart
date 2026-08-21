import 'package:auto_mappr/src/models/source_assignment.dart';
import 'package:code_builder/code_builder.dart';
import 'package:equatable/equatable.dart';
import 'package:source_gen/source_gen.dart';

class FieldMapping with EquatableMixin {
  final String field;
  final bool ignore;
  final String? from;
  final Expression? customExpression;
  final Expression? whenNullExpression;
  final bool? ignoreNull;

  @override
  List<Object?> get props => [
    field,
    ignore,
    from,
    customExpression,
    whenNullExpression,
    ignoreNull,
  ];

  const FieldMapping({
    required this.field,
    required this.ignore,
    required this.ignoreNull,
    this.from,
    this.customExpression,
    this.whenNullExpression,
  });

  bool hasCustomMapping() {
    return customExpression != null;
  }

  bool canBeApplied(SourceAssignment _) {
    if (ignore || hasCustomMapping()) return true;

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
