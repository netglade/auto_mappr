//ignore_for_file: avoid-dynamic

import 'dart:async';

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/builder/auto_mappr_builder.dart';
import 'package:auto_mappr/src/extensions/dart_object_extension.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/extensions/list_extension.dart';
import 'package:auto_mappr/src/helpers/emitter_helper.dart';
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

  // Constants for AutoMappr.
  static const String annotationAutoMappr = 'AutoMappr';
  static const String annotationFieldDelegates = 'delegates';
  static const String annotationFieldMappers = 'mappers';
  static const String annotationFieldIncludes = 'includes';

  // Constants for MapType.
  static const String mapTypeFieldFields = 'fields';
  static const String mapTypeFieldWhenSourceIsNull = 'whenSourceIsNull';
  static const String mapTypeFieldConstructor = 'constructor';
  static const String mapTypeFieldIgnoreFieldNull = 'ignoreFieldNull';
  static const String mapTypeFieldReverse = 'reverse';

  // Constants for Field.
  static const String fieldFieldField = 'field';
  static const String fieldFieldIgnore = 'ignore';
  static const String fieldFieldFrom = 'from';
  static const String fieldFieldCustom = 'custom';
  static const String fieldFieldWhenNull = 'whenNull';
  static const String fieldFieldIgnoreNull = 'ignoreNull';

  const AutoMapprGenerator({required this.builderOptions});

  @override
  dynamic generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    final filePath = element.library?.identifier;
    final fileUri = filePath != null ? Uri.parse(filePath) : null;

    // We need to use zones so we can easily have "scoped globals" for EmitterHelper.
    return runZoned(
      () {
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
        final mappersList = constant.getField(annotationFieldMappers)!.toListValue()!;
        final delegatesExpression = constant.getField(annotationFieldDelegates)!.toCodeExpression(config: tmpConfig);
        final delegatesList = constant.getField(annotationFieldDelegates)!.toListValue();
        final includesList = constant.getField(annotationFieldIncludes)!.toListValue();

        final allMappers = [...mappersList, ..._mappersFromRecursiveIncludes(includesList: includesList ?? [])];
        final mappers = _processMappers(
          mappers: allMappers,
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
          modulesCode: delegatesExpression,
          modulesList: delegatesList ?? [],
          mapprOptions: mapprOptions,
        );

        final builder = AutoMapprBuilder(mapperClassElement: element, config: config);

        final output = builder.build();

        return '${output.accept(EmitterHelper.current.emitter)}';
      },
      zoneValues: {EmitterHelper.zoneSymbol: EmitterHelper(fileWithAnnotation: fileUri)},
    );
  }

  List<TypeMapping> _processMappers({
    required List<DartObject> mappers,
    required ClassElement element,
    required AutoMapprConfig config,
  }) {
    return mappers
        .map((mapper) {
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

          final fields = mapper.getField(mapTypeFieldFields)?.toListValue();
          final whenSourceIsNull = mapper.getField(mapTypeFieldWhenSourceIsNull)?.toCodeExpression(config: config);
          final constructor = mapper.getField(mapTypeFieldConstructor)?.toStringValue();
          final ignoreFieldNull = mapper.getField(mapTypeFieldIgnoreFieldNull)?.toBoolValue();
          final reverse = mapper.getField(mapTypeFieldReverse)?.toBoolValue();

          final fieldMappings = fields
              ?.map(
                (fieldMapping) => FieldMapping(
                  field: fieldMapping.getField(fieldFieldField)!.toStringValue()!,
                  ignore: fieldMapping.getField(fieldFieldIgnore)!.toBoolValue()!,
                  from: fieldMapping.getField(fieldFieldFrom)!.toStringValue(),
                  customExpression: fieldMapping
                      .getField(fieldFieldCustom)!
                      .toCodeExpression(passModelArgument: true, config: config),
                  whenNullExpression: fieldMapping.getField(fieldFieldWhenNull)!.toCodeExpression(config: config),
                  ignoreNull: fieldMapping.getField(fieldFieldIgnoreNull)?.toBoolValue(),
                ),
              )
              .toList();

          return [
            TypeMapping(
              source: sourceType,
              target: targetType,
              fieldMappings: fieldMappings,
              whenSourceIsNullExpression: whenSourceIsNull,
              constructor: constructor,
              ignoreFieldNull: ignoreFieldNull,
            ),
            if (reverse ?? false)
              TypeMapping(
                source: targetType,
                target: sourceType,
                fieldMappings: fieldMappings,
                whenSourceIsNullExpression: whenSourceIsNull,
                constructor: constructor,
                ignoreFieldNull: ignoreFieldNull,
              ),
          ];
        })
        .flattened
        .toList();
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

  /// Recursively returns all mappings from includes.
  Iterable<DartObject> _mappersFromRecursiveIncludes({required List<DartObject> includesList}) {
    final mappings = <DartObject>[];

    for (final include in includesList) {
      // For each include locate AutoMappr annotation.
      if (include.type?.element?.metadata
              .firstWhereOrNull((data) => data.element?.displayName == annotationAutoMappr)
              ?.computeConstantValue()
          case final includeConstant?) {
        // This -- mappers.
        final mappers = includeConstant.getField(annotationFieldMappers)?.toListValue();
        if (mappers != null) {
          mappings.addAll(mappers);
        }

        // Bellow -- recursive includes.
        final includes = includeConstant.getField(annotationFieldIncludes)?.toListValue();
        if (includes != null) {
          mappings.addAll(_mappersFromRecursiveIncludes(includesList: includes));
        }
      }
    }

    return mappings;
  }
}
