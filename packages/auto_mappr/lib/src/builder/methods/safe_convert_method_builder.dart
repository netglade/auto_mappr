import 'package:auto_mappr/src/builder/methods/methods.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:code_builder/code_builder.dart';

class SafeConvertMethodBuilder extends MethodBuilderBase {
  const SafeConvertMethodBuilder(super.config);

  @override
  Method buildMethod() {
    return Method(
      (b) => b
        ..name = '_safeConvert'
        ..types.addAll([MethodBuilderBase.sourceTypeReference, MethodBuilderBase.targetTypeReference])
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'model'
              ..type = MethodBuilderBase.nullableSourceTypeReference,
          ),
        )
        ..optionalParameters.add(
          Parameter(
            (p) => p
              // ignore: avoid-late-final-reassignment, false positive
              ..name = 'onMappingError'
              ..type = refer('void Function(Object error, StackTrace stackTrace, SOURCE? source)?')
              ..named = true,
          ),
        )
        ..returns = MethodBuilderBase.nullableTargetTypeReference
        ..body = buildBody(),
    );
  }

  @override
  Code buildBody() {
    final block = BlockBuilder();

    // Generates code like:
    //
    // if (!useSafeMapping<SOURCE, TARGET>()) {
    //   return _convert(
    //     model,
    //     canReturnNull: true,
    //   );
    // }
    block.statements.add(
      ExpressionExtension.ifStatement(
        condition: UseSafeMappingMethodBuilder(config).methodCall(),
        ifBody: refer('_convert').call([refer('model')], {'canReturnNull': refer('true')}, []).returned.statement,
        negation: true,
      ).code,
    );

    // Generates code like:
    //
    // try {
    //   return _convert(
    //     model,
    //     canReturnNull: true,
    //   );
    // } catch (e, s) {
    //   onMappingError?.call(e, s, model);
    //   return null;
    // }
    block.statements.add(
      refer('_convert')
          .call([refer('model')], {'canReturnNull': refer('true')}, [])
          .returned
          .tryCatchWrapped(catchBody: refer('onMappingError?.call(e, s, model)').statement)
          .code,
    );

    return block.build();
  }
}
