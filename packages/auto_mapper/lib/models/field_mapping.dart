import 'package:auto_mapper/models/source_assignment.dart';
import 'package:code_builder/code_builder.dart';
import 'package:equatable/equatable.dart';
import 'package:source_gen/source_gen.dart';

class FieldMapping extends Equatable {
  final String member;
  final bool ignore;
  final String? from;
  final Expression? customExpression;
  final Expression? whenNullExpression;

  @override
  List<Object?> get props => [
        member,
        ignore,
        from,
        customExpression,
        whenNullExpression,
      ];

  const FieldMapping({
    required this.member,
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

  bool canBeApplied(SourceAssignment assignment) {
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

    // if (isRenamed()) {
    //   return refer('model').property(from!);
    // }

    // final _whenNullDefault = whenNullDefault;

    // if (_whenNullDefault != null) {
    //   final callRefer = _whenNullDefault.referCallString;

    //   return refer(callRefer).call([refer('model')]);
    // }

    // final _whenNullDefault = whenNullDefault;
    // if (assignment.sourceField?.type.nullabilitySuffix == NullabilitySuffix.question && _whenNullDefault != null) {
    //   return refer('model').property(assignment.sourceField!.displayName).equalTo(refer('null')).conditional(
    //         refer(_whenNullDefault.referCallString).call([]),
    //         convertCallExpr,
    //       );
    // }

    throw InvalidGenerationSourceError(
      'MemberMapping for member "${member}" from ${assignment} has ignore=false and target=null',
      todo: 'Set ignore=true or define custom mapping',
    );
  }
}
