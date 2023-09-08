import 'package:auto_mappr/src/builder/methods/can_convert_method_builder.dart';
import 'package:auto_mappr/src/builder/methods/method_builder_base.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';

// modules OK
// modules tests OK
class TryConvertMethodBuilder extends MethodBuilderBase {
  const TryConvertMethodBuilder(super.config);

  @override
  Method buildMethod() {
    return Method(
      (b) => b
        ..name = 'tryConvert'
        ..docs = ListBuilder([
          '/// {@macro AutoMapprInterface:tryConvert}',
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
        ..returns = MethodBuilderBase.nullableTargetTypeReference
        ..body = buildBody(),
    );
  }

  @override
  Code buildBody() {
    final block = BlockBuilder();

    // Generates code like:
    //
    // if (canConvert(model)) {
    //   return _convert(model)!;
    // }
    block.statements.add(
      ExpressionExtension.ifStatement(
        condition: CanConvertMethodBuilder(config).methodCall(namedArguments: {'recursive': literalFalse}),
        ifBody: refer('_convert').call([refer('model')], {'canReturnNull': refer('true')}, []).returned.statement,
      ).code,
    );

    // Generates code like:
    //
    // for (final mappr in mappers) {
    //   if (mappr.canConvert(model)) {
    //     return mappr.convert(model)!;
    //   }
    // }
    block.statements.add(
      ExpressionExtension.forStatement(
        item: refer('mappr'),
        iterable: refer(MethodBuilderBase.delegatesField),
        body: ExpressionExtension.ifStatement(
          condition: CanConvertMethodBuilder(config).propertyCall(on: refer('mappr')),
          ifBody: refer('mappr').property('tryConvert').call([refer('model')], {}, []).returned.statement,
        ),
      ).code,
    );

    block.addExpression(literalNull.returned);

    return block.build();
  }
}
