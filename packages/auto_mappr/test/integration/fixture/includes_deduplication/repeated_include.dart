import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

import 'repeated_include.auto_mappr.dart';
import 'shared.dart';

// The same mappr is listed twice in the same includes list.
@AutoMappr([], includes: [SharedMappr(), SharedMappr()])
class RepeatedIncludeMappr extends $RepeatedIncludeMappr {
  const RepeatedIncludeMappr();
}
