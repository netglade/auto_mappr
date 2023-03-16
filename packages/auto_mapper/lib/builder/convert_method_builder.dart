import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mapper/models/auto_mapper_config.dart';
import 'package:code_builder/code_builder.dart';

import '../models/type_mapping.dart';

/// Builds main `convert` method
class ConvertMethodBuilder {
  static const sourceKey = 'SOURCE';
  static const sourceTypeReference = Reference(sourceKey);
  static const nullableSourceTypeReference = Reference('$sourceKey?');
  static const targetKey = 'TARGET';
  static const targetTypeReference = Reference(targetKey);

  static String concreteConvertMethodName(DartType source, DartType target) =>
      '_map${source.getDisplayString(withNullability: false)}To${target.getDisplayString(withNullability: false)}';

  static Method buildCanConvert(AutoMapperConfig config) {
    return Method((b) => b
      ..name = 'canConvert'
      ..types.addAll([sourceTypeReference, targetTypeReference])
      ..returns = refer('bool')
      ..body = _buildCanConvertBody(config.parts));
  }

  static Method buildConvertMethod() {
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
        ..body = refer('_convert(model, canReturnNull: false)').returned.statement,
    );
  }

  static Method buildInternalConvertMethod(AutoMapperConfig config) {
    return Method((b) => b
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
            ..name = 'canReturnNull'
            ..type = refer('bool')
            ..named = true
            ..defaultTo = Code('false'),
        ),
      )
      ..returns = targetTypeReference
      ..body = _buildConvertMethodBody(config.parts));
  }

  static Method buildTypeOfHelperMethod() {
    return Method(
      (b) => b
        ..name = '_typeOf'
        ..types.add(refer('T'))
        ..returns = refer('Type')
        ..lambda = true
        ..body = const Code('T'),
    );
  }

  static Code? _buildConvertMethodBody(List<TypeMapping> mappings) {
    final block = BlockBuilder();

    final dartEmitter = DartEmitter();

    for (var mapping in mappings) {
      final sourceName = mapping.source.getDisplayString(withNullability: false);
      final targetName = mapping.target.getDisplayString(withNullability: false);

      final modelIsType = refer('_typeOf<$sourceKey>()')
          .equalTo(refer('_typeOf<$sourceName>()'))
          .or(refer('_typeOf<$sourceKey>()').equalTo(refer('_typeOf<$sourceName?>()')))
          .accept(dartEmitter);

      final outputExpr = refer('_typeOf<$targetKey>()')
          .equalTo(refer('_typeOf<$targetName>()'))
          .or(refer('_typeOf<$targetKey>()').equalTo(refer('_typeOf<$targetName?>()')))
          .accept(dartEmitter);

      final ifCondition = '($modelIsType) && ($outputExpr)';

      final inIfExpr = refer(mapping.mappingMapMethodName)
          .call([
            refer('model').asA(refer('${mapping.source.getDisplayString(withNullability: false)}?')),
          ], {
            'canReturnNull': refer('canReturnNull')
          })
          .asA(targetTypeReference)
          .returned
          .statement
          .accept(DartEmitter());

      final ifStatement = Code('''if( $ifCondition ) {$inIfExpr}''');

      block.statements.add(ifStatement);
    }

    block.addExpression(refer('Exception')
        .newInstance([refer("'No mapping from \${model.runtimeType} -> \${_typeOf<$targetKey>()}'")]).thrown);

    return block.build();
  }

  static Code? _buildCanConvertBody(List<TypeMapping> mappings) {
    final block = BlockBuilder();

    final dartEmitter = DartEmitter();

    for (var mapping in mappings) {
      final outputExpr =
          refer('_typeOf<$targetKey>()').equalTo(refer(mapping.target.getDisplayString(withNullability: false)));

      final ifCondition = refer('_typeOf<$sourceKey>()')
          .equalTo(refer('${mapping.source.getDisplayString(withNullability: false)}'))
          .and(outputExpr)
          .code
          .accept(dartEmitter);

      final ifStatement = Code('if( $ifCondition ) {return true;}');

      block.statements.add(ifStatement);
    }

    block.statements.add(Code('return false;'));

    return block.build();
  }
}
