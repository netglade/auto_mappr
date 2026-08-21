import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'includes_deduplication.auto_mappr.dart';
import 'includes_deduplication/left.dart';
import 'includes_deduplication/right.dart';

// SharedMappr is reached through two sibling branches:
//
// - DiamondMappr (this one)
//   - LeftMappr
//     - SharedMappr
//   - RightMappr
//     - SharedMappr
@AutoMappr([MapType<PairSource, PairTarget>()], includes: [LeftMappr(), RightMappr()])
class DiamondMappr extends $DiamondMappr {
  const DiamondMappr();
}

class PairSource {
  final LeftSource left;
  final RightSource right;

  const PairSource(this.left, this.right);
}

class PairTarget with EquatableMixin {
  final LeftTarget left;
  final RightTarget right;

  @override
  List<Object?> get props => [left, right];

  const PairTarget(this.left, this.right);
}
