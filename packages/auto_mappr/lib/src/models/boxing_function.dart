import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/extensions/executable_element_extension.dart';
import 'package:auto_mappr/src/helpers/emitter_helper.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:source_gen/source_gen.dart';

/// A user provided function converting between an unboxed type `T`
/// and a box type `BOX<T>`, such as drift's `Value`.
///
/// Both directions carry the same information, so the same class describes
/// the boxing function `BOX<T> box<T>(T value)`
/// and the unboxing function `T unbox<T>(BOX<T> value)`.
class BoxingFunction with Equatable {
  /// The function to call.
  final ExecutableElement function;

  /// The box class, such as `Value`.
  final InterfaceElement boxElement;

  @override
  List<Object?> get props => [function, boxElement];

  const BoxingFunction({required this.function, required this.boxElement});

  /// Validates and creates the boxing function `BOX<T> box<T>(T value)`.
  factory BoxingFunction.boxing(ExecutableElement function) {
    final typeParameter = _singleTypeParameter(function, keyword: 'boxing');
    final parameterType = _singleParameterType(function, keyword: 'boxing');

    if (!_isTypeParameter(parameterType, typeParameter)) {
      throw _error(
        function,
        keyword: 'boxing',
        problem: "its parameter's type is not its type parameter '${typeParameter.displayName}'",
      );
    }

    return BoxingFunction(
      function: function,
      boxElement: _boxElement(function.returnType, function, keyword: 'boxing', typeParameter: typeParameter),
    );
  }

  /// Validates and creates the unboxing function `T unbox<T>(BOX<T> value)`.
  factory BoxingFunction.unboxing(ExecutableElement function) {
    final typeParameter = _singleTypeParameter(function, keyword: 'unboxing');
    final parameterType = _singleParameterType(function, keyword: 'unboxing');

    if (!_isTypeParameter(function.returnType, typeParameter)) {
      throw _error(
        function,
        keyword: 'unboxing',
        problem: "its return type is not its type parameter '${typeParameter.displayName}'",
      );
    }

    return BoxingFunction(
      function: function,
      boxElement: _boxElement(parameterType, function, keyword: 'unboxing', typeParameter: typeParameter),
    );
  }

  /// Whether [type] is the box type, such as `Value<int>` for the box class `Value`.
  bool isBoxed(DartType? type) => type is InterfaceType && type.element == boxElement;

  /// The unboxed type of [type], such as `int` for `Value<int>`.
  ///
  /// Returns null when [type] is not the box type.
  DartType? unboxedTypeOf(DartType? type) =>
      type is InterfaceType && type.element == boxElement ? type.typeArguments.singleOrNull : null;

  /// Calls the function with [value] as its argument.
  Expression apply(Expression value) => EmitterHelper.current
      .refer(function.referCallString, function.library.uri.toString())
      .call([value]);

  @override
  String toString() => function.displayName;

  static TypeParameterElement _singleTypeParameter(ExecutableElement function, {required String keyword}) {
    // A constructor has no type parameters of its own, they belong to its class,
    // which lets a tearoff such as `Value.new` be used as a boxing function.
    final typeParameters = function is ConstructorElement
        ? function.enclosingElement.typeParameters
        : function.typeParameters;

    final typeParameter = typeParameters.singleOrNull;

    if (typeParameter == null) {
      throw _error(
        function,
        keyword: keyword,
        problem: 'it does not have exactly one type parameter',
      );
    }

    return typeParameter;
  }

  static DartType _singleParameterType(ExecutableElement function, {required String keyword}) {
    final parameter = function.formalParameters.singleOrNull;

    if (parameter == null || !parameter.isRequiredPositional) {
      throw _error(
        function,
        keyword: keyword,
        problem: 'it does not have exactly one required positional parameter',
      );
    }

    return parameter.type;
  }

  /// Resolves the box class from [boxType], which must be `BOX<T>`
  /// for the function's [typeParameter].
  static InterfaceElement _boxElement(
    DartType boxType,
    ExecutableElement function, {
    required String keyword,
    required TypeParameterElement typeParameter,
  }) {
    if (boxType is! InterfaceType || boxType.nullabilitySuffix != NullabilitySuffix.none) {
      throw _error(
        function,
        keyword: keyword,
        problem: 'the box type is not a non-nullable class',
      );
    }

    final typeArgument = boxType.typeArguments.singleOrNull;

    if (typeArgument == null) {
      throw _error(
        function,
        keyword: keyword,
        problem:
            "the box type '${boxType.element.displayName}' does not have exactly one type argument",
      );
    }

    if (!_isTypeParameter(typeArgument, typeParameter)) {
      throw _error(
        function,
        keyword: keyword,
        problem:
            "the box type is not parameterized by its type parameter '${typeParameter.displayName}'",
      );
    }

    return boxType.element;
  }

  /// Whether [type] is exactly the non-nullable [typeParameter].
  ///
  /// Nullable forms such as `T?` are rejected, because the unboxed type is taken
  /// from the box's type argument and there is no way to add nullability to it.
  /// Use a nullable type argument such as `Value<int?>` on the mapped field instead.
  static bool _isTypeParameter(DartType type, TypeParameterElement typeParameter) =>
      type is TypeParameterType &&
      type.element == typeParameter &&
      type.nullabilitySuffix == NullabilitySuffix.none;

  static InvalidGenerationSourceError _error(
    ExecutableElement function, {
    required String keyword,
    required String problem,
  }) {
    final name = function.displayName;
    final isBoxing = keyword == 'boxing';
    final expected = isBoxing ? 'BOX<T> $name<T>(T value)' : 'T $name<T>(BOX<T> value)';
    final hint = isBoxing ? ' Alternatively use a tearoff of the box constructor, such as `Value.new`.' : '';

    return InvalidGenerationSourceError(
      "Function '$name' cannot be used as '$keyword' because $problem.",
      element: function,
      todo: 'Declare it as `$expected`.$hint',
    );
  }
}
