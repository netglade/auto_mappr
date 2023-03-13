import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mapper/models/auto_map_part.dart';
import 'package:auto_mapper/models/extensions.dart';
import 'package:collection/collection.dart';

//todo (tests)
class AutoMapperConfig {
  final List<AutoMapPart> parts;

  const AutoMapperConfig({
    required this.parts,
  });

  AutoMapPart? findMapping({required DartType source, required DartType target}) {
    return parts.firstWhereOrNull((x) {
      if (x.source.isSameExceptNullability(source) && x.target.isSameExceptNullability(target)) return true;

      // if (x.source.element == source && x.target == target) return true;

      return false;
    });
  }
}
