import 'package:auto_mappr/src/builder/map_model_body_method_builder.dart';
import 'package:auto_mappr/src/builder/methods/method_builder_base.dart';
import 'package:auto_mappr/src/models/type_mapping.dart';
import 'package:code_builder/code_builder.dart';

class MappingMethodBuilder extends MethodBuilderBase {
  final TypeMapping mapping;
  final bool nullable;
  final void Function(TypeMapping? mapping)? usedNullableMethodCallback;

  MappingMethodBuilder(
    super.config, {
    required this.mapping,
    this.nullable = false,
    this.usedNullableMethodCallback,
  });

  @override
  Method buildMethod() {
    // TODO(later): rework mapping to this builder

    return Method(
      (b) => b
        ..name = mapping.mappingMethodName
        ..requiredParameters.addAll([
          Parameter(
            (p) => p
              ..name = 'input'
              ..type = refer('${mapping.source.getDisplayString(withNullability: false)}?'),
          )
        ])
        ..returns = refer(mapping.target.getDisplayString(withNullability: false))
        ..body = MapModelBodyMethodBuilder(
          mapping: mapping,
          mapperConfig: config,
          usedNullableMethodCallback: usedNullableMethodCallback,
        ).build(),
    );

    // nullable
    // return Method(
    //   (b) => b
    //     ..name = mapping.nullableMappingMethodName
    //     ..requiredParameters.addAll([
    //       Parameter(
    //         (p) => p
    //           ..name = 'input'
    //           ..type = refer('${mapping.source.getDisplayString(withNullability: false)}?'),
    //       )
    //     ])
    //     ..returns = refer('${mapping.target.getDisplayString(withNullability: true)}?')
    //     ..body = MapModelBodyMethodBuilder(
    //       mapping: mapping,
    //       mapperConfig: config,
    //       nullable: true,
    //     ).build(),
    // );
  }

  @override
  Code buildBody() {
    // TODO(later): rework
    return const Code('T');
  }
}
