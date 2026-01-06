import 'package:analyzer/dart/element/element.dart';
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
    final isSourceEnum = mapping.source.element is EnumElement;
    final isTargetEnum = mapping.target.element is EnumElement;

    // Check that both source and target enums are enums.
    if (!isSourceEnum || !isTargetEnum) {
      final sourceDisplay = mapping.source.getDisplayString();
      final targetDisplay = mapping.target.getDisplayString();

      throw InvalidGenerationSourceError(
        'Failed to map $mapping because ${isSourceEnum ? 'target $targetDisplay' : 'source $sourceDisplay'} is not an enum.',
      );
    }

    final sourceEnum = mapping.source.element as EnumElement;
    final targetEnum = mapping.target.element as EnumElement;

    final sourceValues = sourceEnum.fields.where((e) => e.isEnumConstant && e.isPublic).map((e) => e.name).toSet();
    final targetValues = targetEnum.fields.where((e) => e.isEnumConstant && e.isPublic).map((e) => e.name).toSet();

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
                // ignore: avoid-default-tostring, should be ok
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
