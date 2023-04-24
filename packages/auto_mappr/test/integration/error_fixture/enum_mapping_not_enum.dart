import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

part 'enum_mapping_not_enum.g.dart';

enum Source { a, b }

class Target {
  final int a;
  final int b;

  Target({
    required this.a,
    required this.b,
  });
}

@AutoMappr([MapType<Source, Target>()])
class Mappr extends $Mappr {}
