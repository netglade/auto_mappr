import 'package:analyzer/dart/element/element2.dart';
import 'package:auto_mappr/src/builder/map_bodies/map_body_builder_base.dart';
import 'package:auto_mappr/src/helpers/emitter_helper.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

class EnumBodyBuilder extends MapBodyBuilderBase {
  const EnumBodyBuilder({
    required super.mapperConfig,
    required super.mapping,
    required super.onUsedNullableMethodCallback,
  });

  @override
  Code build() {
    final isSourceEnum = mapping.source.element3 is EnumElement2;
    final isTargetEnum = mapping.target.element3 is EnumElement2;

    // Check that both source and target enums are enums.
    if (!isSourceEnum || !isTargetEnum) {
      final sourceDisplay = mapping.source.getDisplayString();
      final targetDisplay = mapping.target.getDisplayString();

      throw InvalidGenerationSourceError(
        'Failed to map $mapping because ${isSourceEnum ? 'target $targetDisplay' : 'source $sourceDisplay'} is not an enum.',
      );
    }

    final sourceEnum = mapping.source.element3 as EnumElement2;
    final targetEnum = mapping.target.element3 as EnumElement2;

    final sourceValues = sourceEnum.fields2.where((e) => e.isEnumConstant && e.isPublic).map((e) => e.name3).toSet();
    final targetValues = targetEnum.fields2.where((e) => e.isEnumConstant && e.isPublic).map((e) => e.name3).toSet();

    final isSourceSubset = targetValues.containsAll(sourceValues);

    if (!isSourceSubset && !mapping.hasWhenNullDefault()) {
      final sourceDisplay = mapping.source.getDisplayString();
      final targetDisplay = mapping.target.getDisplayString();
      throw InvalidGenerationSourceError(
        "Can't map enum $sourceDisplay into $targetDisplay. Target enum is not superset of source enum. ($mapping)",
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
