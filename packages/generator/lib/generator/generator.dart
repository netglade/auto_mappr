import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:automapper/automapper.dart';
import 'package:automapper_generator/builder/auto_mapper_builder.dart';
import 'package:automapper_generator/models/auto_mapper_config.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

import '../models/auto_map_part.dart';

// may be helpful to check which elements have a given annotation.
// abstract class GeneratorForAnnotation2<T> extends GeneratorForAnnotation<T> {
//   GeneratorForAnnotation2();

//   late LibraryReader library;

//   @override
//   FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
//     this.library = library;

//     return super.generate(library, buildStep);
//   }
// }

/// Codegenerator to generate implemented mapping classes
class MapperGenerator extends GeneratorForAnnotation<AutoMapper> {
  @override
  dynamic generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError('${element.displayName} is not a class and cannot be annotated with @Mapper',
          element: element, todo: 'Add Mapper annotation to a class');
    }
    final annotation = element.metadata.single; // AutoMapper annotation
    final constant = annotation.computeConstantValue()!; // its instance
    final field = constant.getField('mappers')!;
    final list = field.toListValue()!;
    //final firstElement = list.first;
    //final autoMapType = firstElement.type as ParameterizedType;
    // final userType = autoMapType.typeArguments[0];
    // final userDtoType = autoMapType.typeArguments[1];

    final parts = list.map((x) {
      final mapType = x.type as ParameterizedType;

      final from = mapType.typeArguments[0];
      final to = mapType.typeArguments[1];

      final isReverse = x.getField('reverse')?.toBoolValue();
      final mappings = x.getField('mappings')?.toListValue();

      final m = mappings?.map((e) {
        return MemberMapping(
          member: e.getField('member')!.toStringValue()!,
          ignore: e.getField('ignore')!.toBoolValue()!,
          target: e.getField('target')!.toFunctionValue(),
        );
      }).toList();

      return AutoMapPart(
        source: from,
        target: to,
        isReverse: isReverse ?? false,
        mappings: m,
      );
    }).toList();

    if (parts.duplicates.isNotEmpty) {
      throw InvalidGenerationSourceError(
          '@AutoMapper has configured duplicated mappings:\n\t${parts.duplicates.join('\n\t')}');
    }

    /**
     *  1. Gather all AutoMap 
     *  2. For each AutoMap 
     *    -  a] Get  All fields of From
     *    -  b] Get all constructor of From
     *    -  a] Get all fields of To
     *    - b] Get all constructors of To
     *  3. CHECK if
     *    a] From can be automatically mapped to To
     *       - All fields are same
     *       - There is 1:1 usable constructor
     */

    final config = AutoMapperConfig(parts: parts);

    final reverseMappings = parts.where((x) => x.isReverse).toList();

    for (var reverseMapping in reverseMappings) {
      final specific = config.getMorePreciseReverseMapping(reverseMapping);
      if (specific != null) {
        log.warning(
            'Mapping $reverseMapping has reverse=true but more specific mapping $specific is configured. Reverse flag will be ignored.');
      }
    }

    final builder = AutoMapperBuilder(mapperClassElement: element, config: config);

    final mapping = builder.build();
    final emitter = DartEmitter(orderDirectives: true, useNullSafetySyntax: true);

    return '${mapping.accept(emitter)}';
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
