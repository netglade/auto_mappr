import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mapper/models/dart_type_extension.dart';
import 'package:auto_mapper/models/type_mapping.dart';
import 'package:collection/collection.dart';

class AutoMapperConfig {
  final List<TypeMapping> parts;

  const AutoMapperConfig({
    required this.parts,
  });

  TypeMapping? findMapping({
    required DartType source,
    required DartType target,
  }) {
    return parts.firstWhereOrNull((x) {
      if (x.source.isSameExceptNullability(source) && x.target.isSameExceptNullability(target)) return true;

      // if (x.source.element == source && x.target == target) return true;

      return false;
    });
  }
}
