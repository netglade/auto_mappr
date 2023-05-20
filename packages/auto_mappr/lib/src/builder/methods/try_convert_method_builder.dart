import 'package:auto_mappr/src/builder/methods/auto_mappr_method_builder.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';

class TryConvertMethodBuilder extends AutoMapprMethodBuilder {
  TryConvertMethodBuilder(super.config);

  @override
  Method buildMethod() {
    return Method(
      (b) => b
        ..name = 'tryConvert'
        ..docs = ListBuilder([
          '/// {@macro AutoMapprInterface:tryConvert}',
          config.availableMappingsMacroDocComment,
        ])
        ..annotations = AutoMapprMethodBuilder.overrideAnnotation
        ..types.addAll([AutoMapprMethodBuilder.sourceTypeReference, AutoMapprMethodBuilder.targetTypeReference])
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'model'
              ..type = AutoMapprMethodBuilder.nullableSourceTypeReference,
          ),
        )
        ..returns = AutoMapprMethodBuilder.nullableTargetTypeReference
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
        condition: refer('canConvert').call(
          [refer('model')],
          {'recursive': literalFalse},
          [AutoMapprMethodBuilder.sourceTypeReference, AutoMapprMethodBuilder.targetTypeReference],
        ),
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
        iterable: refer('_modules'),
        body: ExpressionExtension.ifStatement(
          condition: refer('mappr').property('canConvert').call(
            [refer('model')],
            {},
            [AutoMapprMethodBuilder.sourceTypeReference, AutoMapprMethodBuilder.targetTypeReference],
          ),
          ifBody: refer('mappr').property('tryConvert').call([refer('model')], {}, []).returned.statement,
        ),
      ).code,
    );

    block.addExpression(
      literalNull.returned,
    );

    return block.build();
  }
}
