// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nullable.dart';

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
    if ((sourceTypeOf == _typeOf<NestedDto>() ||
            sourceTypeOf == _typeOf<NestedDto?>()) &&
        (targetTypeOf == _typeOf<Nested>() ||
            targetTypeOf == _typeOf<Nested?>())) {
      return (_map_NestedDto$_To_Nested$((model as NestedDto?)) as TARGET);
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
      tag: model.tag == null
          ? Mappr.defaultNested()
          : _map_NestedDto$_To_Nested$(model.tag),
      name: _map_NestedDto$_To_Nested$_Nullable(model.name),
    );
    return result;
  }

  Nested _map_NestedDto$_To_Nested$(NestedDto? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          'Mapping NestedDto -> Nested when null but no default value provided!');
    }
    final result = Nested(
      id: model.id,
      name: model.name,
    );
    return result;
  }

  Nested? _map_NestedDto$_To_Nested$_Nullable(NestedDto? input) {
    final model = input;
    if (model == null) {
      return null;
    }
    final result = Nested(
      id: model.id,
      name: model.name,
    );
    return result;
  }
}
