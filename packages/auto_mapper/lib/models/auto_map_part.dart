import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mapper_generator/models/extensions.dart';
import 'package:auto_mapper_generator/models/source_assignment.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:source_gen/source_gen.dart';

class AutoMapPart extends Equatable {
  final DartType source;
  final DartType target;
  final bool isReverse;
  final List<MemberMapping>? mappings;
  final ExecutableElement? whenNullDefault;

  Reference get sourceRefer => refer(source.getDisplayString(withNullability: true));

  Reference get targetRefer => refer(target.getDisplayString(withNullability: true));

  String get mappingMapMethodName =>
      '_map${source.getDisplayString(withNullability: false)}To${target.getDisplayString(withNullability: false)}';

  @override
  List<Object?> get props {
    return [
      source,
      target,
      isReverse,
      mappings,
      whenNullDefault,
    ];
  }

  const AutoMapPart({
    required this.source,
    required this.target,
    required this.isReverse,
    required this.mappings,
    this.whenNullDefault,
  });

  String sourceName({bool withNullability = false}) => source.getDisplayString(withNullability: withNullability);

  String targetName({bool withNullability = false}) => target.getDisplayString(withNullability: withNullability);

  bool hasMapping(String member) => mappings?.any((x) => x.member == member) ?? false;

  MemberMapping getMapping(String member) => mappings!.firstWhere((x) => x.member == member);

  MemberMapping? tryGetMapping(String member) => mappings?.firstWhereOrNull((x) => x.member == member);

  bool memberShouldBeIgnored(String member) => hasMapping(member) && getMapping(member).ignore;

  @override
  String toString() {
    return '$source -> $target';
  }
}

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
    //    final callRefer = _whenNullDefault.referCallString;

    //   return refer(callRefer).call([refer('model')]);
    // }

    throw InvalidGenerationSourceError(
      'MemberMapping for member "${member}" from ${assignment} has ignore=false and target=null',
      todo: 'Set ignore=true or define custom mapping',
    );
  }
}
