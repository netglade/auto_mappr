import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/models/auto_mappr_config.dart';
import 'package:code_builder/code_builder.dart';

extension ExpressionExtension on Expression {
  Expression maybeToIterableCall({
    required DartType source,
    required DartType target,
    required bool forceCast,
    required bool isOnNullable,
  }) {
    if (((!source.isDartCoreList && !source.isSpecializedListType) || forceCast) && target.isDartCoreList) {
      return maybeProperty('toList', isOnNullable: isOnNullable).call([]);
    }

    if ((!source.isDartCoreSet || forceCast) && target.isDartCoreSet) {
      return maybeProperty('toSet', isOnNullable: isOnNullable).call([]);
    }

    if ((source.isDartCoreList || forceCast) && target.isSpecializedListType) {
      return refer(target.getDisplayString(withNullability: false)).property('fromList').call([this]);
    }

    // Keep iterable as is.
    return this;
  }

  Expression maybeProperty(
    String name, {
    required bool isOnNullable,
    bool condition = true,
  }) {
    if (!condition) {
      return this;
    }

    if (!isOnNullable) return property(name);

    return nullSafeProperty(name);
  }

  Expression maybeNullSafeProperty(
    String name, {
    required bool isOnNullable,
  }) {
    return isOnNullable ? nullSafeProperty(name) : property(name);
  }

  Expression maybeCall(
    String name, {
    required bool isOnNullable,
    Iterable<Expression> positionalArguments = const [],
    bool condition = false,
    Map<String, Expression> namedArguments = const {},
    List<Reference> typeArguments = const [],
  }) {
    if (!condition) {
      return this;
    }

    return maybeNullSafeProperty(name, isOnNullable: isOnNullable)
        .call(positionalArguments, namedArguments, typeArguments);
  }

  Expression maybeIfNullThen(
    Expression other, {
    required bool isOnNullable,
  }) {
    if (!isOnNullable) return this;

    return ifNullThen(other);
  }

  Expression maybeWhereIterableNotNull({
    required bool condition,
    required bool isOnNullable,
  }) {
    if (!condition) return this;

    return maybeNullSafeProperty('whereNotNull', isOnNullable: isOnNullable).call([], {}, []);
  }

  Expression maybeWhereMapNotNull({
    required bool isOnNullable,
    required bool keyIsNullable,
    required bool valueIsNullable,
    required DartType keyType,
    required DartType valueType,
    required AutoMapprConfig config,
  }) {
    if (!(keyIsNullable || valueIsNullable)) return this;

    final keyCondition = keyIsNullable ? 'key != null' : '';
    final and = (keyIsNullable && valueIsNullable) ? '&&' : '';
    final valueCondition = valueIsNullable ? 'value != null' : '';

    return maybeNullSafeProperty('where', isOnNullable: isOnNullable).call(
      [
        refer('(key, value) => $keyCondition $and $valueCondition'),
      ],
      {},
      [
        refer(keyType.getDisplayStringWithLibraryAlias(config: config)),
        refer(valueType.getDisplayStringWithLibraryAlias(config: config)),
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

  static Expression ifStatement({
    required Spec condition,
    required Spec ifBody,
    Spec? elseBody,
  }) {
    final dartEmitter = DartEmitter();

    final ifBlock = '{ ${ifBody.accept(dartEmitter)} }';
    final elseBlock = (elseBody != null) ? 'else { ${elseBody.accept(dartEmitter)} }' : '';

    return refer('''if ( ${condition.accept(dartEmitter)} ) $ifBlock $elseBlock''');
  }

  Expression ifStatement2({required Spec ifBody, Spec? elseBody}) {
    final dartEmitter = DartEmitter();

    final ifBlock = '{ ${ifBody.accept(dartEmitter)} }';
    final elseBlock = (elseBody != null) ? 'else { ${elseBody.accept(dartEmitter)} }' : '';

    return refer('''if ( ${accept(dartEmitter)} ) $ifBlock $elseBlock''');
  }

  static Expression forStatement({
    required Reference item,
    required Reference iterable,
    required Spec body,
  }) {
    final dartEmitter = DartEmitter();

    return refer('''
for (final ${item.accept(dartEmitter)} in ${iterable.accept(dartEmitter)}) {
  ${body.accept(dartEmitter)}
} 
''');
  }

  Expression bracketed() {
    return refer('(${accept(DartEmitter())})');
  }

  Expression nullabled() {
    return refer('${accept(DartEmitter())}?');
  }

  Expression equalToNull() => equalTo(literalNull);
}
