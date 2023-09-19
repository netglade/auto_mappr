//ignore_for_file: avoid-dynamic

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/builder/auto_mappr_builder.dart';
import 'package:auto_mappr/src/extensions/dart_object_extension.dart';
import 'package:auto_mappr/src/extensions/list_extension.dart';
import 'package:auto_mappr/src/helpers/emitter_helper.dart';
import 'package:auto_mappr/src/helpers/run_zoned_auto_mappr.dart';
import 'package:auto_mappr/src/models/auto_mappr_options.dart';
import 'package:auto_mappr/src/models/models.dart';
import 'package:auto_mappr/src/models/type_converter.dart';
import 'package:auto_mappr_annotation/auto_mappr_annotation.dart' as annotation;
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';

/// Code generator to generate implemented mapping classes.
class AutoMapprGenerator extends GeneratorForAnnotation<annotation.AutoMappr> {
  final BuilderOptions builderOptions;

  // Constants for AutoMappr.
  static const String annotationAutoMappr = 'AutoMappr';
  static const String annotationFieldMappers = 'mappers';
  static const String annotationFieldConverters = 'converters';
  static const String annotationFieldDelegates = 'delegates';
  static const String annotationFieldIncludes = 'includes';

  // Constants for MapType.
  static const String mapTypeFieldFields = 'fields';
  static const String mapTypeFieldConverters = 'converters';
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

  // Constants for TypeConverter.
  static const String typeConverterFieldConverter = 'converter';

  const AutoMapprGenerator({required this.builderOptions});

  @override
  dynamic generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    final filePath = element.library?.identifier;
    final fileUri = filePath != null ? Uri.parse(filePath) : null;

    return runZonedAutoMappr(libraryUri: fileUri, () {
      if (element is! ClassElement) {
        throw InvalidGenerationSourceError(
          '${element.displayName} is not a class and cannot be annotated with @AutoMappr.',
          element: element,
          todo: 'Use @AutoMappr annotation on a class',
        );
      }

      final mapprOptions = AutoMapprOptions.fromJson(builderOptions.config);

      final constant = annotation.objectValue;
      final mappersList = constant.getField(annotationFieldMappers)?.toListValue() ?? <DartObject>[];
      final convertersList = constant.getField(annotationFieldConverters)?.toListValue() ?? <DartObject>[];
      final delegatesExpression = constant.getField(annotationFieldDelegates)?.toCodeExpression();
      final delegatesList = constant.getField(annotationFieldDelegates)?.toListValue() ?? <DartObject>[];
      final includesList = constant.getField(annotationFieldIncludes)?.toListValue() ?? <DartObject>[];

      final allMappers = [...mappersList, ..._mappersFromRecursiveIncludes(includesList: includesList)];
      final allConverters =
          _toTypeConverters([...convertersList, ..._convertersFromRecursiveIncludes(includesList: includesList)]);
      final mappers = _processMappers(mappers: allMappers, globalConverters: allConverters, element: element);

      final duplicates = mappers.duplicates;
      if (duplicates.isNotEmpty) {
        throw InvalidGenerationSourceError(
          '@AutoMappr has configured duplicated mappings:\n\t${duplicates.map(
                (e) => e.toString(),
              ).join('\n\t')}',
        );
      }

      final config = AutoMapprConfig(
        mappers: mappers,
        availableMappingsMacroId: element.library.identifier,
        modulesCode: delegatesExpression,
        delegatesList: delegatesList,
        mapprOptions: mapprOptions,
      );

      final builder = AutoMapprBuilder(mapperClassElement: element, config: config);

      final output = builder.build();

