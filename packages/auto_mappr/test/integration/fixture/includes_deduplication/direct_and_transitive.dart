import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

import 'direct_and_transitive.auto_mappr.dart';
import 'left.dart';
import 'shared.dart';

// SharedMappr is reached both directly and through an include:
//
// - DirectAndTransitiveMappr (this one)
//   - SharedMappr
//   - LeftMappr
//     - SharedMappr
@AutoMappr([], includes: [SharedMappr(), LeftMappr()])
class DirectAndTransitiveMappr extends $DirectAndTransitiveMappr {
  const DirectAndTransitiveMappr();
}
