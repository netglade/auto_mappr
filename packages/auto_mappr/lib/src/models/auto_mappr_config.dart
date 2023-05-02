import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/models/models.dart';
import 'package:auto_mappr/src/models/type_conversion.dart';
import 'package:collection/collection.dart';

class AutoMapprConfig {
  final List<TypeMapping> mappers;
  final List<TypeConversion> typeConversions;
  final String availableMappingsMacroId;
  final Map<String, String> libraryUriToAlias;

  String get availableMappingsMacroDocComment => '/// {@macro $availableMappingsMacroId}';

  const AutoMapprConfig({
    required this.mappers,
    required this.typeConversions,
    required this.availableMappingsMacroId,
    required this.libraryUriToAlias,
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

  bool hasTypeConversion(SourceAssignment assignment) {
    return typeConversions.any((element) => element.matchesAssignment(assignment));
  }

  TypeConversion getTypeConversion(SourceAssignment assignment) {
    return typeConversions.firstWhere((element) => element.matchesAssignment(assignment));
  }

  String _getTypeMappingDocs(TypeMapping typeMapping) {
    final trailingPart = typeMapping.hasWhenNullDefault() ? ' -- With default value.' : '.';

    // ignore: avoid-non-ascii-symbols, it is ok
    return '/// - `${typeMapping.source.getDisplayStringWithLibraryAlias(
      config: this,
    )}` → `${typeMapping.target.getDisplayStringWithLibraryAlias(
      config: this,
    )}`$trailingPart';
  }
}
