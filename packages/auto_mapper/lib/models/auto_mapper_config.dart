import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mapper/models/dart_type_extension.dart';
import 'package:auto_mapper/models/type_mapping.dart';
import 'package:collection/collection.dart';

class AutoMapperConfig {
  final List<TypeMapping> mappers;

  const AutoMapperConfig({
    required this.mappers,
  });

  TypeMapping? findMapping({
    required DartType source,
    required DartType target,
  }) {
    return mappers.firstWhereOrNull((mapper) {
      if (mapper.source.isSameExceptNullability(source) && mapper.target.isSameExceptNullability(target)) return true;

      // if (x.source.element == source && x.target == target) return true;

      return false;
    });
  }
}
