import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/models/type_mapping.dart';
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
      (mapper) => mapper.source.isSame(source) && mapper.target.isSame(target),
    );
  }
}
