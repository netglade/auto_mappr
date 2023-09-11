import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

import 'module_alpha.auto_mappr.dart';

@AutoMappr([], converters: [TypeConverter<int, bool>(MapprAlpha.intToBool)])
class MapprAlpha extends $MapprAlpha {
  const MapprAlpha();

  static bool intToBool(int source) {
    return source == 1;
  }
}
