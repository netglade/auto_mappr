import 'package:auto_mappr/src/builder/methods/can_convert_method_builder.dart';
import 'package:auto_mappr/src/builder/methods/method_builder_base.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';

/// [wrapper] must be capitalized iterable, like `List`, `Iterable`, `Set`.
/// [iterableTransformer] is a method used after `.map` call like `toList` or `toSet`.
class ConvertIterableMethodBuilder extends MethodBuilderBase {
  final String wrapper;
  final String? iterableTransformer;

  ConvertIterableMethodBuilder(
    super.config, {
    required this.wrapper,
    this.iterableTransformer,
  });

  @override
  Method buildMethod() {
    return Method(
      (b) => b
        ..name = 'convert$wrapper'
        ..docs = ListBuilder([
          '/// {@macro AutoMapprInterface:convert$wrapper}',
          config.availableMappingsDocComment,
        ])
        ..annotations = MethodBuilderBase.overrideAnnotation
        ..types.addAll([MethodBuilderBase.sourceTypeReference, MethodBuilderBase.targetTypeReference])
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'model'
              ..type = Reference('Iterable<${MethodBuilderBase.nullableSourceTypeReference.accept(DartEmitter())}>'),
          ),
        )
        ..returns = Reference('$wrapper<${MethodBuilderBase.targetTypeReference.accept(DartEmitter())}>')
        ..body = buildBody(),
    );
  }

  @override
  Code buildBody() {
    final block = BlockBuilder();

    // Generates code like:
    //
    // for Iterable:
    // model.map<TARGET>((item) => _convert(item)!)
    //
    // for List/Set:
    // convertIterable<SOURCE, TARGET>(model).toList()
    final convertIterableCall = iterableTransformer == null
        ? refer('model')
            .property('map')
            .call([refer('(item) => _convert(item)').nullChecked], {}, [MethodBuilderBase.targetTypeReference])
        : refer('convertIterable')
            .call([refer('model')], {}, [MethodBuilderBase.sourceTypeReference, MethodBuilderBase.targetTypeReference])
            .property(iterableTransformer!)
            .call([]);

    // Generates code like:
    //
    // if (canConvert<SOURCE, TARGET>()) {
    //   return convertIterableCall; // from above
    // }
    block.statements.add(
      ExpressionExtension.ifStatement(
        condition: CanConvertMethodBuilder(config).methodCall(namedArguments: {'recursive': literalFalse}),
        ifBody: convertIterableCall.returned.statement,
      ).code,
    );

    // Generates code like:
    //
    // for (final mappr in mappers) {
    //   if (mappr.canConvert<SOURCE, TARGET>()) {
    //     return mappr.convertIterable(model)!;
    //   }
    // }
    block.statements.add(
      ExpressionExtension.forStatement(
        item: refer('mappr'),
        iterable: refer(MethodBuilderBase.delegatesField),
        body: ExpressionExtension.ifStatement(
          condition: CanConvertMethodBuilder(config).propertyCall(on: refer('mappr')),
          ifBody: refer('mappr').property('convert$wrapper').call([refer('model')], {}, []).returned.statement,
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
