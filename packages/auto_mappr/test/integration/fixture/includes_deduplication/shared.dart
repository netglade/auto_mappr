import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'shared.auto_mappr.dart';

/// A mappr that is meant to be included by more than one other mappr.
@AutoMappr(
  [MapType<SharedSource, SharedTarget>()],
  converters: [TypeConverter<int, String>(SharedMappr.intToString)],
)
class SharedMappr extends $SharedMappr {
  const SharedMappr();

  static String intToString(int source) => 'n$source';
}

class SharedSource {
  final int number;

  const SharedSource(this.number);
}

class SharedTarget with Equatable {
  final String number;

  @override
  List<Object?> get props => [number];

  const SharedTarget(this.number);
}
