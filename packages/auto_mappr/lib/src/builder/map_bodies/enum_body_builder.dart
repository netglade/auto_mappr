import 'package:analyzer/dart/element/element.dart';
import 'package:auto_mappr/src/builder/map_bodies/map_body_builder_base.dart';
import 'package:auto_mappr/src/helpers/emitter_helper.dart';
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
      final emittedSource = EmitterHelper.current.typeReferEmitted(type: mapping.source);
      final emittedTarget = EmitterHelper.current.typeReferEmitted(type: mapping.target);
      throw InvalidGenerationSourceError(
        'Failed to map $mapping because ${isSourceEnum ? 'target $emittedTarget' : 'source $emittedSource'} is not an enum.',
      );
    }

    final sourceEnum = mapping.source.element as EnumElement;
    final targetEnum = mapping.target.element as EnumElement;

    final sourceValues = sourceEnum.fields.where((e) => e.isEnumConstant && e.isPublic).map((e) => e.name).toSet();
    final targetValues = targetEnum.fields.where((e) => e.isEnumConstant && e.isPublic).map((e) => e.name).toSet();

    final sourceIsSubset = targetValues.containsAll(sourceValues);

    if (!sourceIsSubset && !mapping.hasWhenNullDefault()) {
      final emittedMappingSource = EmitterHelper.current.typeRefer(type: mapping.source);
      final emittedMappingTarget = EmitterHelper.current.typeRefer(type: mapping.target);
      throw InvalidGenerationSourceError(
        "Can't map enum $emittedMappingSource into $emittedMappingTarget. Target enum is not superset of source enum.",
      );
    }

    final targetReference = EmitterHelper.current.typeRefer(type: mapping.target);

    return targetReference
        .property('values')
        .property('firstWhere')
        .call(
          [refer('(x) => x.name == model.name')],
          {
            if (mapping.hasWhenNullDefault())
              'orElse': refer(
                '() => ${mapping.whenSourceIsNullExpression!.accept(EmitterHelper.current.emitter)}',
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
