import 'package:analyzer/dart/element/element.dart';
import 'package:auto_mappr/src/builder/map_bodies/map_body_builder_base.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

class EnumBodyBuilder extends MapBodyBuilderBase {
  const EnumBodyBuilder({
    required super.mapperConfig,
    required super.mapping,
    required super.nullable,
    required super.usedNullableMethodCallback,
  });

  @override
  Code build() {
    final isSourceEnum = mapping.source.element is EnumElement;
    final isTargetEnum = mapping.target.element is EnumElement;
    // Check that both source and target enums are enums.
    if (!isSourceEnum || !isTargetEnum) {
      throw InvalidGenerationSourceError(
        'Failed to map $mapping because ${isSourceEnum ? 'target ${mapping.target.getDisplayStringWithLibraryAlias(
            config: mapperConfig,
          )}' : 'source ${mapping.source.getDisplayStringWithLibraryAlias(
            config: mapperConfig,
          )}'} is not an enum.',
      );
    }

    final sourceEnum = mapping.source.element as EnumElement;
    final targetEnum = mapping.target.element as EnumElement;

    final sourceValues = sourceEnum.fields.where((e) => e.isEnumConstant && e.isPublic).map((e) => e.name).toSet();
    final targetValues = targetEnum.fields.where((e) => e.isEnumConstant && e.isPublic).map((e) => e.name).toSet();

    final sourceIsSubset = targetValues.containsAll(sourceValues);

    if (!sourceIsSubset && !mapping.hasWhenNullDefault()) {
      throw InvalidGenerationSourceError(
        "Can't map enum ${mapping.source.getDisplayStringWithLibraryAlias(
          config: mapperConfig,
        )} into ${mapping.target.getDisplayStringWithLibraryAlias(
          config: mapperConfig,
        )}. Target enum is not superset of source enum.",
      );
    }

    final targetReference = refer(
      mapping.target.getDisplayStringWithLibraryAlias(config: mapperConfig),
    );

    return targetReference
        .property('values')
        .property('firstWhere')
        .call(
          [refer('(x) => x.name == model.name')],
          {
            if (mapping.hasWhenNullDefault())
              'orElse': refer(
                '() => ${mapping.whenSourceIsNullExpression!.accept(DartEmitter())}',
              ),
          },
        )
        .returned
        .statement;
  }

  @override
  bool canProcess() {
    return mapping.isEnumMapping;
  }
}
