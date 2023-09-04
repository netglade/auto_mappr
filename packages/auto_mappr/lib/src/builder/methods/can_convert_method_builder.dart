import 'package:auto_mappr/src/builder/methods/callable_method.dart';
import 'package:auto_mappr/src/builder/methods/callable_property.dart';
import 'package:auto_mappr/src/builder/methods/method_builder_base.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';

class CanConvertMethodBuilder extends MethodBuilderBase implements CallableMethod, CallableProperty {
  CanConvertMethodBuilder(super.config);

  @override
  Method buildMethod() {
    return Method(
      (b) => b
        ..name = 'canConvert'
        ..docs = ListBuilder([
          '/// {@macro AutoMapprInterface:canConvert}',
          config.availableMappingsDocComment,
        ])
        ..annotations = MethodBuilderBase.overrideAnnotation
        ..types.addAll([MethodBuilderBase.sourceTypeReference, MethodBuilderBase.targetTypeReference])
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

    final sourceTypeOfVariable = declareFinal('sourceTypeOf').assign(MethodBuilderBase.sourceTypeOf);
    final sourceTypeOfReference = refer('sourceTypeOf');
    block.addExpression(sourceTypeOfVariable);

    final targetTypeOfVariable = declareFinal('targetTypeOf').assign(MethodBuilderBase.targetTypeOf);
    final targetTypeOfReference = refer('targetTypeOf');
    block.addExpression(targetTypeOfVariable);

    // Check this mappr.
    for (final mapping in config.mappers) {
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
          iterable: refer(MethodBuilderBase.delegatesField),
          body: ExpressionExtension.ifStatement(
            condition: CanConvertMethodBuilder(config).propertyCall(on: refer('mappr')),
            ifBody: literalTrue.returned.statement,
          ),
        ),
      ).code,
    );

    block.statements.add(literalFalse.returned.statement);

    return block.build();
  }

  @override
  Expression methodCall({Map<String, Expression> namedArguments = const {}}) {
    return refer('canConvert').call(
      const [],
      namedArguments,
      [MethodBuilderBase.sourceTypeReference, MethodBuilderBase.targetTypeReference],
    );
  }

  @override
  Expression propertyCall({
    required Reference on,
    Map<String, Expression> namedArguments = const {},
  }) {
    return on.property('canConvert').call(
          const [],
          namedArguments,
          [MethodBuilderBase.sourceTypeReference, MethodBuilderBase.targetTypeReference],
        );
  }
}
