import 'package:auto_mappr_annotation/src/type_converter.dart';
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

  /// Configure type mapping.
  ///
  /// Accepts `Target Function(Source)` function or a [TypeConverter] instance.
  // ignore: no-object-declaration, correct usage
  final Object? type;

  /// Universal constructor.
  const Field(
    this.field, {
    this.from,
    this.custom,
    this.ignore = false,
    this.whenNull,
    this.type,
  });

  /// Field renaming using [from] or assigning default value with [whenNull].
  const Field.from(
    this.field, {
    required this.from,
    this.whenNull,
    this.type,
  })  : custom = null,
        ignore = false;

  /// Field custom mapping.
  const Field.custom(
    this.field, {
    required this.custom,
    this.whenNull,
  })  : from = null,
        ignore = false,
        type = null;

  /// Field ignoring.
  const Field.ignore(
    this.field,
  )   : ignore = true,
        from = null,
        custom = null,
        whenNull = null,
        type = null;
}
