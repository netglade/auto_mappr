/// Configured type converter from [SOURCE] to [TARGET].
final class TypeConverter<SOURCE, TARGET> {
  /// A function that does type converter.
  final TARGET Function(SOURCE source) converter;

  /// Constructs type converter between [SOURCE] and [TARGET].
  const TypeConverter(this.converter);
}
