import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/extensions/element_extension.dart';
import 'package:auto_mappr/src/models/type_mapping.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';

class AutoMapprConfig {
  final List<TypeMapping> mappers;
  final String availableMappingsMacroId;
  final Expression? modulesCode;
  final List<DartObject> modulesList;
  final Map<String, String> libraryUriToAlias;

  String get availableMappingsDocComment {
    return [
      '/// {@macro $availableMappingsMacroId}',
      ..._modulesDocComment(),
    ].join('\n');
  }

  const AutoMapprConfig({
    required this.mappers,
    required this.availableMappingsMacroId,
    required this.libraryUriToAlias,
    this.modulesCode,
    this.modulesList = const [],
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
      '/// {@endtemplate}',
      ..._modulesDocComment(),
    ];
  }

  List<String> _modulesDocComment() {
    return [
      if (modulesList.isNotEmpty) ...[
        '///',
        "/// Available modules: ${modulesList.map((e) {
          final alias = e.type!.element!.getLibraryAlias(config: this);

          return '[$alias\$${e.type!.getDisplayString(withNullability: false)}]';
        }).join(', ')}",
      ],
    ];
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
