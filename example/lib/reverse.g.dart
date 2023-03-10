// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reverse.dart';

// **************************************************************************
// AutoMapperGenerator
// **************************************************************************

class $ExampleMapper {
  Type _typeOf<X>() => X;
  bool canConvert<I, R>() {
    if (_typeOf<I>() == UserDto && _typeOf<R>() == User) {
      return true;
    }
    if (_typeOf<I>() == User && _typeOf<R>() == UserDto) {
      return true;
    }
    return false;
  }

  R convert<I, R>(I model) {
    if (model is UserDto && _typeOf<R>() == User) {
      return (_mapUserDtoToUser(model) as R);
    }
    if (model is User && _typeOf<R>() == UserDto) {
      return (_mapUserToUserDto(model) as R);
    }
    throw Exception('No mapper found for ${model.runtimeType}');
  }

  User _mapUserDtoToUser(UserDto model) {
    final result = User(
      id: model.id,
      name: model.name,
    );
    return result;
  }

  UserDto _mapUserToUserDto(User model) {
    final result = UserDto(
      id: model.id,
      name: model.name,
    );
    return result;
  }
}
