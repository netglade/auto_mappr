import 'package:auto_mappr_annotation/src/field.dart';
import 'package:auto_mappr_annotation/src/type_converter.dart';

/// Configured mapping from [SOURCE] to [TARGET].
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

  /// Constructs mapping between [SOURCE] and [TARGET] types.
  const MapType({
    this.fields = const [],
    this.converters = const [],
    this.whenSourceIsNull,
    this.constructor,
    this.ignoreFieldNull,
    this.reverse = false,
  });
}
