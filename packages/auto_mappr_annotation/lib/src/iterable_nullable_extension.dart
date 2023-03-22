/// Heavily inspired from `package:collection` so we can limit package dependencies.
extension IterableNullableExtension<T extends Object> on Iterable<T?> {
  /// Filtering out null values of iterable.
  Iterable<T> whereNotNull() sync* {
    for (final element in this) {
      if (element != null) yield element;
    }
  }
}
