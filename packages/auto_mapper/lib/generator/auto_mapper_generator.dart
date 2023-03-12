//ignore_for_file: avoid-dynamic

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mapper/models/auto_map_part.dart';
import 'package:auto_mapper_annotation/auto_mapper.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

import '../builder/auto_mapper_builder.dart';
import '../models/auto_mapper_config.dart';

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
    final field = constant.getField('mappers')!;
    final list = field.toListValue()!;

    final parts = list.map((mapper) {
      final mapperType = mapper.type as ParameterizedType;

      final sourceType = mapperType.typeArguments.first;
      final targetType = mapperType.typeArguments[1];

      final isReverse = mapper.getField('reverse')?.toBoolValue();
      final mappings = mapper.getField('mappings')?.toListValue();
      final whenNullDefault = mapper.getField('whenNullDefault')?.toFunctionValue();

      final memberMappings = mappings?.map((mapping) {
        return MemberMapping(
          member: mapping.getField('member')!.toStringValue()!,
          ignore: mapping.getField('ignore')!.toBoolValue()!,
          custom: mapping.getField('custom')!.toFunctionValue(),
          rename: mapping.getField('rename')!.toStringValue(),
        );
      }).toList();

      return AutoMapPart(
        source: sourceType,
        target: targetType,
        isReverse: isReverse ?? false,
        mappings: memberMappings,
        whenNullDefault: whenNullDefault,
      );
    }).toList();

    if (parts.duplicates.isNotEmpty) {
      throw InvalidGenerationSourceError(
        '@AutoMapper has configured duplicated mappings:\n\t${parts.duplicates.join('\n\t')}',
      );
    }

    var config = AutoMapperConfig(parts: parts);

    final reverseMappings = parts.where((x) => x.isReverse).toList();

    for (final reverseMapping in reverseMappings) {
      final specific = config.getExplicitReverseMapping(reverseMapping);
      if (specific != null) {
        log.warning(
          'Mapping $reverseMapping has reverse=true but more specific mapping $specific is configured. Reverse flag will be ignored.',
        );
      }
      // add reverse mapping
      parts.add(
          AutoMapPart(source: reverseMapping.target, target: reverseMapping.source, isReverse: false, mappings: []));
    }

    config = AutoMapperConfig(parts: parts);

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
