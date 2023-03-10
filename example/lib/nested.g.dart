// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nested.dart';

// **************************************************************************
// AutoMapperGenerator
// **************************************************************************

class $ExampleMapper {
  Type _typeOf<X>() => X;
  bool canConvert<I, R>() {
    if (_typeOf<I>() == UserDto && _typeOf<R>() == User) {
      return true;
    }
    if (_typeOf<I>() == NestedDto && _typeOf<R>() == Nested) {
      return true;
    }
    if (_typeOf<I>() == NestedTagDto && _typeOf<R>() == NestedTag) {
      return true;
    }
    return false;
  }

  R convert<I, R>(I model) {
    if (model is UserDto && _typeOf<R>() == User) {
      return (_mapUserDtoToUser(model) as R);
    }
    if (model is NestedDto && _typeOf<R>() == Nested) {
      return (_mapNestedDtoToNested(model) as R);
    }
    if (model is NestedTagDto && _typeOf<R>() == NestedTag) {
      return (_mapNestedTagDtoToNestedTag(model) as R);
    }
    throw Exception('No mapper found for ${model.runtimeType}');
  }

  User _mapUserDtoToUser(UserDto model) {
    final result = User(
      id: model.id,
      name: convert<NestedDto, Nested>(model.name),
      nestedItems:
          model.nestedItems.map((e) => convert<NestedDto, Nested>(e)).toList(),
      nestedItemsNullable: model.nestedItemsNullable
              ?.map((e) => convert<NestedDto, Nested>(e))
              .toList() ??
          [],
      nestedItemsNullable2: model.nestedItemsNullable2
          .map((e) => convert<NestedDto, Nested>(e))
          .toList(),
      tag: null,
    );
    return result;
  }

  Nested _mapNestedDtoToNested(NestedDto model) {
    final result = Nested(
      id: model.id,
      name: model.name,
      tag: convert<NestedTagDto, NestedTag>(model.tag),
    );
    return result;
  }

  NestedTag _mapNestedTagDtoToNestedTag(NestedTagDto model) {
    final result = NestedTag();
    return result;
  }
}
