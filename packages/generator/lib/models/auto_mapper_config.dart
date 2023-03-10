import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mapper_generator/models/auto_map_part.dart';
import 'package:auto_mapper_generator/models/extensions.dart';
import 'package:collection/collection.dart';

class AutoMapperConfig {
  final List<AutoMapPart> parts;

  AutoMapperConfig({
    required this.parts,
  });

  bool explicitReverseMappingExists(AutoMapPart mapping) => getExplicitReverseMapping(mapping) != null;

  AutoMapPart? getExplicitReverseMapping(AutoMapPart mapping) {
    final others = parts.where((element) => element != mapping).toList();

    return others.firstWhereOrNull((o) => o.target == mapping.source && o.source == mapping.target);
  }

  bool reverseMappingExists(AutoMapPart mapping) => mapping.isReverse || explicitReverseMappingExists(mapping);

  AutoMapPart? findMapping({required DartType source, required DartType target}) {
    return parts.firstWhereOrNull((x) {
      if (x.source.isSameExceptNullability(source) && x.target.isSameExceptNullability(target)) return true;

      if (x.isReverse && x.source.isSameExceptNullability(target) && x.target.isSameExceptNullability(source))
        return true;
      // if (x.source.element == source && x.target == target) return true;

      // if (x.isReverse && x.source == target && x.target == source) return true;

      return false;
    });
  }
}
