import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

class AutoMapPart extends Equatable {
  final DartType source;
  final DartType target;
  final bool isReverse;
  final List<MemberMapping>? mappings;

  String sourceName({bool withNullability = false}) => source.getDisplayString(withNullability: withNullability);

  String targetName({bool withNullability = false}) => target.getDisplayString(withNullability: withNullability);

  Reference get sourceRefer => refer(source.getDisplayString(withNullability: true));

  Reference get targetRefer => refer(target.getDisplayString(withNullability: true));

  String get mappingMapMethodName =>
      '_map${source.getDisplayString(withNullability: false)}To${target.getDisplayString(withNullability: false)}';

  bool hasMapping(String member) => mappings?.any((x) => x.member == member) ?? false;

  MemberMapping getMapping(String member) => mappings!.firstWhere((x) => x.member == member);

  MemberMapping? tryGetMapping(String member) => mappings?.firstWhereOrNull((x) => x.member == member);

  bool memberShouldBeIgnored(String member) => hasMapping(member) && getMapping(member).ignore;

  AutoMapPart({
    required this.source,
    required this.target,
    required this.isReverse,
    required this.mappings,
  });

  @override
  String toString() {
    return '$source -> $target';
  }

  @override
  List<Object?> get props => [source, target, isReverse, mappings];
}

class MemberMapping extends Equatable {
  final String member;
  final ExecutableElement? target;
  final bool ignore;

  const MemberMapping({
    required this.member,
    this.target,
    required this.ignore,
  });

  @override
  List<Object?> get props => [member, target, ignore];
}
