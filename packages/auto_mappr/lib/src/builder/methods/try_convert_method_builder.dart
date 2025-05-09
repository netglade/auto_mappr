import 'package:auto_mappr/src/builder/methods/can_convert_method_builder.dart';
import 'package:auto_mappr/src/builder/methods/method_builder_base.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';

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
        ..optionalParameters.add(
          Parameter(
            (p) => p
              ..name = 'onMappingError'
              ..type = refer('void Function(Object error, StackTrace stackTrace, SOURCE? source)?')
              ..named = true,
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
    // if (canConvert<SOURCE, TARGET>(recursive: false)) {
    //   return _safeConvert(model, onMappingError: onMappingError);
    // }
    block.statements.add(
      ExpressionExtension.ifStatement(
        condition: CanConvertMethodBuilder(config).methodCall(namedArguments: {'recursive': literalFalse}),
        ifBody: refer('_safeConvert')
            .call([refer('model')], {'onMappingError': refer('onMappingError')})
            .returned
            .statement,
      ).code,
    );

    // Generates code like:
    //
    // for (final mappr in _delegates) {
    //   if (mappr.canConvert<SOURCE, TARGET>()) {
    //     return mappr.tryConvert(model, onMappingError: onMappingError);
    //   }
    // }
    final mapprReference = refer('mappr');
    block.statements.add(
      ExpressionExtension.forStatement(
        item: mapprReference,
        iterable: refer(MethodBuilderBase.delegatesField),
        body: ExpressionExtension.ifStatement(
          condition: CanConvertMethodBuilder(config).propertyCall(on: mapprReference),
          ifBody: mapprReference
              .property('tryConvert')
              .call([MethodBuilderBase.modelReference], {'onMappingError': refer('onMappingError')}, [])
              .returned
              .statement,
        ),
      ).code,
    );

    block.addExpression(literalNull.returned);

    return block.build();
  }
}
