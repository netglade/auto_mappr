// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_mappr_annotation/auto_mappr_annotation.dart' as _i1;

import 'nested.dart' as _i2;

/// {@template package:examples_example/nested.dart}
/// Available mappings:
/// - `UserDto` → `User`.
/// - `NestedDto` → `Nested`.
/// - `NestedTagDto` → `NestedTag`.
/// {@endtemplate}
class $Mappr implements _i1.AutoMapprInterface {
  const $Mappr();

  Type _typeOf<T>() => T;
  List<_i1.AutoMapprInterface> get _delegates => const [];

  /// {@macro AutoMapprInterface:canConvert}
  /// {@macro package:examples_example/nested.dart}
  @override
  bool canConvert<SOURCE, TARGET>({bool recursive = true}) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<_i2.UserDto>() ||
            sourceTypeOf == _typeOf<_i2.UserDto?>()) &&
        (targetTypeOf == _typeOf<_i2.User>() ||
            targetTypeOf == _typeOf<_i2.User?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i2.NestedDto>() ||
            sourceTypeOf == _typeOf<_i2.NestedDto?>()) &&
        (targetTypeOf == _typeOf<_i2.Nested>() ||
            targetTypeOf == _typeOf<_i2.Nested?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i2.NestedTagDto>() ||
            sourceTypeOf == _typeOf<_i2.NestedTagDto?>()) &&
        (targetTypeOf == _typeOf<_i2.NestedTag>() ||
            targetTypeOf == _typeOf<_i2.NestedTag?>())) {
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
  /// {@macro package:examples_example/nested.dart}
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
  /// {@macro package:examples_example/nested.dart}
  @override
  TARGET? tryConvert<SOURCE, TARGET>(SOURCE? model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return _convert(
        model,
        canReturnNull: true,
      );
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvert(model);
      }
    }

    return null;
  }

  /// {@macro AutoMapprInterface:convertIterable}
  /// {@macro package:examples_example/nested.dart}
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
  /// {@macro package:examples_example/nested.dart}
  @override
  Iterable<TARGET?> tryConvertIterable<SOURCE, TARGET>(
      Iterable<SOURCE?> model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return model.map<TARGET?>((item) => _convert(item, canReturnNull: true));
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvertIterable(model);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// {@macro AutoMapprInterface:convertList}
  /// {@macro package:examples_example/nested.dart}
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
  /// {@macro package:examples_example/nested.dart}
  @override
  List<TARGET?> tryConvertList<SOURCE, TARGET>(Iterable<SOURCE?> model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return tryConvertIterable<SOURCE, TARGET>(model).toList();
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvertList(model);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// {@macro AutoMapprInterface:convertSet}
  /// {@macro package:examples_example/nested.dart}
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
  /// {@macro package:examples_example/nested.dart}
  @override
  Set<TARGET?> tryConvertSet<SOURCE, TARGET>(Iterable<SOURCE?> model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return tryConvertIterable<SOURCE, TARGET>(model).toSet();
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvertSet(model);
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
    if ((sourceTypeOf == _typeOf<_i2.UserDto>() ||
            sourceTypeOf == _typeOf<_i2.UserDto?>()) &&
        (targetTypeOf == _typeOf<_i2.User>() ||
            targetTypeOf == _typeOf<_i2.User?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map___i2$UserDto__To___i2$User((model as _i2.UserDto?))
          as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i2.NestedDto>() ||
            sourceTypeOf == _typeOf<_i2.NestedDto?>()) &&
        (targetTypeOf == _typeOf<_i2.Nested>() ||
            targetTypeOf == _typeOf<_i2.Nested?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map___i2$NestedDto__To___i2$Nested((model as _i2.NestedDto?))
          as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i2.NestedTagDto>() ||
            sourceTypeOf == _typeOf<_i2.NestedTagDto?>()) &&
        (targetTypeOf == _typeOf<_i2.NestedTag>() ||
            targetTypeOf == _typeOf<_i2.NestedTag?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map___i2$NestedTagDto__To___i2$NestedTag(
          (model as _i2.NestedTagDto?)) as TARGET);
    }
    throw Exception('No ${model.runtimeType} -> $targetTypeOf mapping.');
  }

  _i2.User _map___i2$UserDto__To___i2$User(_i2.UserDto? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping _i2.UserDto → _i2.User failed because UserDto was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<UserDto, User> to handle null values during mapping.');
    }
    return _i2.User(
      id: model.id,
      name: _map___i2$NestedDto__To___i2$Nested(model.name),
      nestedItems: model.nestedItems
          .map<_i2.Nested>(_map___i2$NestedDto__To___i2$Nested)
          .toList(),
      nestedItemsNullable: model.nestedItemsNullable
              ?.map<_i2.Nested>(_map___i2$NestedDto__To___i2$Nested)
              .toList() ??
          <_i2.Nested>[],
      nestedItemsNullable2: model.nestedItemsNullable2
          .map<_i2.Nested>(_map___i2$NestedDto__To___i2$Nested)
          .toList(),
      itemsWithNullableItem: model.itemsWithNullableItem
          .whereNotNull()
          .map<_i2.Nested>(_map___i2$NestedDto__To___i2$Nested)
          .toList(),
      itemsWithNullableItem2: model.itemsWithNullableItem2
          .map<_i2.Nested?>(_map___i2$NestedDto__To___i2$Nested_Nullable)
          .toList(),
      tag: null,
    );
  }

  _i2.Nested _map___i2$NestedDto__To___i2$Nested(_i2.NestedDto? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping _i2.NestedDto → _i2.Nested failed because NestedDto was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<NestedDto, Nested> to handle null values during mapping.');
    }
    return _i2.Nested(
      id: model.id,
      name: model.name,
      tag: _map___i2$NestedTagDto__To___i2$NestedTag(model.tag),
    );
  }

  _i2.NestedTag _map___i2$NestedTagDto__To___i2$NestedTag(
      _i2.NestedTagDto? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping _i2.NestedTagDto → _i2.NestedTag failed because NestedTagDto was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<NestedTagDto, NestedTag> to handle null values during mapping.');
    }
    return _i2.NestedTag();
  }

  _i2.Nested? _map___i2$NestedDto__To___i2$Nested_Nullable(
      _i2.NestedDto? input) {
    final model = input;
    if (model == null) {
      return null;
    }
    return _i2.Nested(
      id: model.id,
      name: model.name,
      tag: _map___i2$NestedTagDto__To___i2$NestedTag(model.tag),
    );
  }
}