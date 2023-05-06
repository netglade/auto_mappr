/// AutoMappr interface for converting source objects into target objects.
///
/// Users should not implement or extend this.
abstract class AutoMapprInterface {
  /// {@template AutoMapprInterface:canConvert}
  /// Determines whether conversion from [SOURCE] to [TARGET] is possible.
  /// {@endtemplate}
  bool canConvert<SOURCE, TARGET>(SOURCE? model);

  /// {@template AutoMapprInterface:convert}
  /// Converts from SOURCE to TARGET if such mapping is configured.
  ///
  /// When source model is null, returns `whenSourceIsNull` if defined or throws an exception.
  /// {@endtemplate}
  TARGET convert<SOURCE, TARGET>(SOURCE? model);

  /// {@template AutoMapprInterface:tryConvert}
  /// Converts from SOURCE to TARGET if such mapping is configured.
  ///
  /// When source model is null, returns `whenSourceIsNull` if defined or null.
  /// {@endtemplate}
  TARGET? tryConvert<SOURCE, TARGET>(SOURCE? model);

  /// {@template AutoMapprInterface:convertIterable}
  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into Iterable.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or throws an exception.
  /// {@endtemplate}
  Iterable<TARGET> convertIterable<SOURCE, TARGET>(Iterable<SOURCE?> model);

  /// {@template AutoMapprInterface:tryConvertIterable}
  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into Iterable.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null.
  /// {@endtemplate}
  Iterable<TARGET?> tryConvertIterable<SOURCE, TARGET>(Iterable<SOURCE?> model);

  /// {@template AutoMapprInterface:convertList}
  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into List.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or throws an exception.
  /// {@endtemplate}
  List<TARGET> convertList<SOURCE, TARGET>(Iterable<SOURCE?> model);

  /// {@template AutoMapprInterface:tryConvertList}
  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into List.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null.
  /// {@endtemplate}
  List<TARGET?> tryConvertList<SOURCE, TARGET>(Iterable<SOURCE?> model);

  /// {@template AutoMapprInterface:convertSet}
  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into Set.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or throws an exception.
  /// {@endtemplate}
  Set<TARGET> convertSet<SOURCE, TARGET>(Iterable<SOURCE?> model);

  /// {@template AutoMapprInterface:tryConvertSet}
  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into Set.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null.
  /// {@endtemplate}
  Set<TARGET?> tryConvertSet<SOURCE, TARGET>(Iterable<SOURCE?> model);
}
