import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'left.auto_mappr.dart';
import 'shared.dart';

@AutoMappr([MapType<LeftSource, LeftTarget>()], includes: [SharedMappr()])
class LeftMappr extends $LeftMappr {
  const LeftMappr();
}

class LeftSource {
  final SharedSource shared;

  const LeftSource(this.shared);
}

class LeftTarget with EquatableMixin {
  final SharedTarget shared;

  @override
  List<Object?> get props => [shared];

  const LeftTarget(this.shared);
}
