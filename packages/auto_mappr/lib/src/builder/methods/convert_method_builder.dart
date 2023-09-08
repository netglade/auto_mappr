import 'package:auto_mappr/src/builder/methods/can_convert_method_builder.dart';
import 'package:auto_mappr/src/builder/methods/method_builder_base.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';

class ConvertMethodBuilder extends MethodBuilderBase {
  const ConvertMethodBuilder(super.config);

  @override
  Method buildMethod() {
    return Method(
      (b) => b
        ..name = 'convert'
        ..docs = ListBuilder([
          '/// {@macro AutoMapprInterface:convert}',
          config.availableMappingsDocComment,
        ])
        ..annotations = MethodBuilderBase.overrideAnnotation
        ..types.addAll([MethodBuilderBase.sourceTypeReference, MethodBuilderBase.targetTypeReference])
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'model'
              ..type = MethodBuilderBase.nullableSourceTypeReference,
          ),
        )
        ..returns = MethodBuilderBase.targetTypeReference
        ..body = buildBody(),
    );
  }

  @override
  Code buildBody() {
    final block = BlockBuilder();

    // Generates code like:
    //
    // if (canConvert<SOURCE, TARGET>()) {
    //   return _convert(model)!;
    // }
    block.statements.add(
      ExpressionExtension.ifStatement(
        condition: CanConvertMethodBuilder(config).methodCall(namedArguments: {'recursive': literalFalse}),
        ifBody: refer('_convert').call([refer('model')], {}, []).nullChecked.returned.statement,
      ).code,
    );

    // Generates code like:
    //
    // for (final mappr in mappers) {
    //   if (mappr.canConvert<SOURCE, TARGET>()) {
    //     return mappr.convert(model)!;
    //   }
    // }
    block.statements.add(
      ExpressionExtension.forStatement(
        item: refer('mappr'),
        iterable: refer(MethodBuilderBase.delegatesField),
        body: ExpressionExtension.ifStatement(
          condition: CanConvertMethodBuilder(config).propertyCall(on: refer('mappr')),
          ifBody: refer('mappr').property('convert').call([refer('model')], {}, []).nullChecked.returned.statement,
        ),
      ).code,
    );

    block.addExpression(
      refer('Exception').newInstance(
        [refer(r"'No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.'")],
      ).thrown,
    );

    return block.build();
  }
}
