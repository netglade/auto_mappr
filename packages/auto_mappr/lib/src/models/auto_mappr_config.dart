import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/models/type_mapping.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';

class AutoMapprConfig {
  final List<TypeMapping> mappers;
  final String availableMappingsMacroId;
  final Expression? modules;

  String get availableMappingsMacroDocComment => '/// {@macro $availableMappingsMacroId}';

  const AutoMapprConfig({
    required this.mappers,
    required this.availableMappingsMacroId,
    this.modules,
  });

  TypeMapping? findMapping({
    required DartType source,
    required DartType target,
  }) {
    return mappers.firstWhereOrNull(
      (mapper) => mapper.source.isSame(source) && mapper.target.isSame(target),
    );
  }

  Iterable<String> getAvailableMappingsDocComment() {
    return [
      '/// {@template $availableMappingsMacroId}',
      '/// Available mappings:',
      for (final mapper in mappers) _getTypeMappingDocs(mapper),
      '/// {@endtemplate}'
    ];
  }

  String _getTypeMappingDocs(TypeMapping typeMapping) {
    final trailingPart = typeMapping.hasWhenNullDefault() ? ' -- With default value.' : '.';

    // ignore: avoid-non-ascii-symbols, it is ok
    return '/// - `${typeMapping.source}` → `${typeMapping.target}`$trailingPart';
  }
}
