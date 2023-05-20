import 'package:auto_mappr/src/builder/methods/auto_mappr_method_builder.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';

/// [wrapper] must be capitalized iterable, like `List`, `Iterable`, `Set`.
/// [iterableTransformer] is a method used after `.map` call like `toList` or `toSet`.
class TryConvertIterableMethodBuilder extends AutoMapprMethodBuilder {
  final String wrapper;
  final String? iterableTransformer;

  TryConvertIterableMethodBuilder(
    super.config, {
    required this.wrapper,
    this.iterableTransformer,
  });

  @override
  Method buildMethod() {
    return Method(
      (b) => b
        ..name = 'tryConvert$wrapper'
        ..docs = ListBuilder([
          '/// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into $wrapper.',
          '///',
          '/// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null',
          '///',
          config.availableMappingsMacroDocComment,
        ])
        ..types.addAll([AutoMapprMethodBuilder.sourceTypeReference, AutoMapprMethodBuilder.targetTypeReference])
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'model'
              ..type =
                  Reference('Iterable<${AutoMapprMethodBuilder.nullableSourceTypeReference.accept(DartEmitter())}>'),
          ),
        )
        ..returns = Reference('$wrapper<${AutoMapprMethodBuilder.nullableTargetTypeReference.accept(DartEmitter())}>')
        ..lambda = true
        ..body = buildBody(),
    );
  }

  @override
  Code buildBody() {
    if (iterableTransformer != null) {
      return refer('tryConvertIterable')
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
      [refer('(item) => _convert(item, canReturnNull: true)')],
      {},
      [AutoMapprMethodBuilder.nullableTargetTypeReference],
    ).code;
  }
}
