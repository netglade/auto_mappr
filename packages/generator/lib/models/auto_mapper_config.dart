import 'package:automapper_generator/models/auto_map_part.dart';
import 'package:collection/collection.dart';

class AutoMapperConfig {
  final List<AutoMapPart> parts;

  AutoMapperConfig({
    required this.parts,
  });

  bool existsMorePreciseReverseMapping(AutoMapPart mapping) => getMorePreciseReverseMapping(mapping) != null;

  AutoMapPart? getMorePreciseReverseMapping(AutoMapPart mapping) {
    final others = parts.where((element) => element != mapping).toList();

    final specific = others.firstWhereOrNull((o) => o.target == mapping.source && o.source == mapping.target);

    return specific;
  }
}
