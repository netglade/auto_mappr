// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nested.dart';

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

class $Mappr {
  Type _typeOf<T>() => T;
  TARGET convert<SOURCE, TARGET>(SOURCE? model) {
    return _convert(model);
  }

  TARGET _convert<SOURCE, TARGET>(SOURCE? model) {
    if ((_typeOf<SOURCE>() == _typeOf<UserDto>() ||
            _typeOf<SOURCE>() == _typeOf<UserDto?>()) &&
        (_typeOf<TARGET>() == _typeOf<User>() ||
            _typeOf<TARGET>() == _typeOf<User?>())) {
      return (_mapUserDtoToUser((model as UserDto?)) as TARGET);
    }
    if ((_typeOf<SOURCE>() == _typeOf<NestedDto>() ||
            _typeOf<SOURCE>() == _typeOf<NestedDto?>()) &&
        (_typeOf<TARGET>() == _typeOf<Nested>() ||
            _typeOf<TARGET>() == _typeOf<Nested?>())) {
      return (_mapNestedDtoToNested((model as NestedDto?)) as TARGET);
    }
    if ((_typeOf<SOURCE>() == _typeOf<NestedTagDto>() ||
            _typeOf<SOURCE>() == _typeOf<NestedTagDto?>()) &&
        (_typeOf<TARGET>() == _typeOf<NestedTag>() ||
            _typeOf<TARGET>() == _typeOf<NestedTag?>())) {
      return (_mapNestedTagDtoToNestedTag((model as NestedTagDto?)) as TARGET);
    }
    throw Exception(
        'No mapping from ${model.runtimeType} -> ${_typeOf<TARGET>()}');
  }

  User _mapUserDtoToUser(UserDto? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          'Mapping UserDto -> User when null but no default value provided!');
    }
    final result = User(
      id: model.id,
      name: _mapNestedDtoToNested(model.name),
      nestedItems: model.nestedItems
          .map<Nested>((e) => _mapNestedDtoToNested(e))
          .toList(),
      nestedItemsNullable: model.nestedItemsNullable
              ?.map<Nested>((e) => _mapNestedDtoToNested(e))
              .toList() ??
          <Nested>[],
      nestedItemsNullable2: model.nestedItemsNullable2
          .map<Nested>((e) => _mapNestedDtoToNested(e))
          .toList(),
      itemsWithNullableItem: model.itemsWithNullableItem
          .whereNotNull()
          .map<Nested>((e) => _mapNestedDtoToNested(e))
          .toList(),
      itemsWithNullableItem2: model.itemsWithNullableItem2
          .map<Nested?>((e) => _mapNestedDtoToNested__Nullable(e))
          .toList(),
      tag: null,
    );
    return result;
  }

  Nested _mapNestedDtoToNested(NestedDto? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          'Mapping NestedDto -> Nested when null but no default value provided!');
    }
    final result = Nested(
      id: model.id,
      name: model.name,
      tag: _mapNestedTagDtoToNestedTag(model.tag),
    );
    return result;
  }

  NestedTag _mapNestedTagDtoToNestedTag(NestedTagDto? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          'Mapping NestedTagDto -> NestedTag when null but no default value provided!');
    }
    final result = NestedTag();
    return result;
  }

  Nested? _mapNestedDtoToNested__Nullable(NestedDto? input) {
    final model = input;
    if (model == null) {
      return null;
    }
    final result = Nested(
      id: model.id,
      name: model.name,
      tag: _mapNestedTagDtoToNestedTag(model.tag),
    );
    return result;
  }
}
