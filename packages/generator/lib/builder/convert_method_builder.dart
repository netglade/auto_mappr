import 'package:auto_mapper_generator/models/auto_mapper_config.dart';
import 'package:code_builder/code_builder.dart';

import '../models/auto_map_part.dart';

/// Builds main `convert` method
class ConvertMethodBuilder {
  static Method buildCanConvert(AutoMapperConfig config) {
    return Method((b) => b
      ..name = 'canConvert'
      ..types.addAll([refer('I'), refer('R')])
      ..returns = refer('bool')
      ..body = _buildCanConvertBody(config.parts));
  }

  static Method buildConvertMethod() {
    return Method(
      (b) => b
        ..name = 'convert'
        ..types.addAll([refer('I'), refer('R')])
        ..requiredParameters.add(Parameter((p) => p
          ..name = 'model'
          ..type = refer('I')))
        ..returns = refer('R')
        ..lambda = false
        ..body = refer('_convert(model)').returned.statement,
    );
  }

  static Method buildInternalConvertMethod(AutoMapperConfig config) {
    return Method((b) => b
      ..name = '_convert'
      ..types.addAll([refer('I'), refer('R')])
      ..requiredParameters.add(Parameter((p) => p
        ..name = 'model'
        ..type = refer('I')))
      ..returns = refer('R')
      ..body = _buildConvertMethodBody(config.parts));
  }

  static Code? _buildConvertMethodBody(List<AutoMapPart> mappings) {
    final block = BlockBuilder();

    final dartEmitter = DartEmitter();

    for (var mapping in mappings) {
      final sourceName = mapping.source.getDisplayString(withNullability: false);
      final targetName = mapping.target.getDisplayString(withNullability: false);

      // I is SOURCE || SOURCE?
      final modelIsType = refer('_typeOf<I>()')
          .equalTo(refer('_typeOf<$sourceName>()'))
          .or(refer('_typeOf<I>()').equalTo(refer('_typeOf<$sourceName?>()')))
          .accept(dartEmitter);

      // R is TARGET || TARGET?
      final outputExpr = refer('_typeOf<R>()')
          .equalTo(refer('_typeOf<$targetName>()'))
          .or(refer('_typeOf<R>()').equalTo(refer('_typeOf<$targetName?>()')))
          .accept(dartEmitter);

      final ifCondition = '($modelIsType) && ($outputExpr)';

      final inIfExpr = refer(mapping.mappingMapMethodName)
          .call([
            refer('model').asA(mapping.sourceRefer),
          ])
          .asA(refer('R'))
          .returned
          .statement
          .accept(dartEmitter);

      final ifStatemnet = Code('''if( $ifCondition ) {$inIfExpr}''');

      block.statements.add(ifStatemnet);
    }

    block.addExpression(refer('Exception')
        .newInstance([refer('\'No mapping from \${model.runtimeType} -> \${_typeOf<R>()}\'')]).thrown);

    return block.build();
  }

  static Code? _buildCanConvertBody(List<AutoMapPart> mappings) {
    final block = BlockBuilder();

    final dartEmitter = DartEmitter();

    for (var mapping in mappings) {
      final outputExpr = refer('_typeOf<R>()').equalTo(refer(mapping.target.getDisplayString(withNullability: false)));

      final ifCondition = refer('_typeOf<I>()')
          .equalTo(refer('${mapping.source.getDisplayString(withNullability: false)}'))
          .and(outputExpr)
          .code
          .accept(dartEmitter);

      final ifStatemnet = Code('''if( $ifCondition ) {return true;}''');

      block.statements.add(ifStatemnet);
    }

    block.statements.add(Code('return false;'));

    return block.build();
  }
}
