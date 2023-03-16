//ignore_for_file: no-object-declaration

import 'package:analyzer/dart/constant/value.dart';
import 'package:auto_mapper/models/models.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

extension DartObjectExtension on DartObject {
  /// If the top most object is a function, then return its code expression.
  ///
  /// Otherwise return code expression of literals or objects.
  Expression? toCodeExpression({
    bool passModelArgument = false,
  }) {
    if (isNull) {
      return null;
    }

    // If the top most object is function, call it.
    final asFunction = toFunctionValue();
    if (asFunction != null) {
      return refer(asFunction.referCallString).call([
        if (passModelArgument) refer('model'),
      ]);
    }

    final emitter = DartEmitter();
    final output = _toSpec().accept(emitter);

    return CodeExpression(Code('$output'));
  }

  Spec _toSpec() {
    final constant = ConstantReader(this);

    if (constant.isLiteral) {
      return _reviveLiteral();
    }

    /// Perhaps an object instantiation?
    return _reviveObject();
  }

  Spec _reviveLiteral() {
    final constant = ConstantReader(this);

    // Special literals

    if (constant.isSymbol) {
      return Code('Symbol(${constant.symbolValue})');
    }

    if (constant.isType) {
      return Code('Symbol(${constant.symbolValue})');
    }

    // Collections

    if (constant.isList) {
      return literalList(constant.listValue.map((item) => item._toSpec()));
    }

    if (constant.isSet) {
      return literalSet(constant.setValue.map((item) => item._toSpec()));
    }

    if (constant.isMap) {
      return literalMap(constant.mapValue.map((key, value) => MapEntry(key!._toSpec(), value!._toSpec())));
    }

    // int, double, String, num, null
    return literal(constant.literalValue);
  }

  Spec _reviveObject() {
    final revived = ConstantReader(this).revive();

    final location = revived.source.toString().split('#');

    /// Getters, Setters, Methods can't be declared as constants so this
    /// literal must either be a top-level constant or a static constant and
    /// can be directly accessed by `revived.accessor`.
    if (location.length <= 1) {
      return refer(revived.accessor);
    }

    /// If this is a class instantiation then `location[1]` will be populated
    /// with the class name.
    ///
    /// location[1] - class
    /// revived.accessor - named constructor
    final instantiation = location[1]; // + (revived.accessor.isNotEmpty ? '.${revived.accessor}' : '');
    final useNamedConstructor = revived.accessor.isNotEmpty;

    final revivedInstance = refer(instantiation);

    final positionalArguments =
        revived.positionalArguments.map<Expression>((argument) => argument._toSpec() as Expression);
    final namedArguments =
        revived.namedArguments.map<String, Expression>((key, value) => MapEntry(key, value._toSpec() as Expression));

    if (useNamedConstructor) {
      return revivedInstance.constInstanceNamed(revived.accessor, positionalArguments, namedArguments);
    }

    return revivedInstance.constInstance(positionalArguments, namedArguments);
  }
}

// ignore: prefer-static-class, ok ok ok
String revivedLiteral(
  Object object, {
  DartEmitter? dartEmitter,
}) {
  dartEmitter ??= DartEmitter();

  late final Revivable revived;
  if (object is Revivable) {
    revived = object;
  }
  if (object is DartObject) {
    revived = ConstantReader(object).revive();
  }
  if (object is ConstantReader) {
    revived = object.revive();
  }
  if (revived == null) {
    throw ArgumentError.value(
        object, 'object', 'Only `Revivable`, `DartObject`, `ConstantReader` are supported values');
  }

  String instantiation = '';
  final location = revived.source.toString().split('#');

  /// If this is a class instantiation then `location[1]` will be populated
  /// with the class name
  if (location.length > 1) {
    instantiation = location[1] + (revived.accessor.isNotEmpty ? '.${revived.accessor}' : '');
  } else {
    /// Getters, Setters, Methods can't be declared as constants so this
    /// literal must either be a top-level constant or a static constant and
    /// can be directly accessed by `revived.accessor`
    return revived.accessor;
  }

  final args = StringBuffer();
  final kwargs = StringBuffer();
  Spec objectToSpec(DartObject object) {
    final constant = ConstantReader(object);
    if (constant.isNull) {
      return literalNull;
    }

    if (constant.isBool) {
      return literal(constant.boolValue);
    }

    if (constant.isDouble) {
      return literal(constant.doubleValue);
    }

    if (constant.isInt) {
      return literal(constant.intValue);
    }

    if (constant.isString) {
      return literal(constant.stringValue);
    }

    if (constant.isList) {
      return literalList(constant.listValue.map(objectToSpec));
      // return literal(constant.listValue);
    }

    if (constant.isMap) {
      return literalMap(Map.fromIterables(
          constant.mapValue.keys.map((e) => objectToSpec(e!)), constant.mapValue.values.map((e) => objectToSpec(e!))));
      // return literal(constant.mapValue);
    }

    if (constant.isSymbol) {
      return Code('Symbol(${constant.symbolValue.toString()})');
      // return literal(constant.symbolValue);
    }

    if (constant.isNull) {
      return literalNull;
    }

    if (constant.isType) {
      return refer(constant.typeValue.getDisplayString(withNullability: true));
    }

    if (constant.isLiteral) {
      return literal(constant.literalValue);
    }

    final revived = revivedLiteral(constant.revive(), dartEmitter: dartEmitter);

    return Code(revived);
  }

  for (var arg in revived.positionalArguments) {
    final literalValue = objectToSpec(arg);

    args.write('${literalValue.accept(dartEmitter)},');
  }

  for (var arg in revived.namedArguments.keys) {
    final literalValue = objectToSpec(revived.namedArguments[arg]!);

    kwargs.write('$arg:${literalValue.accept(dartEmitter)},');
  }

  return '$instantiation($args $kwargs)';
}
