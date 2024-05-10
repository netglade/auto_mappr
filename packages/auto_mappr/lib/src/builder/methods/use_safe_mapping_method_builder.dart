import 'package:auto_mappr/src/builder/methods/methods.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';

class UseSafeMappingMethodBuilder extends MethodBuilderBase implements CallableMethod, CallableProperty {
  const UseSafeMappingMethodBuilder(super.config);

  @override
  Method buildMethod() {
    return Method(
      (b) => b
        ..name = 'useSafeMapping'
        ..docs = ListBuilder([
          '/// {@macro AutoMapprInterface:useSafeMapping}',
          config.availableMappingsDocComment,
        ])
        ..annotations = MethodBuilderBase.overrideAnnotation
        ..types.addAll([MethodBuilderBase.sourceTypeReference, MethodBuilderBase.targetTypeReference])
        ..returns = refer('bool')
        ..body = buildBody(),
    );
  }

  @override
  Code buildBody() {
    final block = BlockBuilder();

    if (config.mapprOptions.safeMapping ?? false) {
      block.statements.add(literalTrue.returned.statement);

      return block.build();
    }

    final safeMappers = config.mappers.where((m) => m.safeMapping ?? false);

    if (safeMappers.isEmpty) {
      block.statements.add(literalFalse.returned.statement);

      return block.build();
    }

    // Generates code like:
    //
    // final sourceTypeOf = _typeOf<SOURCE>();
    // final targetTypeOf = _typeOf<TARGET>();
    // if (sourceTypeOf == _typeOf<SomeObjectDto>() &&
    //     targetTypeOf == _typeOf<SomeObject>()) {
    //   return true;
    // }
    final sourceTypeOfVariable = declareFinal('sourceTypeOf').assign(MethodBuilderBase.sourceTypeOf);
    block.addExpression(sourceTypeOfVariable);

    final targetTypeOfVariable = declareFinal('targetTypeOf').assign(MethodBuilderBase.targetTypeOf);
    block.addExpression(targetTypeOfVariable);

    for (final mapper in safeMappers) {
      final ifStatement = ExpressionExtension.ifStatement(
        condition: buildSourceAndTargetEquals(mapping: mapper),
        ifBody: literalTrue.returned.statement,
      ).code;

      block.statements.add(ifStatement);
    }

    // Generates code like:
    //
    // for (final mappr in _delegates) {
    //   if (mappr.useSafeMapping<SOURCE, TARGET>()) {
    //     return true;
    //   }
    // }
    block.statements.add(
      ExpressionExtension.forStatement(
        item: refer('mappr'),
        iterable: refer(MethodBuilderBase.delegatesField),
        body: ExpressionExtension.ifStatement(
          condition: UseSafeMappingMethodBuilder(config).propertyCall(on: refer('mappr')),
          ifBody: literalTrue.returned.statement,
        ),
      ).code,
    );

    block.statements.add(literalFalse.returned.statement);

    return block.build();
  }

  @override
  Expression methodCall({Map<String, Expression> namedArguments = const {}}) {
    return refer('useSafeMapping').call(
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
    return on.property('useSafeMapping').call(
          const [],
          namedArguments,
          [MethodBuilderBase.sourceTypeReference, MethodBuilderBase.targetTypeReference],
        );
  }
}
