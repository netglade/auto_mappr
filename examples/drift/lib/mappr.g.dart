// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mappr.dart';

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: require_trailing_commas, unnecessary_const
// ignore_for_file: unnecessary_lambdas, unnecessary_parenthesis
// ignore_for_file: unnecessary_raw_strings

/// {@template package:auto_mappr_drift_example/mappr.dart}
/// Available mappings:
/// - `Todo` → `TodoItem`.
/// {@endtemplate}
class $Mappr implements AutoMapprInterface {
  const $Mappr();

  Type _typeOf<T>() => T;
  List<AutoMapprInterface> get _modules => const [];

  /// {@macro AutoMapprInterface:canConvert}
  /// {@macro package:auto_mappr_drift_example/mappr.dart}
  @override
  bool canConvert<SOURCE, TARGET>(
    SOURCE? model, {
    bool recursive = true,
  }) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<Todo>() || sourceTypeOf == _typeOf<Todo?>()) &&
        (targetTypeOf == _typeOf<TodoItem>() ||
            targetTypeOf == _typeOf<TodoItem?>())) {
      return true;
    }
    if (recursive) {
      for (final mappr in _modules) {
        if (mappr.canConvert<SOURCE, TARGET>(model)) {
          return true;
        }
      }
    }
    return false;
  }

  /// {@macro AutoMapprInterface:convert}
  /// {@macro package:auto_mappr_drift_example/mappr.dart}
  @override
  TARGET convert<SOURCE, TARGET>(SOURCE? model) {
    if (canConvert<SOURCE, TARGET>(
      model,
      recursive: false,
    )) {
      return _convert(model)!;
    }
    for (final mappr in _modules) {
      if (mappr.canConvert<SOURCE, TARGET>(model)) {
        return mappr.convert(model)!;
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// {@macro AutoMapprInterface:tryConvert}
  /// {@macro package:auto_mappr_drift_example/mappr.dart}
  @override
  TARGET? tryConvert<SOURCE, TARGET>(SOURCE? model) => _convert(
        model,
        canReturnNull: true,
      );

  /// {@macro AutoMapprInterface:convertIterable}
  /// {@macro package:auto_mappr_drift_example/mappr.dart}
  @override
  Iterable<TARGET> convertIterable<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      model.map<TARGET>((item) => _convert(item)!);

  /// {@macro AutoMapprInterface:tryConvertIterable}
  /// {@macro package:auto_mappr_drift_example/mappr.dart}
  @override
  Iterable<TARGET?> tryConvertIterable<SOURCE, TARGET>(
          Iterable<SOURCE?> model) =>
      model.map<TARGET?>((item) => _convert(item, canReturnNull: true));

  /// {@macro AutoMapprInterface:convertList}
  /// {@macro package:auto_mappr_drift_example/mappr.dart}
  @override
  List<TARGET> convertList<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      convertIterable<SOURCE, TARGET>(model).toList();

  /// {@macro AutoMapprInterface:tryConvertList}
  /// {@macro package:auto_mappr_drift_example/mappr.dart}
  @override
  List<TARGET?> tryConvertList<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      tryConvertIterable<SOURCE, TARGET>(model).toList();

  /// {@macro AutoMapprInterface:convertSet}
  /// {@macro package:auto_mappr_drift_example/mappr.dart}
  @override
  Set<TARGET> convertSet<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      convertIterable<SOURCE, TARGET>(model).toSet();

  /// {@macro AutoMapprInterface:tryConvertSet}
  /// {@macro package:auto_mappr_drift_example/mappr.dart}
  @override
  Set<TARGET?> tryConvertSet<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      tryConvertIterable<SOURCE, TARGET>(model).toSet();
  TARGET? _convert<SOURCE, TARGET>(
    SOURCE? model, {
    bool canReturnNull = false,
  }) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<Todo>() || sourceTypeOf == _typeOf<Todo?>()) &&
        (targetTypeOf == _typeOf<TodoItem>() ||
            targetTypeOf == _typeOf<TodoItem?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map_Todo_To_TodoItem((model as Todo?)) as TARGET);
    }
    throw Exception('No ${model.runtimeType} -> $targetTypeOf mapping.');
  }

  TodoItem _map_Todo_To_TodoItem(Todo? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          'Mapping Todo → TodoItem failed because Todo was null, and no default value was provided. '
          'Consider setting the whenSourceIsNull parameter on the MapType<Todo, TodoItem> to handle null values during mapping.');
    }
    return TodoItem(
      id: model.id,
      title: model.title,
    );
  }
}