      return '${output.accept(EmitterHelper.current.emitter)}';
    });
  }

  List<TypeMapping> _processMappers({
    required List<DartObject> mappers,
    required List<TypeConverter> globalConverters,
    required ClassElement element,
  }) {
    return mappers
        .map((mapper) {
          final mapperType = mapper.type! as ParameterizedType;

          final sourceType = mapperType.typeArguments.firstOrNull;
          final targetType = mapperType.typeArguments.lastOrNull;

          if (sourceType is! InterfaceType) {
            final emittedSource = EmitterHelper.current.typeReferEmitted(type: sourceType);

            throw InvalidGenerationSourceError(
              '$emittedSource is not a class and cannot be mapped from',
              element: element,
              todo: 'Use a class',
            );
          }
          if (targetType is! InterfaceType) {
            final emittedTarget = EmitterHelper.current.typeReferEmitted(type: targetType);

            throw InvalidGenerationSourceError(
              '$emittedTarget is not a class and cannot be mapped to',
              element: element,
              todo: 'Use a class',
            );
          }

          final fields = mapper.getField(mapTypeFieldFields)?.toListValue();
          final mapTypeConverters = mapper.getField(mapTypeFieldConverters)?.toListValue() ?? [];
          final whenSourceIsNull = mapper.getField(mapTypeFieldWhenSourceIsNull)?.toCodeExpression();
          final constructor = mapper.getField(mapTypeFieldConstructor)?.toStringValue();
          final ignoreFieldNull = mapper.getField(mapTypeFieldIgnoreFieldNull)?.toBoolValue();
          final reverse = mapper.getField(mapTypeFieldReverse)?.toBoolValue();

          final fieldMappings = fields
              ?.map(
                (fieldMapping) => FieldMapping(
                  field: fieldMapping.getField(fieldFieldField)!.toStringValue()!,
                  ignore: fieldMapping.getField(fieldFieldIgnore)!.toBoolValue()!,
                  from: fieldMapping.getField(fieldFieldFrom)!.toStringValue(),
                  customExpression: fieldMapping.getField(fieldFieldCustom)!.toCodeExpression(passModelArgument: true),
                  whenNullExpression: fieldMapping.getField(fieldFieldWhenNull)!.toCodeExpression(),
                  ignoreNull: fieldMapping.getField(fieldFieldIgnoreNull)!.toBoolValue(),
                ),
              )
              .toList();

          return [
            TypeMapping(
              source: sourceType,
              target: targetType,
              fieldMappings: fieldMappings ?? [],
              typeConverters: [..._toTypeConverters(mapTypeConverters), ...globalConverters],
              whenSourceIsNullExpression: whenSourceIsNull,
              constructor: constructor,
              ignoreFieldNull: ignoreFieldNull,
            ),
            if (reverse ?? false)
              TypeMapping(
                source: targetType,
                target: sourceType,
                fieldMappings: fieldMappings ?? [],
                whenSourceIsNullExpression: whenSourceIsNull,
                constructor: constructor,
                ignoreFieldNull: ignoreFieldNull,
              ),
          ];
        })
        .flattened
        .toList();
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
          // ignore: avoid-recursive-calls, it's handled
          mappings.addAll(_mappersFromRecursiveIncludes(includesList: includes));
        }
      }
    }

    return mappings;
  }

  List<TypeConverter> _toTypeConverters(List<DartObject> source) {
    return source.map((converter) {
      final converterType = converter.type! as ParameterizedType;
      // ignore: avoid-unsafe-collection-methods, is checked by the TypeConverter interface
      final sourceType = converterType.typeArguments.first;
      // ignore: avoid-unsafe-collection-methods, is checked by the TypeConverter interface
      final targetType = converterType.typeArguments.last;

      return TypeConverter(
        source: sourceType,
        target: targetType,
        converter: converter.getField(typeConverterFieldConverter)!.toFunctionValue()!,
      );
    }).toList();
  }

  /// Recursively returns all type converters from includes.
  Iterable<DartObject> _convertersFromRecursiveIncludes({required List<DartObject> includesList}) {
    final mappings = <DartObject>[];

    for (final include in includesList) {
      // For each include locate AutoMappr annotation.
      if (include.type?.element?.metadata
              .firstWhereOrNull((data) => data.element?.displayName == annotationAutoMappr)
              ?.computeConstantValue()
          case final includeConstant?) {
        // This -- converters.
        final converters = includeConstant.getField(annotationFieldConverters)?.toListValue();
        if (converters != null) {
          mappings.addAll(converters);
        }

        // Bellow -- recursive includes.
        final includes = includeConstant.getField(annotationFieldIncludes)?.toListValue();
        if (includes != null) {
          // ignore: avoid-recursive-calls, it's handled
          mappings.addAll(_convertersFromRecursiveIncludes(includesList: includes));
        }
      }
    }

    return mappings;
  }
}
