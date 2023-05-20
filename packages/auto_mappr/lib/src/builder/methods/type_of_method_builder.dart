import 'package:auto_mappr/src/builder/methods/auto_mappr_method_builder.dart';
import 'package:code_builder/code_builder.dart';

class TypeOfMethodBuilder extends AutoMapprMethodBuilder {
  TypeOfMethodBuilder(super.config);

  @override
  Method buildMethod() {
    return Method(
      (builder) => builder
        ..name = '_typeOf'
        ..types.add(refer('T'))
        ..returns = refer('Type')
        ..lambda = true
        ..body = buildBody(),
    );
  }

  @override
  Code buildBody() {
    return const Code('T');
  }
}
