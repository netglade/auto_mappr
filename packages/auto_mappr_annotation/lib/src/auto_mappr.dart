// ignore_for_file: avoid-dynamic

/// Annotates class which will be used as base for generated mapper.
class AutoMappr {
  /// List of mappers.
  final List<MapType<Object?, Object?>> mappers;

  /// Constructs AutoMap.
  const AutoMappr(this.mappers);
}

/// Configured mapping from [SOURCE] to [TARGET].
class MapType<SOURCE, TARGET> {
  /// Configuration for [TARGET]'s fields.
  final List<Field> fields;

  /// Provides default value if SOURCE is null.
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
    this.whenSourceIsNull,
    this.constructor,
  });
}

/// Mapping configuration of target object's field.
class Field {
  /// Which field is mapped.
  ///
  /// It should be either name of TARGET's field OR name of TARGET's constructor.
  final String field;

  /// Custom mapping of target [field].
  ///
  /// Accepts `Target Function(Source dto)` function or `const Target` value.
  // ignore: no-object-declaration, is correct
  final Object? custom;

  /// Default value to be used when source field is null.
  ///
  /// Accepts `Target Function()` function or `const Target` value.
  // ignore: no-object-declaration, correct usage
  final Object? whenNull;

  /// Marks target [field] as ignored.
  final bool ignore;

  /// Target [field] should be mapped from source [from].
  ///
  /// Note that [custom] has priority.
  final String? from;

  /// Field renaming using [from] or assigning default value with [whenNull].
  const Field(
    this.field, {
    this.from,
    this.whenNull,
  })  : custom = null,
        ignore = false;

  /// Field custom mapping.
  const Field.custom(
    this.field, {
    required this.custom,
    this.whenNull,
  })  : from = null,
        ignore = false;

  /// Field ignoring.
  const Field.ignore(
    this.field,
  )   : ignore = true,
        from = null,
        custom = null,
        whenNull = null;
}
