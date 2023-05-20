import 'package:auto_mappr/src/builder/methods/auto_mappr_method_builder.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:code_builder/code_builder.dart';

class PrivateConvertMethodBuilder extends AutoMapprMethodBuilder {
  PrivateConvertMethodBuilder(super.config);

  @override
  Method buildMethod() {
    return Method(
      (b) => b
        ..name = '_convert'
        ..types.addAll([AutoMapprMethodBuilder.sourceTypeReference, AutoMapprMethodBuilder.targetTypeReference])
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'model'
              ..type = AutoMapprMethodBuilder.nullableSourceTypeReference,
          ),
        )
        ..optionalParameters.add(
          Parameter(
            (p) => p
              ..name = 'canReturnNull'
              ..type = refer('bool')
              ..named = true
              ..defaultTo = literalFalse.code,
          ),
        )
        ..returns = AutoMapprMethodBuilder.nullableTargetTypeReference
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

    for (final mapping in config.mappers) {
      final ifCheckForNull = refer('canReturnNull').and(refer('model').equalToNull()).ifStatement2(
            ifBody: mapping.hasWhenNullDefault()
                ? mapping.whenSourceIsNullExpression!.asA(AutoMapprMethodBuilder.targetTypeReference).returned.statement
                : literalNull.returned.statement,
          );

      // Generates code like:
      /*
       final sourceTypeOf = _typeOf<SOURCE>();
       final targetTypeOf = _typeOf<TARGET>();
       if ((sourceTypeOf == _typeOf<UserDto>() ||
               sourceTypeOf == _typeOf<UserDto?>()) &&
           (targetTypeOf == _typeOf<User>() || targetTypeOf == _typeOf<User?>())) {
            if(canReturnNull && model == null) return (defaultValue() or null);

         return (_map_UserDto$_To_User$((model as UserDto?)) as TARGET);
        }
      */
      final ifCheckTypeMatchExpression = buildMatchingIfCondition(
        mapping: mapping,
        sourceTypeOfReference: sourceTypeOfReference,
        targetTypeOfReference: targetTypeOfReference,
        inIfExpression: (BlockBuilder()
              ..statements.add(ifCheckForNull.code)
              ..addExpression(
                refer(mapping.mappingMethodName)
                    .call(
                      [
                        refer('model').asA(refer('${mapping.source.getDisplayString(withNullability: false)}?')),
                      ],
                    )
                    .asA(AutoMapprMethodBuilder.targetTypeReference)
                    .returned,
              ))
            .build(),
      );

      block.statements.add(ifCheckTypeMatchExpression.code);
    }

    block.addExpression(
      refer('Exception').newInstance(
        [refer("'No \${model.runtimeType} -> \$${targetTypeOfReference.accept(DartEmitter())} mapping.'")],
      ).thrown,
    );

    return block.build();
  }
}
