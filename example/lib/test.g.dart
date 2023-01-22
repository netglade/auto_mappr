// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

class $Mapper {
  Type _typeOf<X>() => X;
  bool canConvert<I, R>() {
    if (_typeOf<I>() == UserDto && _typeOf<R>() == User) {
      return true;
    }
    return false;
  }

  R convert<I, R>(I model) {
    if (model is UserDto && _typeOf<R>() == User) {
      return (_mapUserDtoToUser(model) as R);
    }
    throw Exception('No mapper found for ${model.runtimeType}');
  }

  User _mapUserDtoToUser(UserDto model) {
    final result = User(
      null,
      id: model.id,
      name: Mapper.m(model),
      namedIgnoredByNull: null,
    );
    result.age = mapAge(model);
    return result;
  }
}
