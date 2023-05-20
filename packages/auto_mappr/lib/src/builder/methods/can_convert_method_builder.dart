import 'package:auto_mappr/src/builder/methods/auto_mappr_method_builder.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';

class CanConvertMethodBuilder extends AutoMapprMethodBuilder {
  CanConvertMethodBuilder(super.config);

  @override
  Method buildMethod() {
    return Method(
      (b) => b
        ..name = 'canConvert'
        ..docs = ListBuilder([
          '/// {@macro AutoMapprInterface:canConvert}',
          config.availableMappingsMacroDocComment,
        ])
        ..annotations = AutoMapprMethodBuilder.overrideAnnotation
        ..types.addAll([AutoMapprMethodBuilder.sourceTypeReference, AutoMapprMethodBuilder.targetTypeReference])
        ..requiredParameters.addAll([
          Parameter(
            (p) => p
              ..name = 'model'
              ..type = AutoMapprMethodBuilder.nullableSourceTypeReference,
          ),
        ])
        ..optionalParameters.addAll([
          Parameter(
            (p) => p
              ..name = 'recursive'
              ..named = true
              ..defaultTo = literalTrue.code
              ..type = refer('bool'),
          ),
        ])
        ..returns = refer('bool')
        ..body = buildBody(),
    );
  }

  @override
  Code buildBody() {
    final block = BlockBuilder();

    final sourceTypeOfVariable = declareFinal('sourceTypeOf').assign(AutoMapprMethodBuilder.sourceTypeOf);
    final sourceTypeOfReference = refer('sourceTypeOf');
    block.addExpression(sourceTypeOfVariable);

    final targetTypeOfVariable = declareFinal('targetTypeOf').assign(AutoMapprMethodBuilder.targetTypeOf);
    final targetTypeOfReference = refer('targetTypeOf');
    block.addExpression(targetTypeOfVariable);

    // Check this mappr.
    for (final mapping in config.mappers) {
      // Generates code like:
      /*
       final sourceTypeOf = _typeOf<SOURCE>();
       final targetTypeOf = _typeOf<TARGET>();
       if ((sourceTypeOf == _typeOf<UserDto>() ||
               sourceTypeOf == _typeOf<UserDto?>()) &&
           (targetTypeOf == _typeOf<User>() || targetTypeOf == _typeOf<User?>())) {
         return true
        }
      */
      final ifCheckTypeMatchExpression = buildMatchingIfCondition(
        mapping: mapping,
        sourceTypeOfReference: sourceTypeOfReference,
        targetTypeOfReference: targetTypeOfReference,
        inIfExpression: (BlockBuilder()..addExpression(literalTrue.returned)).build(),
      );

      block.statements.add(ifCheckTypeMatchExpression.code);
    }

    // And then also check modules.
    block.statements.add(
      ExpressionExtension.ifStatement(
        condition: refer('recursive'),
        ifBody: ExpressionExtension.forStatement(
          item: refer('mappr'),
          iterable: refer('_modules'),
          body: ExpressionExtension.ifStatement(
            condition: refer('mappr').property('canConvert').call(
              [refer('model')],
              {},
              [AutoMapprMethodBuilder.sourceTypeReference, AutoMapprMethodBuilder.targetTypeReference],
            ),
            ifBody: literalTrue.returned.statement,
          ),
        ),
      ).code,
    );

    block.statements.add(literalFalse.returned.statement);

    return block.build();
  }
}
