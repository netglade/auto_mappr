import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import 'member_mapping.dart';

class AutoMapPart extends Equatable {
  final DartType source;
  final DartType target;
  final List<MemberMapping>? mappings;
  final ExecutableElement? whenNullDefault;
  final String? constructor;

  String get mappingMapMethodName =>
      '_map${source.getDisplayString(withNullability: false)}To${target.getDisplayString(withNullability: false)}';

  @override
  List<Object?> get props {
    return [
      source,
      target,
      mappings,
      whenNullDefault,
      constructor,
    ];
  }

  const AutoMapPart({
    required this.source,
    required this.target,
    required this.mappings,
    this.whenNullDefault,
    this.constructor,
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
