/// {@template type_converter}
/// Configure Type Mapping from [SOURCE] to [TARGET].
/// {@endtemplate}
class TypeConverter<SOURCE, TARGET> {
  /// Mapping function to convert [SOURCE] to [TARGET].
  final TARGET Function(SOURCE source) convert;

  /// {@macro type_converter}
  const TypeConverter(this.convert);
}
