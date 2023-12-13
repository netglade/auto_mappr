import 'package:auto_mappr/src/builder/map_model_body_method_builder.dart';
import 'package:auto_mappr/src/builder/methods/method_builder_base.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:auto_mappr/src/helpers/emitter_helper.dart';
import 'package:auto_mappr/src/models/type_mapping.dart';
import 'package:code_builder/code_builder.dart';

class MappingMethodBuilder extends MethodBuilderBase {
  final TypeMapping mapping;
  final bool nullable;
  // ignore: prefer-typedefs-for-callbacks, private API
  final void Function(TypeMapping? mapping)? onUsedNullableMethodCallback;

  const MappingMethodBuilder(
    super.config, {
    required this.mapping,
    this.nullable = false,
    this.onUsedNullableMethodCallback,
  });

  @override
  Method buildMethod() {
    var returnType = EmitterHelper.current.typeRefer(type: mapping.target);

    if (nullable) {
      returnType = returnType.nullabled();
    }

    return Method(
      (b) => b
        ..name =
            nullable ? mapping.nullableMappingMethodName(config: config) : mapping.mappingMethodName(config: config)
        ..requiredParameters.addAll([
          Parameter(
            (p) => p
              ..name = 'input'
              ..type = EmitterHelper.current.typeRefer(type: mapping.source).nullabled(),
          ),
        ])
        ..returns = returnType
        ..body = buildBody(),
    );
  }

  @override
  Code buildBody() {
    return MapModelBodyMethodBuilder(
      mapping: mapping,
      mapperConfig: config,
      onUsedNullableMethodCallback: onUsedNullableMethodCallback,
      nullable: nullable,
    ).build();
  }
}
