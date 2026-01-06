import 'package:auto_mappr/src/builder/methods/method_builder_base.dart';
import 'package:auto_mappr/src/helpers/emitter_helper.dart';
import 'package:auto_mappr/src/helpers/urls.dart';
import 'package:code_builder/code_builder.dart';

class PrivateModulesMethodBuilder extends MethodBuilderBase {
  const PrivateModulesMethodBuilder(super.config);

  @override
  Method buildMethod() {
    final interfaceRefer = EmitterHelper.current.referEmitted('AutoMapprInterface', Urls.annotationPackageUrl);

    return Method(
      (builder) => builder
        ..name = MethodBuilderBase.delegatesField
        ..returns = refer('List<$interfaceRefer>')
        ..lambda = true
        ..type = MethodType.getter
        ..body = buildBody(),
    );
  }

  @override
  Code buildBody() {
    // ignore: avoid-default-tostring, should be ok
    return refer('const ${(config.modulesCode ?? literalList([])).accept(EmitterHelper.current.emitter)}').code;
  }
}
