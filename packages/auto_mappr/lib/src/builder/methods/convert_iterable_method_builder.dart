import 'package:auto_mappr/src/builder/methods/can_convert_method_builder.dart';
import 'package:auto_mappr/src/builder/methods/method_builder_base.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:auto_mappr/src/helpers/emitter_helper.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';

/// [wrapper] must be capitalized iterable, like `List`, `Iterable`, `Set`.
/// [iterableTransformer] is a method used after `.map` call like `toList` or `toSet`.
class ConvertIterableMethodBuilder extends MethodBuilderBase {
  final String wrapper;
  final String? iterableTransformer;

  const ConvertIterableMethodBuilder(
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
              ..type =
                  Reference('Iterable<${MethodBuilderBase.nullableSourceTypeReference.accept(EmitterHelper.current.emitter)}>'),
          ),
        )
        ..returns = Reference('$wrapper<${MethodBuilderBase.targetTypeReference.accept(EmitterHelper.current.emitter)}>')
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
        ? MethodBuilderBase.modelReference
            .property('map')
            .call([refer('(item) => _convert(item)').nullChecked], {}, [MethodBuilderBase.targetTypeReference])
        : refer('convertIterable')
            .call([MethodBuilderBase.modelReference], {}, [MethodBuilderBase.sourceTypeReference, MethodBuilderBase.targetTypeReference])
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
    final mapprReference = refer('mappr');
    block.statements.add(
      ExpressionExtension.forStatement(
        item: mapprReference,
        iterable: refer(MethodBuilderBase.delegatesField),
        body: ExpressionExtension.ifStatement(
          condition: CanConvertMethodBuilder(config).propertyCall(on: mapprReference),
          ifBody: mapprReference.property('convert$wrapper').call([MethodBuilderBase.modelReference], {}, []).returned.statement,
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
