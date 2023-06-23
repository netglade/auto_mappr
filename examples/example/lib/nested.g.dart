// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nested.dart';

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: require_trailing_commas, unnecessary_const
// ignore_for_file: unnecessary_lambdas, unnecessary_parenthesis
// ignore_for_file: unnecessary_raw_strings

/// {@template package:examples_example/nested.dart}
/// Available mappings:
/// - `UserDto` → `User`.
/// - `NestedDto` → `Nested`.
/// - `NestedTagDto` → `NestedTag`.
/// {@endtemplate}
class $Mappr implements AutoMapprInterface {
  const $Mappr();

  Type _typeOf<T>() => T;
  List<AutoMapprInterface> get _modules => const [];

  /// {@macro AutoMapprInterface:canConvert}
  /// {@macro package:examples_example/nested.dart}
  @override
  bool canConvert<SOURCE, TARGET>({bool recursive = true}) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<UserDto>() ||
            sourceTypeOf == _typeOf<UserDto?>()) &&
        (targetTypeOf == _typeOf<User>() || targetTypeOf == _typeOf<User?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<NestedDto>() ||
            sourceTypeOf == _typeOf<NestedDto?>()) &&
        (targetTypeOf == _typeOf<Nested>() ||
            targetTypeOf == _typeOf<Nested?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<NestedTagDto>() ||
            sourceTypeOf == _typeOf<NestedTagDto?>()) &&
        (targetTypeOf == _typeOf<NestedTag>() ||
            targetTypeOf == _typeOf<NestedTag?>())) {
      return true;
    }
    if (recursive) {
      for (final mappr in _modules) {
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
    for (final mappr in _modules) {
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
    for (final mappr in _modules) {
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
    for (final mappr in _modules) {
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
    for (final mappr in _modules) {
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
    for (final mappr in _modules) {
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
    for (final mappr in _modules) {
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
    for (final mappr in _modules) {
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
    for (final mappr in _modules) {
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
    if ((sourceTypeOf == _typeOf<UserDto>() ||
            sourceTypeOf == _typeOf<UserDto?>()) &&
        (targetTypeOf == _typeOf<User>() || targetTypeOf == _typeOf<User?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__UserDto__To__User((model as UserDto?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<NestedDto>() ||
            sourceTypeOf == _typeOf<NestedDto?>()) &&
        (targetTypeOf == _typeOf<Nested>() ||
            targetTypeOf == _typeOf<Nested?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__NestedDto__To__Nested((model as NestedDto?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<NestedTagDto>() ||
            sourceTypeOf == _typeOf<NestedTagDto?>()) &&
        (targetTypeOf == _typeOf<NestedTag>() ||
            targetTypeOf == _typeOf<NestedTag?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__NestedTagDto__To__NestedTag((model as NestedTagDto?))
          as TARGET);
    }
    throw Exception('No ${model.runtimeType} -> $targetTypeOf mapping.');
  }

  User _map__UserDto__To__User(UserDto? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping UserDto → User failed because UserDto was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<UserDto, User> to handle null values during mapping.');
    }
    return User(
      id: model.id,
      name: _map__NestedDto__To__Nested(model.name),
      nestedItems:
          model.nestedItems.map<Nested>(_map__NestedDto__To__Nested).toList(),
      nestedItemsNullable: model.nestedItemsNullable
              ?.map<Nested>(_map__NestedDto__To__Nested)
              .toList() ??
          <Nested>[],
      nestedItemsNullable2: model.nestedItemsNullable2
          .map<Nested>(_map__NestedDto__To__Nested)
          .toList(),
      itemsWithNullableItem: model.itemsWithNullableItem
          .whereNotNull()
          .map<Nested>(_map__NestedDto__To__Nested)
          .toList(),
      itemsWithNullableItem2: model.itemsWithNullableItem2
          .map<Nested?>(_map__NestedDto__To__Nested_Nullable)
          .toList(),
      tag: null,
    );
  }

  Nested _map__NestedDto__To__Nested(NestedDto? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping NestedDto → Nested failed because NestedDto was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<NestedDto, Nested> to handle null values during mapping.');
    }
    return Nested(
      id: model.id,
      name: model.name,
      tag: _map__NestedTagDto__To__NestedTag(model.tag),
    );
  }

  NestedTag _map__NestedTagDto__To__NestedTag(NestedTagDto? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping NestedTagDto → NestedTag failed because NestedTagDto was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<NestedTagDto, NestedTag> to handle null values during mapping.');
    }
    return NestedTag();
  }

  Nested? _map__NestedDto__To__Nested_Nullable(NestedDto? input) {
    final model = input;
    if (model == null) {
      return null;
    }
    return Nested(
      id: model.id,
      name: model.name,
      tag: _map__NestedTagDto__To__NestedTag(model.tag),
    );
  }
}
