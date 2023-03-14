//ignore_for_file: avoid-dynamic

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mapper_annotation/auto_mapper.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

import '../builder/auto_mapper_builder.dart';
import '../models/models.dart';

/// Code generator to generate implemented mapping classes.
class AutoMapperGenerator extends GeneratorForAnnotation<AutoMapper> {
  @override
  dynamic generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '${element.displayName} is not a class and cannot be annotated with @AutoMapper',
        element: element,
        todo: 'Add AutoMapper annotation to a class',
      );
    }

    final annotation = element.metadata.single; // AutoMapper annotation
    final constant = annotation.computeConstantValue()!; // its instance
    final mappersField = constant.getField('mappers')!;
    final mappers = mappersField.toListValue()!;

    final parts = mappers.map((mapper) {
      final mapperType = mapper.type as ParameterizedType;

      final sourceType = mapperType.typeArguments.first;
      final targetType = mapperType.typeArguments[1];

      final mappings = mapper.getField('mappings')?.toListValue();
      final whenNullDefault = mapper.getField('whenNullDefault')?.toFunctionValue();
      final constructor = mapper.getField('constructor')?.toStringValue();

      final memberMappings = mappings?.map((mapping) {
        return MemberMapping(
          member: mapping.getField('member')!.toStringValue()!,
          ignore: mapping.getField('ignore')!.toBoolValue()!,
          custom: mapping.getField('custom')!.toFunctionValue(),
          from: mapping.getField('from')!.toStringValue(),
          whenNullDefault: mapping.getField('whenNullDefault')!.toFunctionValue(),
        );
      }).toList();

      return AutoMapPart(
        source: sourceType,
        target: targetType,
        mappings: memberMappings,
        whenNullDefault: whenNullDefault,
        constructor: constructor,
      );
    }).toList();

    final duplicates = parts.duplicates;
    if (duplicates.isNotEmpty) {
      throw InvalidGenerationSourceError(
        '@AutoMapper has configured duplicated mappings:\n\t${duplicates.join('\n\t')}',
      );
    }

    final config = AutoMapperConfig(parts: parts);

    final builder = AutoMapperBuilder(mapperClassElement: element, config: config);

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
