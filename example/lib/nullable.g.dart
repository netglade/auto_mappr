// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nullable.dart';

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
    if ((_typeOf<I>() == _typeOf<NestedDto>() ||
            _typeOf<I>() == _typeOf<NestedDto?>()) &&
        (_typeOf<R>() == _typeOf<Nested>() ||
            _typeOf<R>() == _typeOf<Nested?>())) {
      return (_mapNestedDtoToNested((model as NestedDto?)) as R);
    }
    throw Exception('No mapping from ${model.runtimeType} -> ${_typeOf<R>()}');
  }

  User _mapUserDtoToUser(UserDto input) {
    final model = input;
    final result = User(
      id: model.id,
      name: _convert(model.name),
      tag: _convert(model.tag),
    );
    return result;
  }

  Nested _mapNestedDtoToNested(NestedDto? input) {
    final model = input;
    if (model == null) return ExampleMapper.defaultNested();
    final result = Nested(
      id: model.id,
      name: model.name,
    );
    return result;
  }
}
