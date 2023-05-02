/// Configure Type Mapping.
class TypeConverter {
  /// Function that converts from SOURCE to TARGET.
  ///
  /// Acceps `TARGET Function(SOURCE)` function.
  // ignore: no-object-declaration, correct usage
  final Object? convert;

  /// Name of the field to which this converter is constrained.
  final String? field;

  /// Construct a [TypeConverter] instance.
  const TypeConverter(this.convert, {this.field});
}
