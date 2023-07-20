//ignore_for_file: avoid-dynamic

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/builder/auto_mappr_builder.dart';
import 'package:auto_mappr/src/extensions/dart_object_extension.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/extensions/list_extension.dart';
import 'package:auto_mappr/src/models/auto_mappr_options.dart';
import 'package:auto_mappr/src/models/models.dart';
import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';

/// Code generator to generate implemented mapping classes.
class AutoMapprGenerator extends GeneratorForAnnotation<AutoMappr> {
  final BuilderOptions builderOptions;

  const AutoMapprGenerator({required this.builderOptions});

  @override
  dynamic generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '${element.displayName} is not a class and cannot be annotated with @AutoMappr.',
        element: element,
        todo: 'Use @AutoMappr annotation on a class',
      );
    }

    final libraryUriToAlias = _getLibraryAliases(element: element);

    final mapprOptions = AutoMapprOptions.fromJson(builderOptions.config);

    final tmpConfig = AutoMapprConfig(
      mappers: [],
      availableMappingsMacroId: 'tmp',
      libraryUriToAlias: libraryUriToAlias,
      mapprOptions: mapprOptions,
    );

    final constant = annotation.objectValue;
    final mappersField = constant.getField('mappers')!;
    final mappersList = mappersField.toListValue()!;
    final modulesExpression = constant.getField('modules')!.toCodeExpression(config: tmpConfig);
    final modulesList = constant.getField('modules')!.toListValue();

    final mappers = _processMappers(
      mappers: mappersList,
      element: element,
      config: tmpConfig,
    );

    final duplicates = mappers.duplicates;
    if (duplicates.isNotEmpty) {
      throw InvalidGenerationSourceError(
        '@AutoMappr has configured duplicated mappings:\n\t${duplicates.map(
              (e) => e.toStringWithLibraryAlias(config: tmpConfig),
            ).join('\n\t')}',
      );
    }

    final config = AutoMapprConfig(
      mappers: mappers,
      availableMappingsMacroId: element.library.identifier,
      libraryUriToAlias: libraryUriToAlias,
      modulesCode: modulesExpression,
      modulesList: modulesList ?? [],
      mapprOptions: mapprOptions,
    );

    final builder = AutoMapprBuilder(mapperClassElement: element, config: config);

    final output = builder.build();
    final emitter = DartEmitter(orderDirectives: true, useNullSafetySyntax: true);

    return '${output.accept(emitter)}';
  }

  List<TypeMapping> _processMappers({
    required List<DartObject> mappers,
    required ClassElement element,
    required AutoMapprConfig config,
  }) {
    return mappers.map((mapper) {
      final mapperType = mapper.type! as ParameterizedType;

      final sourceType = mapperType.typeArguments.firstOrNull;
      final targetType = mapperType.typeArguments.lastOrNull;

      if (sourceType is! InterfaceType) {
        throw InvalidGenerationSourceError(
          '${sourceType?.getDisplayStringWithLibraryAlias(config: config, withNullability: true)} is not a class and cannot be mapped from',
          element: element,
          todo: 'Use a class',
        );
      }
      if (targetType is! InterfaceType) {
        throw InvalidGenerationSourceError(
          '${targetType?.getDisplayStringWithLibraryAlias(config: config, withNullability: true)} is not a class and cannot be mapped to',
          element: element,
          todo: 'Use a class',
        );
      }

      final fields = mapper.getField('fields')?.toListValue();
      final whenSourceIsNull = mapper.getField('whenSourceIsNull')?.toCodeExpression(config: config);
      final constructor = mapper.getField('constructor')?.toStringValue();
      final ignoreFieldNull = mapper.getField('ignoreFieldNull')?.toBoolValue();

      final fieldMappings = fields
          ?.map(
            (fieldMapping) => FieldMapping(
              field: fieldMapping.getField('field')!.toStringValue()!,
              ignore: fieldMapping.getField('ignore')!.toBoolValue()!,
              from: fieldMapping.getField('from')!.toStringValue(),
              customExpression:
                  fieldMapping.getField('custom')!.toCodeExpression(passModelArgument: true, config: config),
              whenNullExpression: fieldMapping.getField('whenNull')!.toCodeExpression(config: config),
              ignoreNull: fieldMapping.getField('ignoreNull')?.toBoolValue(),
            ),
          )
          .toList();

      return TypeMapping(
        source: sourceType,
        target: targetType,
        fieldMappings: fieldMappings,
        whenSourceIsNullExpression: whenSourceIsNull,
        constructor: constructor,
        ignoreFieldNull: ignoreFieldNull,
      );
    }).toList();
  }

  Map<String, String> _getLibraryAliases({required ClassElement element}) {
    final libraryUriToAlias = <String, String>{};

    final imports = element.library.libraryImports;
    final aliases = imports.map((e) => e.prefix?.element.name).toList();
    final uris = imports.map((e) => e.importedLibrary!.identifier).toList();

    for (var i = 0; i < imports.length; i++) {
      final currentAlias = aliases.elementAtOrNull(i);
      if (currentAlias == null) continue;

      final importedLibrary = imports.elementAtOrNull(i)?.importedLibrary;
      final exports = importedLibrary == null ? <LibraryElement>[] : _getRecursiveLibraryExports(importedLibrary);

      final uri = uris.elementAtOrNull(i);

      libraryUriToAlias.addAll({
        // Current library.
        if (uri != null) uri: currentAlias,
        // It's exports.
        for (final exported in exports) exported.identifier: currentAlias,
      });
    }

    return libraryUriToAlias;
  }

  /// Recursively returns all exports (even nested) for [library].
  Iterable<LibraryElement> _getRecursiveLibraryExports(LibraryElement library) {
    final exports = library.libraryExports;
    if (exports.isEmpty) return [];

    return [
      ...exports.map((e) => e.exportedLibrary!),
      ...exports.map((e) => _getRecursiveLibraryExports(e.exportedLibrary!)).flattened,
    ];
  }
}
