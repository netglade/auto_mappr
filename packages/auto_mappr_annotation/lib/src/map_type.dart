import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

/// Configured mapping from [SOURCE] to [TARGET].
class MapType<SOURCE, TARGET> {
  /// Configuration for [TARGET]'s fields.
  final List<Field> fields;

  /// Configuration for mapping types between [SOURCE] and [TARGET].
  final List<TypeConverter<Object?, Object?>> types;

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

  /// Constructs mapping between [SOURCE] and [TARGET] types.
  const MapType({
    this.fields = const [],
    this.types = const [],
    this.whenSourceIsNull,
    this.constructor,
  });
}
