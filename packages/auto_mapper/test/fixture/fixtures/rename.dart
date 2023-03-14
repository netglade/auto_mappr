part of '../rename.dart';

// **************************************************************************
// AutoMapperGenerator
// **************************************************************************

class $Mapper {
  Type _typeOf<T>() => T;
  Target convert<Source, Target>(Source model) {
    return _convert(model, canReturnNull: false);
  }

  Target _convert<Source, Target>(
    Source model, {
    bool canReturnNull = false,
  }) {
    if ((_typeOf<Source>() == _typeOf<UserDto>() ||
            _typeOf<Source>() == _typeOf<UserDto?>()) &&
        (_typeOf<Target>() == _typeOf<User>() ||
            _typeOf<Target>() == _typeOf<User?>())) {
      return (_mapUserDtoToUser(
        (model as UserDto?),
        canReturnNull: canReturnNull,
      ) as Target);
    }
    throw Exception(
        'No mapping from ${model.runtimeType} -> ${_typeOf<Target>()}');
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
      name: model.xname,
    );
    return result;
  }
}
