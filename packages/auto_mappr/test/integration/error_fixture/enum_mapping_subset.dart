import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

part 'enum_mapping_subset.g.dart';

enum Source { a, b }

enum Target { b, c }

@AutoMappr([MapType<Source, Target>()])
class Mappr extends $Mappr {
  const Mappr();
}
