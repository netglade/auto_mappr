// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

// ignore_for_file: type=lint, unnecessary_cast, unused_local_variable

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_mappr_annotation/auto_mappr_annotation.dart' as _i1;
import 'package:examples_drift/db.dart' as _i2;
import 'package:examples_drift/mappr.dart' as _i3;

/// {@template package:examples_drift/mappr.dart}
/// Available mappings:
/// - `Todo` → `TodoItem`.
/// - `TodoItem` → `TodosCompanion`.
/// - `TodosCompanion` → `TodoItem`.
/// {@endtemplate}
class $Mappr implements _i1.AutoMapprInterface {
  const $Mappr();

  Type _typeOf<T>() => T;

  List<_i1.AutoMapprInterface> get _delegates => const [];

  /// {@macro AutoMapprInterface:canConvert}
  /// {@macro package:examples_drift/mappr.dart}
  @override
  bool canConvert<SOURCE, TARGET>({bool recursive = true}) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<_i2.Todo>() ||
            sourceTypeOf == _typeOf<_i2.Todo?>()) &&
        (targetTypeOf == _typeOf<_i3.TodoItem>() ||
            targetTypeOf == _typeOf<_i3.TodoItem?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i3.TodoItem>() ||
            sourceTypeOf == _typeOf<_i3.TodoItem?>()) &&
        (targetTypeOf == _typeOf<_i2.TodosCompanion>() ||
            targetTypeOf == _typeOf<_i2.TodosCompanion?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i2.TodosCompanion>() ||
            sourceTypeOf == _typeOf<_i2.TodosCompanion?>()) &&
        (targetTypeOf == _typeOf<_i3.TodoItem>() ||
            targetTypeOf == _typeOf<_i3.TodoItem?>())) {
      return true;
    }
    if (recursive) {
      for (final mappr in _delegates) {
        if (mappr.canConvert<SOURCE, TARGET>()) {
          return true;
        }
      }
    }
    return false;
  }

  /// {@macro AutoMapprInterface:convert}
  /// {@macro package:examples_drift/mappr.dart}
  @override
  TARGET convert<SOURCE, TARGET>(SOURCE? model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return _convert(model)!;
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.convert(model)!;
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// {@macro AutoMapprInterface:tryConvert}
  /// {@macro package:examples_drift/mappr.dart}
  @override
  TARGET? tryConvert<SOURCE, TARGET>(
    SOURCE? model, {
    void Function(Object error, StackTrace stackTrace, SOURCE? source)?
    onMappingError,
  }) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return _safeConvert(model, onMappingError: onMappingError);
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvert(model, onMappingError: onMappingError);
      }
    }

    return null;
  }

  /// {@macro AutoMapprInterface:convertIterable}
  /// {@macro package:examples_drift/mappr.dart}
  @override
  Iterable<TARGET> convertIterable<SOURCE, TARGET>(Iterable<SOURCE?> model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return model.map<TARGET>((item) => _convert(item)!);
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.convertIterable(model);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into Iterable.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null
  ///
  /// {@macro package:examples_drift/mappr.dart}
  @override
  Iterable<TARGET?> tryConvertIterable<SOURCE, TARGET>(
    Iterable<SOURCE?> model, {
    void Function(Object error, StackTrace stackTrace, SOURCE? source)?
    onMappingError,
  }) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return model.map<TARGET?>(
        (item) => _safeConvert(item, onMappingError: onMappingError),
      );
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvertIterable(model, onMappingError: onMappingError);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// {@macro AutoMapprInterface:convertList}
  /// {@macro package:examples_drift/mappr.dart}
  @override
  List<TARGET> convertList<SOURCE, TARGET>(Iterable<SOURCE?> model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return convertIterable<SOURCE, TARGET>(model).toList();
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.convertList(model);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into List.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null
  ///
  /// {@macro package:examples_drift/mappr.dart}
  @override
  List<TARGET?> tryConvertList<SOURCE, TARGET>(
    Iterable<SOURCE?> model, {
    void Function(Object error, StackTrace stackTrace, SOURCE? source)?
    onMappingError,
  }) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return tryConvertIterable<SOURCE, TARGET>(
        model,
        onMappingError: onMappingError,
      ).toList();
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvertList(model, onMappingError: onMappingError);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// {@macro AutoMapprInterface:convertSet}
  /// {@macro package:examples_drift/mappr.dart}
  @override
  Set<TARGET> convertSet<SOURCE, TARGET>(Iterable<SOURCE?> model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return convertIterable<SOURCE, TARGET>(model).toSet();
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.convertSet(model);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into Set.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null
  ///
  /// {@macro package:examples_drift/mappr.dart}
  @override
  Set<TARGET?> tryConvertSet<SOURCE, TARGET>(
    Iterable<SOURCE?> model, {
    void Function(Object error, StackTrace stackTrace, SOURCE? source)?
    onMappingError,
  }) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return tryConvertIterable<SOURCE, TARGET>(
        model,
        onMappingError: onMappingError,
      ).toSet();
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvertSet(model, onMappingError: onMappingError);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  TARGET? _convert<SOURCE, TARGET>(
    SOURCE? model, {
    bool canReturnNull = false,
  }) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<_i2.Todo>() ||
            sourceTypeOf == _typeOf<_i2.Todo?>()) &&
        (targetTypeOf == _typeOf<_i3.TodoItem>() ||
            targetTypeOf == _typeOf<_i3.TodoItem?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i2$Todo_To__i3$TodoItem((model as _i2.Todo?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i3.TodoItem>() ||
            sourceTypeOf == _typeOf<_i3.TodoItem?>()) &&
        (targetTypeOf == _typeOf<_i2.TodosCompanion>() ||
            targetTypeOf == _typeOf<_i2.TodosCompanion?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i3$TodoItem_To__i2$TodosCompanion((model as _i3.TodoItem?))
          as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i2.TodosCompanion>() ||
            sourceTypeOf == _typeOf<_i2.TodosCompanion?>()) &&
        (targetTypeOf == _typeOf<_i3.TodoItem>() ||
            targetTypeOf == _typeOf<_i3.TodoItem?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i2$TodosCompanion_To__i3$TodoItem(
            (model as _i2.TodosCompanion?),
          )
          as TARGET);
    }
    throw Exception('No ${model.runtimeType} -> $targetTypeOf mapping.');
  }

  TARGET? _safeConvert<SOURCE, TARGET>(
    SOURCE? model, {
    void Function(Object error, StackTrace stackTrace, SOURCE? source)?
    onMappingError,
  }) {
    if (!useSafeMapping<SOURCE, TARGET>()) {
      return _convert(model, canReturnNull: true);
    }
    try {
      return _convert(model, canReturnNull: true);
    } catch (e, s) {
      onMappingError?.call(e, s, model);
      return null;
    }
  }

  /// {@macro AutoMapprInterface:useSafeMapping}
  /// {@macro package:examples_drift/mappr.dart}
  @override
  bool useSafeMapping<SOURCE, TARGET>() {
    return false;
  }

  _i3.TodoItem _map__i2$Todo_To__i3$TodoItem(_i2.Todo? input) {
    final model = input;
    if (model == null) {
      throw Exception(
        r'Mapping Todo → TodoItem failed because Todo was null, and no default value was provided. '
        r'Consider setting the whenSourceIsNull parameter on the MapType<Todo, TodoItem> to handle null values during mapping.',
      );
    }
    return _i3.TodoItem(
      id: model.id,
      title: model.title,
      content: model.content,
      category: model.category,
    );
  }

  _i2.TodosCompanion _map__i3$TodoItem_To__i2$TodosCompanion(
    _i3.TodoItem? input,
  ) {
    final model = input;
    if (model == null) {
      throw Exception(
        r'Mapping TodoItem → TodosCompanion failed because TodoItem was null, and no default value was provided. '
        r'Consider setting the whenSourceIsNull parameter on the MapType<TodoItem, TodosCompanion> to handle null values during mapping.',
      );
    }
    return _i2.TodosCompanion(
      id: _i3.box(model.id),
      title: _i3.box(model.title),
      content: _i3.box(model.content),
      category: _i3.box(model.category),
    );
  }

  _i3.TodoItem _map__i2$TodosCompanion_To__i3$TodoItem(
    _i2.TodosCompanion? input,
  ) {
    final model = input;
    if (model == null) {
      throw Exception(
        r'Mapping TodosCompanion → TodoItem failed because TodosCompanion was null, and no default value was provided. '
        r'Consider setting the whenSourceIsNull parameter on the MapType<TodosCompanion, TodoItem> to handle null values during mapping.',
      );
    }
    return _i3.TodoItem(
      id: _i3.unbox(model.id),
      title: _i3.unbox(model.title),
      content: _i3.unbox(model.content),
      category: _i3.unbox(model.category),
    );
  }
}
