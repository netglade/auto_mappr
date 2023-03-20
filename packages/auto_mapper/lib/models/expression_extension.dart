import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

extension ExpressionExtension on Expression {
  Expression maybeToIterableCall(DartType target) {
    if (target.isDartCoreList) {
      return property('toList').call([]);
    }

    if (target.isDartCoreSet) {
      return property('toSet').call([]);
    }

    // Keep iterable as is.
    return this;
  }

  Expression maybeNullSafeProperty(
    String name, {
    required bool isNullable,
  }) {
    return isNullable ? nullSafeProperty(name) : property(name);
  }

  Expression maybeIfNullThen(
    Expression other, {
    required bool isNullable,
  }) {
    if (!isNullable) return this;

    return ifNullThen(other);
  }
}
