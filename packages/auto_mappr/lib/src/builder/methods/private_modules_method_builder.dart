import 'package:auto_mappr/src/builder/methods/auto_mappr_method_builder.dart';
import 'package:code_builder/code_builder.dart';

class PrivateModulesMethodBuilder extends AutoMapprMethodBuilder {
  PrivateModulesMethodBuilder(super.config);

  @override
  Method buildMethod() {
    return Method(
      (builder) => builder
        ..name = '_modules'
        ..returns = refer('List<AutoMapprInterface>')
        ..lambda = true
        ..type = MethodType.getter
        ..body = buildBody(),
    );
  }

  @override
  Code buildBody() {
    return refer('const ${(config.modules ?? literalList([])).accept(DartEmitter())}').code;
  }
}
