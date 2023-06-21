import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:auto_mappr/src/models/auto_mappr_config.dart';
import 'package:auto_mappr/src/models/type_mapping.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';

/// Builds main `convert` method
class ConvertMethodBuilder {
  static const _sourceKey = 'SOURCE';
  static const _sourceTypeReference = Reference(_sourceKey);
  static const _nullableSourceTypeReference = Reference('$_sourceKey?');
  static const _sourceTypeOf = Reference('_typeOf<$_sourceKey>()');

  static const _targetKey = 'TARGET';
  static const _targetTypeReference = Reference(_targetKey);
  static const _nullableTargetTypeReference = Reference('$_targetKey?');
  static const _targetTypeOf = Reference('_typeOf<$_targetKey>()');

  final AutoMapprConfig _config;

  ConvertMethodBuilder(this._config);

  Method buildCanConvert() {
    return Method(
      (b) => b
        ..name = 'canConvert'
        ..types.addAll([_sourceTypeReference, _targetTypeReference])
        ..returns = refer('bool')
        ..body = _buildCanConvertBody(_config.mappers),
    );
  }

  Method buildConvertMethod() {
    return Method(
      (b) => b
        ..name = 'convert'
        ..docs = ListBuilder([
          '/// Converts from SOURCE to TARGET if such mapping is configured.',
          '///',
          '/// When source model is null, returns `whenSourceIsNull` if defined or throws an exception.',
          '///',
          _config.availableMappingsDocComment,
        ])
        ..types.addAll([_sourceTypeReference, _targetTypeReference])
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'model'
              ..type = _nullableSourceTypeReference,
          ),
        )
        ..returns = _targetTypeReference
        ..lambda = true
        ..body = refer('_convert').call([refer('model')], {}, []).nullChecked.code,
    );
  }

  Method buildTryConvertMethod() {
    return Method(
      (b) => b
        ..name = 'tryConvert'
        ..docs = ListBuilder([
          '/// Converts from SOURCE to TARGET if such mapping is configured.',
          '///',
          '/// When source model is null, returns `whenSourceIsNull` if defined or null.',
          '///',
          _config.availableMappingsDocComment,
        ])
        ..types.addAll([_sourceTypeReference, _targetTypeReference])
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'model'
              ..type = _nullableSourceTypeReference,
          ),
        )
        ..returns = _nullableTargetTypeReference
        ..lambda = true
        ..body = refer('_convert').call([refer('model')], {'canReturnNull': refer('true')}, []).code,
    );
  }

  /// [wrapper] must be capitalized iterable, like `List`, `Iterable`, `Set`.
  /// [iterableTransformer] is a method used after `.map` call like `toList` or `toSet`.
  Method buildConvertIterableMethod({
    required String wrapper,
    String? iterableTransformer,
  }) {
    return Method(
      (b) => b
        ..name = 'convert$wrapper'
        ..docs = ListBuilder([
          '/// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into $wrapper.',
          '///',
          '/// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or throws an exception.',
          '///',
          _config.availableMappingsDocComment,
        ])
        ..types.addAll([_sourceTypeReference, _targetTypeReference])
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'model'
              ..type = Reference('Iterable<${_nullableSourceTypeReference.accept(DartEmitter())}>'),
          ),
        )
        ..returns = Reference('$wrapper<${_targetTypeReference.accept(DartEmitter())}>')
        ..lambda = true
        ..body = iterableTransformer != null
            ? refer('convertIterable')
                .call(
                  [refer('model')],
                  {},
                  [_sourceTypeReference, _targetTypeReference],
                )
                .property(iterableTransformer)
                .call([])
                .code
            : refer('model').property('map').call(
                [refer('(item) => _convert(item)').nullChecked],
                {},
                [_targetTypeReference],
              ).code,
    );
  }

  /// [wrapper] must be capitalized iterable, like `List`, `Iterable`, `Set`.
  /// [iterableTransformer] is a method used after `.map` call like `toList` or `toSet`.
  Method buildTryConvertIterableMethod({
    required String wrapper,
    String? iterableTransformer,
  }) {
    return Method(
      (b) => b
        ..name = 'tryConvert$wrapper'
        ..docs = ListBuilder([
          '/// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into $wrapper.',
          '///',
          '/// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null',
          '///',
          _config.availableMappingsDocComment,
        ])
        ..types.addAll([_sourceTypeReference, _targetTypeReference])
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'model'
              ..type = Reference('Iterable<${_nullableSourceTypeReference.accept(DartEmitter())}>'),
          ),
        )
        ..returns = Reference('$wrapper<${_nullableTargetTypeReference.accept(DartEmitter())}>')
        ..lambda = true
        ..body = iterableTransformer != null
            ? refer('tryConvertIterable')
                .call(
                  [refer('model')],
                  {},
                  [_sourceTypeReference, _targetTypeReference],
                )
                .property(iterableTransformer)
                .call([])
                .code
            : refer('model').property('map').call(
                [refer('(item) => _convert(item, canReturnNull: true)')],
                {},
                [_nullableTargetTypeReference],
              ).code,
    );
  }

  Method buildInternalConvertMethod() {
    return Method(
      (b) => b
        ..name = '_convert'
        ..types.addAll([_sourceTypeReference, _targetTypeReference])
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'model'
              ..type = _nullableSourceTypeReference,
          ),
        )
        ..optionalParameters.add(
          Parameter(
            (p) => p
              ..name = 'canReturnNull'
              ..type = refer('bool')
              ..named = true
              ..defaultTo = const Code('false'),
          ),
        )
        ..returns = _nullableTargetTypeReference
        ..body = _buildConvertMethodBody(_config.mappers),
    );
  }

  Method buildTypeOfHelperMethod() {
    return Method(
      (b) => b
        ..name = '_typeOf'
        ..types.add(refer('T'))
        ..returns = refer('Type')
        ..lambda = true
        ..body = const Code('T'),
    );
  }

  Code? _buildConvertMethodBody(List<TypeMapping> mappings) {
    final block = BlockBuilder();

    final sourceTypeOfVariable = declareFinal('sourceTypeOf').assign(_sourceTypeOf);
    final sourceTypeOfReference = refer('sourceTypeOf');
    block.addExpression(sourceTypeOfVariable);

    final targetTypeOfVariable = declareFinal('targetTypeOf').assign(_targetTypeOf);
    final targetTypeOfReference = refer('targetTypeOf');
    block.addExpression(targetTypeOfVariable);

    for (final mapping in mappings) {
      final ifCheckForNull = refer('canReturnNull').and(refer('model').equalToNull()).ifStatement2(
            ifBody: mapping.hasWhenNullDefault()
                ? mapping.whenSourceIsNullExpression!.asA(_targetTypeReference).returned.statement
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
      final ifCheckTypeMatchExpression = _buildMatchingIfCondition(
        mapping: mapping,
        sourceTypeOfReference: sourceTypeOfReference,
        targetTypeOfReference: targetTypeOfReference,
        inIfExpression: (BlockBuilder()
              ..statements.add(ifCheckForNull.code)
              ..addExpression(
                refer(mapping.mappingMethodName(config: _config))
                    .call(
                      [
                        refer('model').asA(
                          refer('${mapping.source.getDisplayStringWithLibraryAlias(config: _config)}?'),
                        ),
                      ],
                    )
                    .asA(_targetTypeReference)
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

  Code? _buildCanConvertBody(List<TypeMapping> mappings) {
    final block = BlockBuilder();

    for (final mapping in mappings) {
      final outputExpression = refer('_typeOf<$_targetKey>()').equalTo(
        refer(
          mapping.target.getDisplayStringWithLibraryAlias(config: _config),
        ),
      );

      final ifConditionExpression = refer('_typeOf<$_sourceKey>()')
          .equalTo(refer(mapping.source.getDisplayStringWithLibraryAlias(config: _config)))
          .and(outputExpression);

      final ifStatement = ifConditionExpression.ifStatement2(ifBody: literalTrue.returned.statement);

      block.statements.add(ifStatement.code);
    }

    block.statements.add(literalFalse.returned.statement);

    return block.build();
  }

  Expression _buildMatchingIfCondition({
    required TypeMapping mapping,
    required Reference sourceTypeOfReference,
    required Reference targetTypeOfReference,
    required Spec inIfExpression,
  }) {
    final sourceName = mapping.source.getDisplayStringWithLibraryAlias(config: _config);
    final targetName = mapping.target.getDisplayStringWithLibraryAlias(config: _config);

    final modelIsTypeExpression = sourceTypeOfReference
        .equalTo(refer('_typeOf<$sourceName>()'))
        .or(sourceTypeOfReference.equalTo(refer('_typeOf<$sourceName?>()')));

    final outputExpression = targetTypeOfReference
        .equalTo(refer('_typeOf<$targetName>()'))
        .or(targetTypeOfReference.equalTo(refer('_typeOf<$targetName?>()')));

    final ifConditionExpression = modelIsTypeExpression.bracketed().and(outputExpression.bracketed());

    return ifConditionExpression.ifStatement2(ifBody: inIfExpression);
  }
}
