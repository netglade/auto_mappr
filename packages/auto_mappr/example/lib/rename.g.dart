// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rename.dart';

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

class $Mapper {
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
      name: model.xname,
    );
    return result;
  }

  User? _mapUserDtoToUser__Nullable(UserDto? input) {
    final model = input;
    if (model == null) {
      return null;
    }
    final result = User(
      id: model.id,
      name: model.xname,
    );
    return result;
  }
}
