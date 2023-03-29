import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:auto_mappr/src/models/auto_mappr_config.dart';
import 'package:auto_mappr/src/models/type_mapping.dart';
import 'package:code_builder/code_builder.dart';

/// Builds main `convert` method
class ConvertMethodBuilder {
  static const sourceKey = 'SOURCE';
  static const sourceTypeReference = Reference(sourceKey);
  static const nullableSourceTypeReference = Reference('$sourceKey?');
  static const sourceTypeOf = Reference('_typeOf<$sourceKey>()');

  static const targetKey = 'TARGET';
  static const targetTypeReference = Reference(targetKey);
  static const targetTypeOf = Reference('_typeOf<$targetKey>()');

  final Set<TypeMapping> _nullableMappings;

  ConvertMethodBuilder() : _nullableMappings = {};

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

  Method buildCanConvert(AutoMapprConfig config) {
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
        ..types.addAll([sourceTypeReference, targetTypeReference])
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'model'
              ..type = nullableSourceTypeReference,
          ),
        )
        ..returns = targetTypeReference
        ..lambda = false
        ..body = refer('_convert(model)').returned.statement,
    );
  }

  Method buildInternalConvertMethod(AutoMapprConfig config) {
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
        ..returns = targetTypeReference
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
      final sourceName = mapping.source.getDisplayString(withNullability: false);
      final targetName = mapping.target.getDisplayString(withNullability: false);

      final modelIsTypeExpression = sourceTypeOfReference
          .equalTo(refer('_typeOf<$sourceName>()'))
          .or(sourceTypeOfReference.equalTo(refer('_typeOf<$sourceName?>()')));

      final outputExpression = targetTypeOfReference
          .equalTo(refer('_typeOf<$targetName>()'))
          .or(targetTypeOfReference.equalTo(refer('_typeOf<$targetName?>()')));

      final ifConditionExpression = modelIsTypeExpression.bracketed().and(outputExpression.bracketed());

      final inIfExpression = refer(mapping.mappingMethodName)
          .call(
            [
              refer('model').asA(refer('${mapping.source.getDisplayString(withNullability: false)}?')),
            ],
          )
          .asA(targetTypeReference)
          .returned
          .statement;

      final ifStatementExpression = ifConditionExpression.ifStatement(ifBody: inIfExpression);

      // Generates code like:
      //
      // final sourceTypeOf = _typeOf<SOURCE>();
      // final targetTypeOf = _typeOf<TARGET>();
      // if ((sourceTypeOf == _typeOf<UserDto>() ||
      //         sourceTypeOf == _typeOf<UserDto?>()) &&
      //     (targetTypeOf == _typeOf<User>() || targetTypeOf == _typeOf<User?>())) {
      //   return (_map_UserDto$_To_User$((model as UserDto?)) as TARGET);
      // }
      block.statements.add(ifStatementExpression.code);
    }

    block.addExpression(
      refer('Exception').newInstance(
        [refer("'No mapping from \${model.runtimeType} -> \$${targetTypeOfReference.accept(DartEmitter())}'")],
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
}
