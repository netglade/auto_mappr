/// Mapping configuration of target object's field.
final class Field {
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

  /// Force non-nullable value if SOURCE's field is nullable and TARGET's field not.
  final bool? ignoreNull;

  /// Whether `MapType.boxing` and `MapType.unboxing` apply to this field.
  ///
  /// Set to `false` to map this field without boxing or unboxing it, even though
  /// its type is the box type. Null inherits the behaviour from the map type.
  // ignore: prefer-boolean-prefixes, named after MapType.boxing it overrides
  final bool? boxing;

  /// Universal constructor.
  const Field(
    this.field, {
    this.from,
    this.custom,
    this.ignore = false,
    this.whenNull,
    this.ignoreNull,
    this.boxing,
  });

  /// Field renaming using [from] or assigning default value with [whenNull].
  const Field.from(this.field, {required this.from, this.whenNull, this.boxing})
      : custom = null,
        ignore = false,
        ignoreNull = null;

  /// Field custom mapping.
  const Field.custom(this.field, {required this.custom, this.whenNull})
      : from = null,
        ignore = false,
        ignoreNull = null,
        boxing = null;

  /// Field ignoring.
  const Field.ignore(this.field)
      : ignore = true,
        from = null,
        custom = null,
        whenNull = null,
        ignoreNull = null,
        boxing = null;
}
