import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

import 'enum_mapping_not_enum.auto_mappr.dart';

enum Source { a, b }

class Target {
  final int a;
  final int b;

  const Target({required this.a, required this.b});
}

@AutoMappr([MapType<Source, Target>()])
class Mappr extends $Mappr {
  const Mappr();
}
