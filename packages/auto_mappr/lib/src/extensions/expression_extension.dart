import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

extension ExpressionExtension on Expression {
  Expression maybeToIterableCall({
    required DartType source,
    required DartType target,
    required bool forceCast,
    required bool isOnNullable,
  }) {
    if ((!source.isDartCoreList || forceCast) && target.isDartCoreList) {
      return maybeProperty('toList', isOnNullable: isOnNullable).call([]);
    }

    if ((!source.isDartCoreSet || forceCast) && target.isDartCoreSet) {
      return maybeProperty('toSet', isOnNullable: isOnNullable).call([]);
    }

    // Keep iterable as is.
    return this;
  }

  Expression maybeProperty(
    String name, {
    required bool isOnNullable,
  }) {
    if (!isOnNullable) return property(name);

    return nullSafeProperty(name);
  }

  Expression maybeNullSafeProperty(
    String name, {
    required bool isOnNullable,
  }) {
    return isOnNullable ? nullSafeProperty(name) : property(name);
  }

  Expression maybeIfNullThen(
    Expression other, {
    required bool isOnNullable,
  }) {
    if (!isOnNullable) return this;

    return ifNullThen(other);
  }

  Expression maybeWhereListLikeNotNull({
    required bool condition,
    required bool isOnNullable,
  }) {
    if (!condition) return this;

    return maybeNullSafeProperty('whereNotNull', isOnNullable: isOnNullable).call([], {}, []);
  }

  Expression maybeWhereMapNotNull({
    required bool condition,
    required bool isOnNullable,
    required DartType keyType,
    required DartType valueType,
  }) {
    if (!condition) return this;

    return maybeNullSafeProperty('where', isOnNullable: isOnNullable).call(
      [refer('(key, value) => key != null && value != null')],
      {},
      [
        refer(keyType.getDisplayString(withNullability: false)),
        refer(valueType.getDisplayString(withNullability: false)),
      ],
    );
  }

  Expression maybeAsA(
    Expression expression, {
    required bool condition,
  }) {
    if (!condition) return this;

    return asA(expression);
  }

  Expression ifStatement({required Spec ifBody, Spec? elseBody}) {
    final dartEmitter = DartEmitter();

    final ifBlock = '{ ${ifBody.accept(dartEmitter)} }';
    final elseBlock = (elseBody != null) ? 'else { ${elseBody.accept(dartEmitter)} }' : '';

    return refer('''if ( ${accept(dartEmitter)} ) $ifBlock $elseBlock''');
  }

  Expression bracketed() {
    return refer('(${accept(DartEmitter())})');
  }

  Expression nullabled() {
    return refer('${accept(DartEmitter())}?');
  }
}