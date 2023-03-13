// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nullable.dart';

// **************************************************************************
// AutoMapperGenerator
// **************************************************************************

class $ExampleMapper {
  Type _typeOf<X>() => X;
  R convert<I, R>(I model) {
    return _convert(model, canReturnNull: false);
  }

  R _convert<I, R>(
    I model, {
    bool canReturnNull = false,
  }) {
    if ((_typeOf<I>() == _typeOf<UserDto>() ||
            _typeOf<I>() == _typeOf<UserDto?>()) &&
        (_typeOf<R>() == _typeOf<User>() || _typeOf<R>() == _typeOf<User?>())) {
      return (_mapUserDtoToUser(
        (model as UserDto?),
        canReturnNull: canReturnNull,
      ) as R);
    }
    if ((_typeOf<I>() == _typeOf<NestedDto>() ||
            _typeOf<I>() == _typeOf<NestedDto?>()) &&
        (_typeOf<R>() == _typeOf<Nested>() ||
            _typeOf<R>() == _typeOf<Nested?>())) {
      return (_mapNestedDtoToNested(
        (model as NestedDto?),
        canReturnNull: canReturnNull,
      ) as R);
    }
    throw Exception('No mapping from ${model.runtimeType} -> ${_typeOf<R>()}');
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
      name: _convert(
        model.name,
        canReturnNull: true,
      ),
      tag: model.tag == null
          ? ExampleMapper.defaultNested()
          : _convert(
              model.tag,
              canReturnNull: false,
            ),
    );
    return result;
  }

  Nested? _mapNestedDtoToNested(
    NestedDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping NestedDto -> Nested when null but no default value provided!');
    }
    final result = Nested(
      id: model.id,
      name: model.name,
    );
    return result;
  }
}
