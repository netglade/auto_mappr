import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'right.auto_mappr.dart';
import 'shared.dart';

@AutoMappr([MapType<RightSource, RightTarget>()], includes: [SharedMappr()])
class RightMappr extends $RightMappr {
  const RightMappr();
}

class RightSource {
  final SharedSource shared;

  const RightSource(this.shared);
}

class RightTarget with EquatableMixin {
  final SharedTarget shared;

  @override
  List<Object?> get props => [shared];

  const RightTarget(this.shared);
}
