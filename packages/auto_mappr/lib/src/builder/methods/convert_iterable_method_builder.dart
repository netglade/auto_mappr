import 'package:auto_mappr/src/builder/methods/auto_mappr_method_builder.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';

/// [wrapper] must be capitalized iterable, like `List`, `Iterable`, `Set`.
/// [iterableTransformer] is a method used after `.map` call like `toList` or `toSet`.
class ConvertIterableMethodBuilder extends AutoMapprMethodBuilder {
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
          config.availableMappingsMacroDocComment,
        ])
        ..annotations = AutoMapprMethodBuilder.overrideAnnotation
        ..types.addAll([AutoMapprMethodBuilder.sourceTypeReference, AutoMapprMethodBuilder.targetTypeReference])
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'model'
              ..type =
                  Reference('Iterable<${AutoMapprMethodBuilder.nullableSourceTypeReference.accept(DartEmitter())}>'),
          ),
        )
        ..returns = Reference('$wrapper<${AutoMapprMethodBuilder.targetTypeReference.accept(DartEmitter())}>')
        ..lambda = true
        ..body = buildBody(),
    );
  }

  @override
  Code buildBody() {
    if (iterableTransformer != null) {
      return refer('convertIterable')
          .call(
            [refer('model')],
            {},
            [AutoMapprMethodBuilder.sourceTypeReference, AutoMapprMethodBuilder.targetTypeReference],
          )
          .property(iterableTransformer!)
          .call([])
          .code;
    }

    return refer('model').property('map').call(
      [refer('(item) => _convert(item)').nullChecked],
      {},
      [AutoMapprMethodBuilder.targetTypeReference],
    ).code;
  }
}
