import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/extensions/dart_type_extension.dart';
import 'package:auto_mappr/models/type_mapping.dart';
import 'package:collection/collection.dart';

class AutoMapprConfig {
  final List<TypeMapping> mappers;

  const AutoMapprConfig({
    required this.mappers,
  });

  TypeMapping? findMapping({
    required DartType source,
    required DartType target,
  }) {
    return mappers.firstWhereOrNull(
      (mapper) => mapper.source.isSameExceptNullability(source) && mapper.target.isSameExceptNullability(target),
    );
  }
}
