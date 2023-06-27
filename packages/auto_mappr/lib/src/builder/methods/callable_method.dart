import 'package:code_builder/code_builder.dart';

// ignore: one_member_abstracts, it is implemented in builders
abstract class CallableMethod {
  const CallableMethod();

  Expression methodCall({Map<String, Expression> namedArguments = const {}});

  
}
