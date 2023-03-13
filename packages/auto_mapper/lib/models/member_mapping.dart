import 'package:analyzer/dart/element/element.dart';
import 'package:auto_mapper/models/extensions.dart';
import 'package:auto_mapper/models/source_assignment.dart';
import 'package:code_builder/code_builder.dart';
import 'package:equatable/equatable.dart';
import 'package:source_gen/source_gen.dart';

class MemberMapping extends Equatable {
  final String member;
  final ExecutableElement? custom;
  final ExecutableElement? whenNullDefault;
  final bool ignore;
  final String? rename;

  @override
  List<Object?> get props => [member, custom, ignore, whenNullDefault, rename];

  const MemberMapping({
    required this.member,
    this.custom,
    this.whenNullDefault,
    required this.ignore,
    this.rename,
  });

  bool canBeApplied(SourceAssignment assignment) {
    if (ignore || custom != null) return true;

    // source is null and whenNullDefault is set -> can be applied
    // if (assignment.sourceField?.type.nullabilitySuffix == NullabilitySuffix.question && whenNullDefault != null)
    //   return true;

    return false;
  }

  Expression apply(SourceAssignment assignment) {
    if (ignore) {
      return assignment.getDefaultValue();
    }

    // Support Function mapping
    final _custom = custom;
    if (_custom != null) {
      final callRefer = _custom.referCallString;

      return refer(callRefer).call([refer('model')]);
    }

    final _rename = rename;
    if (_rename != null) {
      return refer('model').property(_rename);
    }

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
