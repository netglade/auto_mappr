import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

import 'enum_mapping_subset.auto_mappr.dart';

enum Source { a, b }

enum Target { b, c }

@AutoMappr([MapType<Source, Target>()])
class Mappr extends $Mappr {
  const Mappr();
}
