import 'package:code_builder/code_builder.dart';

// ignore: one_member_abstracts, it is implemented in builders
abstract interface class CallableProperty {
  const CallableProperty();

  Expression propertyCall({
    required Reference on,
    Map<String, Expression> namedArguments = const {},
  });
}
