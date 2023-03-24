/// Map extension that provides additional methods we use in AutoMap.
extension MapExtension<KEY, VALUE> on Map<KEY, VALUE> {
  /// Immutable where on maps.
  Map<KEY2, VALUE2> where<KEY2, VALUE2>(bool Function(KEY key, VALUE value) test) {
    final result = <KEY2, VALUE2>{};

    for (final entry in entries) {
      if (test(entry.key, entry.value)) {
        result[entry.key as KEY2] = entry.value as VALUE2;
      }
    }

    return result;
  }
}
