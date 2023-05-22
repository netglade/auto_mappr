import 'package:auto_mappr/src/builder/methods/method_builder_base.dart';
import 'package:code_builder/code_builder.dart';

class PrivateModulesMethodBuilder extends MethodBuilderBase {
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
    return refer('const ${(config.modulesCode ?? literalList([])).accept(DartEmitter())}').code;
  }
}
