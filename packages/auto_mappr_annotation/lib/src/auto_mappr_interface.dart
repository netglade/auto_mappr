/// AutoMappr interface for converting source objects into target objects.
///
/// Users should not implement or extend this.
abstract interface class AutoMapprInterface {
  ///
  const AutoMapprInterface();

  /// {@template AutoMapprInterface:canConvert}
  /// Determines whether conversion from [SOURCE] to [TARGET] is possible.
  /// {@endtemplate}
  bool canConvert<SOURCE, TARGET>({bool recursive});

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
  ///
  /// If safeMapping is set to true and any exception is thrown during the mapping, the onMappingError callback is invoked.
  /// {@endtemplate}
  TARGET? tryConvert<SOURCE, TARGET>(SOURCE? model, {OnMappingError<SOURCE>? onMappingError});

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
  ///
  /// If safeMapping is set to true and any exception is thrown during the mapping, the onMappingError callback is invoked.
  /// {@endtemplate}
  Iterable<TARGET?> tryConvertIterable<SOURCE, TARGET>(
    Iterable<SOURCE?> model, {
    OnMappingError<SOURCE>? onMappingError,
  });

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
  ///
  /// If safeMapping is set to true and any exception is thrown during the mapping, the onMappingError callback is invoked.
  /// {@endtemplate}
  List<TARGET?> tryConvertList<SOURCE, TARGET>(Iterable<SOURCE?> model, {OnMappingError<SOURCE>? onMappingError});

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
  ///
  /// If safeMapping is set to true and any exception is thrown during the mapping, the onMappingError callback is invoked.
  /// {@endtemplate}
  Set<TARGET?> tryConvertSet<SOURCE, TARGET>(Iterable<SOURCE?> model, {OnMappingError<SOURCE>? onMappingError});

  /// {@template AutoMapprInterface:useSafeMapping}
  /// Determines if safe mapping is used between the SOURCE and TARGET.
  /// {@endtemplate}
  bool useSafeMapping<SOURCE, TARGET>();
}

/// Callback invoked when error in mapping.
typedef OnMappingError<SOURCE> = void Function(Object e, StackTrace stackTrace, SOURCE? source);
