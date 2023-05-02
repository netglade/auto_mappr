//ignore_for_file: no-object-declaration

import 'package:analyzer/dart/constant/value.dart';
import 'package:auto_mappr/src/extensions/executable_element_extension.dart';
import 'package:auto_mappr/src/models/type_conversion.dart';
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

  TypeConversion? toTypeConversion() {
    final function = toFunctionValue() ?? getField('convert')?.toFunctionValue();

    if (function == null) {
      return null;
    }

    if(function.parameters.length != 1) {
      throw InvalidGenerationSourceError(
        'TypeConverter function must have exactly one parameter.',
        element: function,
      );
    }

    final source = function.parameters.first.type;
    final target = function.returnType;

    return TypeConversion(
      source: source,
      target: target,
      convertExpression: refer(function.referCallString),
      field: getField('field')?.toStringValue(),
    );
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

    if (constant.isString) {
      return literalString(constant.stringValue, raw: true);
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

    // int, double, num, null
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
    final instantiation = location[1];
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
