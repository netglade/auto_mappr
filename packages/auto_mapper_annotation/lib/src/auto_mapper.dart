// ignore_for_file: avoid-dynamic

/// Annotates class which will be used as base for generated mapper.
class AutoMapper {
  ///
  final List<MapType<Object?, Object?>> mappers;

  /// Constructs AutoMapper.
  const AutoMapper(this.mappers);
}

/// Configured mapping from SOURCE to TARGET.
class MapType<SOURCE, TARGET> {
  /// Configuration for TARGET's fields.
  final List<Field<SOURCE>> fields;

  /// Provides default value if SOURCE is null.
  ///
  /// Accepts `Target Function()` or `const Target`.
  // ignore: no-object-declaration, is correct
  final Object? whenSourceIsNull;

  /// Selects constructor or factory constructor by name.
  ///
  /// If no constructor with this name is found,
  /// it will fallback to the most fitted constructor.
  final String? constructor;

  /// Constructs mapping.
  const MapType({
    this.fields = const [],
    this.whenSourceIsNull,
    this.constructor,
  });
}

/// Mapping configuration for concrete field of target class.
class Field<SOURCE> {
  /// Which field is mapped.
  ///
  /// It should be either name of TARGET's field OR name of TARGET's constructor.
  final String field;

  /// Custom function mapping for given [field].
  ///
  /// Accepts `Target Function(Source dto)` or `const Target`.
  // ignore: no-object-declaration, is correct
  final Object? custom;

  /// Provides default value if SOURCE is null.
  ///
  /// Accepts `Target Function()` or `const Target`.
  // ignore: no-object-declaration, is correct
  final Object? whenNull;

  /// Given [field] should be ignored.
  ///
  /// Note that if [field] is required (or non-nullable) it is considered as error.
  final bool ignore;

  /// Given [field] should be mapped from [from].
  ///
  /// Note that [custom] has priority.
  final String? from;

  /// Constructs field mapping.
  const Field(
    this.field, {
    this.custom,
    this.from,
    this.ignore = false,
    this.whenNull,
  });
}
