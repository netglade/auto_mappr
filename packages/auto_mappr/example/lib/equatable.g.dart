// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equatable.dart';

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

class $Mappr {
  Type _typeOf<T>() => T;
  TARGET convert<SOURCE, TARGET>(SOURCE? model) {
    return _convert(model);
  }

  TARGET _convert<SOURCE, TARGET>(SOURCE? model) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<UserDto>() ||
            sourceTypeOf == _typeOf<UserDto?>()) &&
        (targetTypeOf == _typeOf<User>() || targetTypeOf == _typeOf<User?>())) {
      return (_map_UserDto$_To_User$((model as UserDto?)) as TARGET);
    }
    throw Exception('No mapping from ${model.runtimeType} -> $targetTypeOf');
  }

  User _map_UserDto$_To_User$(UserDto? input) {
    final model = input;
    if (model == null) {
      throw Exception(
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
