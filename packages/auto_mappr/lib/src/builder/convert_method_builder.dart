import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:auto_mappr/src/models/auto_mappr_config.dart';
import 'package:auto_mappr/src/models/type_mapping.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';

/// Builds main `convert` method
class ConvertMethodBuilder {
  static const sourceKey = 'SOURCE';
  static const sourceTypeReference = Reference(sourceKey);
  static const nullableSourceTypeReference = Reference('$sourceKey?');
  static const sourceTypeOf = Reference('_typeOf<$sourceKey>()');

  static const targetKey = 'TARGET';
  static const targetTypeReference = Reference(targetKey);
  static const nullableTargetTypeReference = Reference('$targetKey?');
  static const targetTypeOf = Reference('_typeOf<$targetKey>()');

  final AutoMapprConfig config;
  final Set<TypeMapping> _nullableMappings;

  ConvertMethodBuilder(this.config) : _nullableMappings = {};

  static String concreteConvertMethodName({
    required DartType source,
    required DartType target,
  }) =>
      '_map_${source.toConvertMethodName(withNullability: false)}_To_${target.toConvertMethodName(withNullability: false)}';

  static String concreteNullableConvertMethodName({
    required DartType source,
    required DartType target,
  }) =>
      '${concreteConvertMethodName(source: source, target: target)}_Nullable';

  bool shouldGenerateNullableMappingMethod(TypeMapping mapping) {
    return _nullableMappings.contains(mapping);
  }

  void usedNullableMappingMethod(TypeMapping? mapping) {
    if (mapping == null) return;

    final _ = _nullableMappings.add(mapping);
  }

  Method buildCanConvert() {
    return Method(
      (b) => b
        ..name = 'canConvert'
        ..types.addAll([sourceTypeReference, targetTypeReference])
        ..returns = refer('bool')
        ..body = _buildCanConvertBody(config.mappers),
    );
  }

  Method buildConvertMethod() {
    return Method(
      (b) => b
        ..name = 'convert'
        ..docs = ListBuilder([
          '/// Converts from SOURCE to TARGET if such mapping is configured.',
          '///',
          '/// If source model is null and `whenSourceIsNull` is not defined, convert methods throws exception.',
          '///',
          '/// Available mappings: ',
          ...config.getMappingsDocComments(),
        ])
        ..types.addAll([sourceTypeReference, targetTypeReference])
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'model'
              ..type = nullableSourceTypeReference,
          ),
        )
        ..returns = targetTypeReference
        ..lambda = true
        ..body = refer('_convert(model)').nullChecked.code,
    );
  }

  Method buildTryConvertMethod() {
    return Method(
      (b) => b
        ..name = 'tryConvert'
        ..docs = ListBuilder([
          '/// Converts from SOURCE to TARGET if such mapping is configured.',
          '///',
          '/// If source model is null returns value from `whenSourceIsNull` if defined or null.',
          '///',
          '/// Available mappings: ',
          ...config.getMappingsDocComments(),
        ])
        ..types.addAll([sourceTypeReference, targetTypeReference])
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'model'
              ..type = nullableSourceTypeReference,
          ),
        )
        ..returns = nullableTargetTypeReference
        ..lambda = false
        ..body = refer('_convert')
            .call(
              [refer('model')],
              {'checkForNull': refer('true')},
              [sourceTypeReference, targetTypeReference],
            )
            .returned
            .statement,
    );
  }

  Method buildInternalConvertMethod() {
    return Method(
      (b) => b
        ..name = '_convert'
        ..types.addAll([sourceTypeReference, targetTypeReference])
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'model'
              ..type = nullableSourceTypeReference,
          ),
        )
        ..optionalParameters.add(
          Parameter(
            (p) => p
              ..name = 'checkForNull'
              ..type = refer('bool')
              ..named = true
              ..defaultTo = const Code('false'),
          ),
        )
        ..returns = nullableTargetTypeReference
        ..body = _buildConvertMethodBody(config.mappers),
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

    final sourceTypeOfVariable = declareFinal('sourceTypeOf').assign(sourceTypeOf);
    final sourceTypeOfReference = refer('sourceTypeOf');
    block.addExpression(sourceTypeOfVariable);

    final targetTypeOfVariable = declareFinal('targetTypeOf').assign(targetTypeOf);
    final targetTypeOfReference = refer('targetTypeOf');
    block.addExpression(targetTypeOfVariable);

    for (final mapping in mappings) {
      final ifCheckForNull = refer('checkForNull').and(refer('model').equalToNull()).ifStatement(
            ifBody: mapping.hasWhenNullDefault()
                ? mapping.whenSourceIsNullExpression!.asA(targetTypeReference).returned.statement
                : refer('null').returned.statement,
          );

      // Generates code like:
      //
      // final sourceTypeOf = _typeOf<SOURCE>();
      // final targetTypeOf = _typeOf<TARGET>();
      // if ((sourceTypeOf == _typeOf<UserDto>() ||
      //         sourceTypeOf == _typeOf<UserDto?>()) &&
      //     (targetTypeOf == _typeOf<User>() || targetTypeOf == _typeOf<User?>())) {
      //   return (_map_UserDto$_To_User$((model as UserDto?)) as TARGET);
      // }
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
                    .asA(targetTypeReference)
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
      final outputExpression =
          refer('_typeOf<$targetKey>()').equalTo(refer(mapping.target.getDisplayString(withNullability: false)));

      final ifConditionExpression = refer('_typeOf<$sourceKey>()')
          .equalTo(refer(mapping.source.getDisplayString(withNullability: false)))
          .and(outputExpression);

      final ifStatement = ifConditionExpression.ifStatement(ifBody: literalTrue.returned.statement);

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
    final sourceName = mapping.source.getDisplayString(withNullability: false);
    final targetName = mapping.target.getDisplayString(withNullability: false);

    final modelIsTypeExpression = sourceTypeOfReference
        .equalTo(refer('_typeOf<$sourceName>()'))
        .or(sourceTypeOfReference.equalTo(refer('_typeOf<$sourceName?>()')));

    final outputExpression = targetTypeOfReference
        .equalTo(refer('_typeOf<$targetName>()'))
        .or(targetTypeOfReference.equalTo(refer('_typeOf<$targetName?>()')));

    final ifConditionExpression = modelIsTypeExpression.bracketed().and(outputExpression.bracketed());

    return ifConditionExpression.ifStatement(ifBody: inIfExpression);
  }
}
