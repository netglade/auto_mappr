import 'package:analyzer/dart/element/type.dart';
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

  static final ListBuilder<Reference> _overrideAnnotation = ListBuilder([const Reference('override')]);

  final AutoMapprConfig _config;
  final Set<TypeMapping> _nullableMappings;

  ConvertMethodBuilder(this._config) : _nullableMappings = {};

  static String constructConvertMethodName({
    required DartType source,
    required DartType target,
  }) =>
      '_map_${source.toConvertMethodName(withNullability: false)}_To_${target.toConvertMethodName(withNullability: false)}';

  static String constructNullableConvertMethodName({
    required DartType source,
    required DartType target,
  }) =>
      '${constructConvertMethodName(source: source, target: target)}_Nullable';

  bool shouldGenerateNullableMappingMethod(TypeMapping mapping) {
    return _nullableMappings.contains(mapping);
  }

  void usedNullableMappingMethod(TypeMapping? mapping) {
    if (mapping == null) return;

    final _ = _nullableMappings.add(mapping);
  }

  Method buildCanConvertMethod() {
    return Method(
      (b) => b
        ..name = 'canConvert'
        ..docs = ListBuilder([
          '/// {@macro AutoMapprInterface:canConvert}',
          _config.availableMappingsMacroDocComment,
        ])
        ..annotations = _overrideAnnotation
        ..types.addAll([_sourceTypeReference, _targetTypeReference])
        ..requiredParameters.addAll([
          Parameter(
            (p) => p
              ..name = 'model'
              ..type = _nullableSourceTypeReference,
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
        ..body = _buildCanConvertBody(_config.mappers),
    );
  }

  Method buildConvertMethod() {
    return Method(
      (b) => b
        ..name = 'convert'
        ..docs = ListBuilder([
          '/// {@macro AutoMapprInterface:convert}',
          _config.availableMappingsMacroDocComment,
        ])
        ..annotations = _overrideAnnotation
        ..types.addAll([_sourceTypeReference, _targetTypeReference])
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'model'
              ..type = _nullableSourceTypeReference,
          ),
        )
        ..returns = _targetTypeReference
        ..body = _buildConvertMethodBody(),
    );
  }

  Method buildTryConvertMethod() {
    return Method(
      (b) => b
        ..name = 'tryConvert'
        ..docs = ListBuilder([
          '/// {@macro AutoMapprInterface:tryConvert}',
          _config.availableMappingsMacroDocComment,
        ])
        ..annotations = _overrideAnnotation
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
          '/// {@macro AutoMapprInterface:convert$wrapper}',
          _config.availableMappingsMacroDocComment,
        ])
        ..annotations = _overrideAnnotation
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
          '/// {@macro AutoMapprInterface:tryConvert$wrapper}',
          _config.availableMappingsMacroDocComment,
        ])
        ..annotations = _overrideAnnotation
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
              ..defaultTo = literalFalse.code,
          ),
        )
        ..returns = _nullableTargetTypeReference
        ..body = _buildPrivateConvertMethodBody(_config.mappers),
    );
  }

  Method buildModulesGetter(Expression? modules) {
    return Method(
      (builder) => builder
        ..name = '_modules'
        ..returns = refer('List<AutoMapprInterface>')
        ..lambda = true
        ..type = MethodType.getter
        ..body = refer('const ${(modules ?? literalList([])).accept(DartEmitter())}').code,
    );
  }

  Method buildTypeOfHelperMethod() {
    return Method(
      (builder) => builder
        ..name = '_typeOf'
        ..types.add(refer('T'))
        ..returns = refer('Type')
        ..lambda = true
        ..body = const Code('T'),
    );
  }

  Code? _buildConvertMethodBody() {
    final block = BlockBuilder();

    // Generates code like:
    //
    // if (canConvert(model)) {
    //   return _convert(model)!;
    // }
    block.statements.add(
      ExpressionExtension.ifStatement(
        condition: refer('canConvert').call(
          [refer('model')],
          {'recursive': literalFalse},
          [_sourceTypeReference, _targetTypeReference],
        ),
        ifBody: refer('_convert').call([refer('model')], {}, []).nullChecked.returned.statement,
      ).code,
    );

    // Generates code like:
    //
    // for (final mappr in mappers) {
    //   if (mappr.canConvert(model)) {
    //     return mappr.convert(model)!;
    //   }
    // }
    block.statements.add(
      ExpressionExtension.forStatement(
        item: refer('mappr'),
        iterable: refer('_modules'),
        body: ExpressionExtension.ifStatement(
          condition: refer('mappr').property('canConvert').call(
            [refer('model')],
            {},
            [_sourceTypeReference, _targetTypeReference],
          ),
          ifBody: refer('mappr').property('convert').call([refer('model')], {}, []).nullChecked.returned.statement,
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

  Code? _buildPrivateConvertMethodBody(List<TypeMapping> mappings) {
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
                refer(mapping.mappingMethodName)
                    .call(
                      [
                        refer('model').asA(refer('${mapping.source.getDisplayString(withNullability: false)}?')),
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

    final sourceTypeOfVariable = declareFinal('sourceTypeOf').assign(_sourceTypeOf);
    final sourceTypeOfReference = refer('sourceTypeOf');
    block.addExpression(sourceTypeOfVariable);

    final targetTypeOfVariable = declareFinal('targetTypeOf').assign(_targetTypeOf);
    final targetTypeOfReference = refer('targetTypeOf');
    block.addExpression(targetTypeOfVariable);

    // Check this mappr.
    for (final mapping in mappings) {
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
      final ifCheckTypeMatchExpression = _buildMatchingIfCondition(
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
              [_sourceTypeReference, _targetTypeReference],
            ),
            ifBody: literalTrue.returned.statement,
          ),
        ),
      ).code,
    );

    block.statements.add(literalFalse.returned.statement);

    return block.build();
  }

  Expression _buildMatchingIfCondition({
    required TypeMapping mapping,
    required Reference sourceTypeOfReference,
    required Reference targetTypeOfReference,
    required Spec inIfExpression,
  }) {
    final sourceName = mapping.source.getDisplayString(withNullability: false);
    final targetName = mapping.target.getDisplayString(withNullability: false);

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
