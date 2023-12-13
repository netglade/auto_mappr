/// Configured type converter from [SOURCE] to [TARGET].
final class TypeConverter<SOURCE, TARGET> {
  /// A function that does type converter.
  // ignore: prefer-typedefs-for-callbacks, prefer-correct-callback-field-name, it's simpler this way
  final TARGET Function(SOURCE source) converter;

  /// Constructs type converter between [SOURCE] and [TARGET].
  const TypeConverter(this.converter);
}
