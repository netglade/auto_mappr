// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equatable.dart';

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
      name: model.name,
      tag: null,
    );
    return result;
  }
}
