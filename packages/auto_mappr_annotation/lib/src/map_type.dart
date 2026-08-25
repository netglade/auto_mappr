import 'package:auto_mappr_annotation/src/field.dart';
import 'package:auto_mappr_annotation/src/type_converter.dart';

/// Configured mapping from [SOURCE] to [TARGET].
// ignore: avoid-unused-generics, generic are used later in code
final class MapType<SOURCE, TARGET> {
  /// Configuration for [TARGET]'s fields.
  final List<Field> fields;

  /// List of type converters.
  final List<TypeConverter<Object?, Object?>> converters;

  /// Provides default value if SOURCE is null.
  ///
  /// Additionally if mapping an enum "unknown" values in SOURCE will be mapped
  /// to this value.
  ///
  /// Accepts `Target Function()` function or `const Target` value.
  // ignore: no-object-declaration, is correct
  final Object? whenSourceIsNull;

  /// Selects named (factory) constructor by name.
  ///
  /// If no constructor with this name is found,
  /// it will fallback to the most fitted constructor.
  ///
  /// To select the default constructor use the `null` value.
  final String? constructor;

  /// Ignores if [SOURCE]'s field is nullable and [TARGET]'s field non-nullable.
  final bool? ignoreFieldNull;

  /// Includes reverse mapping.
  ///
  /// Warning: reverse warning might be suitable only for specific objects.
  /// Reverse mapping might not work properly when additional configuration
  /// such as [whenSourceIsNull] or [constructor] is used.
  final bool reverse;

  /// If set to true and any exception is thrown during the mapping using tryConvert/tryConvertIterable/tryConvertSet/tryConverlList methods, it is caught and methods return null.
  /// The default is false.
  final bool safeMapping;

  /// Wraps mapped values of [TARGET]'s fields into a box type.
  ///
  /// Must be a generic function with a single type parameter, a single positional
  /// parameter of that type and a return type of a generic class with a single
  /// type argument, such as:
  ///
  /// ```dart
  /// Value<T> box<T>(T value) => Value(value);
  /// ```
  ///
  /// Applies to every [TARGET] field whose type is the box type, unless the field
  /// opts out with `Field(..., boxing: false)` or defines a custom mapping.
  ///
  /// See also [unboxing], which is required for the opposite direction.
  // ignore: prefer-typedefs-for-callbacks, prefer-correct-callback-field-name, prefer-explicit-function-type, a generic box type cannot be expressed as a typedef
  final Function? boxing;

  /// Unwraps values of [SOURCE]'s boxed fields.
  ///
  /// Must be a generic function with a single type parameter, a single positional
  /// parameter of a generic class with a single type argument and a return type of
  /// that type parameter, such as:
  ///
  /// ```dart
  /// T unbox<T>(Value<T> value) => value.value;
  /// ```
  ///
  /// Applies to every [SOURCE] field whose type is the box type, unless the field
  /// opts out with `Field(..., boxing: false)` or defines a custom mapping.
  ///
  /// Set this together with [boxing] when using [reverse], as the reverse mapping
  /// maps the boxed type back into the unboxed one.
  // ignore: prefer-typedefs-for-callbacks, prefer-correct-callback-field-name, prefer-explicit-function-type, a generic box type cannot be expressed as a typedef
  final Function? unboxing;

  /// Constructs mapping between [SOURCE] and [TARGET] types.
  const MapType({
    this.fields = const [],
    this.converters = const [],
    this.whenSourceIsNull,
    this.constructor,
    this.ignoreFieldNull,
    this.reverse = false,
    this.safeMapping = false,
    this.boxing,
    this.unboxing,
  });
}
