//ignore_for_file: avoid-dynamic

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/builder/auto_mappr_builder.dart';
import 'package:auto_mappr/src/extensions/dart_object_extension.dart';
import 'package:auto_mappr/src/models/models.dart';
import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

/// Code generator to generate implemented mapping classes.
class AutoMapprGenerator extends GeneratorForAnnotation<AutoMappr> {
  @override
  dynamic generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '${element.displayName} is not a class and cannot be annotated with @AutoMappr.',
        element: element,
        todo: 'Use @AutoMappr annotation on a class',
      );
    }

    final constant = annotation.objectValue;
    final mappersField = constant.getField('mappers')!;
    final mappersList = mappersField.toListValue()!;
    final modulesExpression = constant.getField('modules')!.toCodeExpression(passModelArgument: true);

    final mappers = mappersList.map((mapper) {
      final mapperType = mapper.type! as ParameterizedType;

      final sourceType = mapperType.typeArguments.first;
      final targetType = mapperType.typeArguments.last;

      if (sourceType is! InterfaceType) {
        throw InvalidGenerationSourceError(
          '${sourceType.getDisplayString(withNullability: true)} is not a class and cannot be mapped from',
          element: element,
          todo: 'Use a class',
        );
      }
      if (targetType is! InterfaceType) {
        throw InvalidGenerationSourceError(
          '${targetType.getDisplayString(withNullability: true)} is not a class and cannot be mapped to',
          element: element,
          todo: 'Use a class',
        );
      }

      final fields = mapper.getField('fields')?.toListValue();
      final whenSourceIsNull = mapper.getField('whenSourceIsNull')?.toCodeExpression();
      final constructor = mapper.getField('constructor')?.toStringValue();

      final fieldMappings = fields
          ?.map(
            (fieldMapping) => FieldMapping(
              field: fieldMapping.getField('field')!.toStringValue()!,
              ignore: fieldMapping.getField('ignore')!.toBoolValue()!,
              from: fieldMapping.getField('from')!.toStringValue(),
              customExpression: fieldMapping.getField('custom')!.toCodeExpression(passModelArgument: true),
              whenNullExpression: fieldMapping.getField('whenNull')!.toCodeExpression(),
            ),
          )
          .toList();

      return TypeMapping(
        source: sourceType,
        target: targetType,
        fieldMappings: fieldMappings,
        whenSourceIsNullExpression: whenSourceIsNull,
        constructor: constructor,
      );
    }).toList();

    final duplicates = mappers.duplicates;
    if (duplicates.isNotEmpty) {
      throw InvalidGenerationSourceError(
        '@AutoMappr has configured duplicated mappings:\n\t${duplicates.join('\n\t')}',
      );
    }

    final config = AutoMapprConfig(
      mappers: mappers,
      availableMappingsMacroId: element.library.identifier,
      modules: modulesExpression,
    );

    final builder = AutoMapprBuilder(mapperClassElement: element, config: config);

    final output = builder.build();
    final emitter = DartEmitter(orderDirectives: true, useNullSafetySyntax: true);

    return '${output.accept(emitter)}';
  }
}

extension ListEx<T> on List<T> {
  List<T> get duplicates {
    final dup = <T>[];
    final buffer = <T>[];

    for (final x in this) {
      if (buffer.contains(x)) {
        dup.add(x);
      } else {
        buffer.add(x);
      }
    }

    return dup;
  }
}
