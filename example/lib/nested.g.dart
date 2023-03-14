// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nested.dart';

// **************************************************************************
// AutoMapperGenerator
// **************************************************************************

class $ExampleMapper {
  Type _typeOf<T>() => T;
  TARGET convert<SOURCE, TARGET>(SOURCE model) {
    return _convert(model, canReturnNull: false);
  }

  TARGET _convert<SOURCE, TARGET>(
    SOURCE model, {
    bool canReturnNull = false,
  }) {
    if ((_typeOf<SOURCE>() == _typeOf<UserDto>() ||
            _typeOf<SOURCE>() == _typeOf<UserDto?>()) &&
        (_typeOf<TARGET>() == _typeOf<User>() ||
            _typeOf<TARGET>() == _typeOf<User?>())) {
      return (_mapUserDtoToUser(
        (model as UserDto?),
        canReturnNull: canReturnNull,
      ) as TARGET);
    }
    if ((_typeOf<SOURCE>() == _typeOf<NestedDto>() ||
            _typeOf<SOURCE>() == _typeOf<NestedDto?>()) &&
        (_typeOf<TARGET>() == _typeOf<Nested>() ||
            _typeOf<TARGET>() == _typeOf<Nested?>())) {
      return (_mapNestedDtoToNested(
        (model as NestedDto?),
        canReturnNull: canReturnNull,
      ) as TARGET);
    }
    if ((_typeOf<SOURCE>() == _typeOf<NestedTagDto>() ||
            _typeOf<SOURCE>() == _typeOf<NestedTagDto?>()) &&
        (_typeOf<TARGET>() == _typeOf<NestedTag>() ||
            _typeOf<TARGET>() == _typeOf<NestedTag?>())) {
      return (_mapNestedTagDtoToNestedTag(
        (model as NestedTagDto?),
        canReturnNull: canReturnNull,
      ) as TARGET);
    }
    throw Exception(
        'No mapping from ${model.runtimeType} -> ${_typeOf<TARGET>()}');
  }

  User? _mapUserDtoToUser(
    UserDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping UserDto -> User when null but no default value provided!');
    }
    final result = User(
      id: model.id,
      name: _convert(
        model.name,
        canReturnNull: false,
      ),
      nestedItems: model.nestedItems
          .map<Nested>((e) => _convert(
                e,
                canReturnNull: false,
              ))
          .toList(),
      nestedItemsNullable: model.nestedItemsNullable
              ?.map<Nested>((e) => _convert(
                    e,
                    canReturnNull: false,
                  ))
              .toList() ??
          <Nested>[],
      nestedItemsNullable2: model.nestedItemsNullable2
          .map<Nested>((e) => _convert(
                e,
                canReturnNull: false,
              ))
          .toList(),
      itemsWithNullableItem: model.itemsWithNullableItem
          .map<Nested>((e) => _convert(
                e,
                canReturnNull: false,
              ))
          .toList(),
      itemsWithNullableItem2: model.itemsWithNullableItem2
          .map<Nested?>((e) => _convert(
                e,
                canReturnNull: true,
              ))
          .toList(),
      tag: null,
    );
    return result;
  }

  Nested? _mapNestedDtoToNested(
    NestedDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping NestedDto -> Nested when null but no default value provided!');
    }
    final result = Nested(
      id: model.id,
      name: model.name,
      tag: _convert(
        model.tag,
        canReturnNull: false,
      ),
    );
    return result;
  }

  NestedTag? _mapNestedTagDtoToNestedTag(
    NestedTagDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping NestedTagDto -> NestedTag when null but no default value provided!');
    }
    final result = NestedTag();
    return result;
  }
}
