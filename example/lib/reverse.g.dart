// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reverse.dart';

// **************************************************************************
// AutoMapperGenerator
// **************************************************************************

class $ExampleMapper {
  Type _typeOf<X>() => X;
  R convert<I, R>(I model) {
    return _convert(model);
  }

  R _convert<I, R>(I model) {
    if ((_typeOf<I>() == _typeOf<UserDto>() ||
            _typeOf<I>() == _typeOf<UserDto?>()) &&
        (_typeOf<R>() == _typeOf<User>() || _typeOf<R>() == _typeOf<User?>())) {
      return (_mapUserDtoToUser((model as UserDto)) as R);
    }
    if ((_typeOf<I>() == _typeOf<User>() || _typeOf<I>() == _typeOf<User?>()) &&
        (_typeOf<R>() == _typeOf<UserDto>() ||
            _typeOf<R>() == _typeOf<UserDto?>())) {
      return (_mapUserToUserDto((model as User)) as R);
    }
    throw Exception('No mapping from ${model.runtimeType} -> ${_typeOf<R>()}');
  }

  User _mapUserDtoToUser(UserDto input) {
    final model = input;
    final result = User(
      id: model.id,
      name: model.name,
    );
    return result;
  }

  UserDto _mapUserToUserDto(User input) {
    final model = input;
    final result = UserDto(
      id: model.id,
      name: model.name,
    );
    return result;
  }
}
