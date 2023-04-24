// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nullable.dart';

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: require_trailing_commas, unnecessary_parenthesis
// ignore_for_file: unnecessary_raw_strings

class $Mappr {
  Type _typeOf<T>() => T;

  /// Converts from SOURCE to TARGET if such mapping is configured.
  ///
  /// If source model is null and `whenSourceIsNull` is not defined, convert methods throws exception.
  ///
  /// Available mappings:
  /// - `UserDto` → `User` -- With default value.
  /// - `NestedDto` → `Nested`.
  TARGET convert<SOURCE, TARGET>(SOURCE? model) => _convert(model)!;

  /// Converts from SOURCE to TARGET if such mapping is configured.
  ///
  /// If source model is null returns value from `whenSourceIsNull` if defined or null.
  ///
  /// Available mappings:
  /// - `UserDto` → `User` -- With default value.
  /// - `NestedDto` → `Nested`.
  TARGET? tryConvert<SOURCE, TARGET>(SOURCE? model) {
    return _convert<SOURCE, TARGET>(
      model,
      checkForNull: true,
    );
  }

  TARGET? _convert<SOURCE, TARGET>(
    SOURCE? model, {
    bool checkForNull = false,
  }) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<UserDto>() ||
            sourceTypeOf == _typeOf<UserDto?>()) &&
        (targetTypeOf == _typeOf<User>() || targetTypeOf == _typeOf<User?>())) {
      if (checkForNull && model == null) {
        return (const User(
          id: 1,
          tag: Nested(
            id: 1,
            name: r'default',
          ),
        ) as TARGET);
      }
      return (_map_UserDto_To_User((model as UserDto?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<NestedDto>() ||
            sourceTypeOf == _typeOf<NestedDto?>()) &&
        (targetTypeOf == _typeOf<Nested>() ||
            targetTypeOf == _typeOf<Nested?>())) {
      if (checkForNull && model == null) {
        return null;
      }
      return (_map_NestedDto_To_Nested((model as NestedDto?)) as TARGET);
    }
    throw Exception('No ${model.runtimeType} -> $targetTypeOf mapping.');
  }

  User _map_UserDto_To_User(UserDto? input) {
    final model = input;
    if (model == null) {
      return const User(
        id: 1,
        tag: Nested(
          id: 1,
          name: r'default',
        ),
      );
    }
    return User(
      id: model.id,
      tag: model.tag == null
          ? Mappr.defaultNested()
          : _map_NestedDto_To_Nested(model.tag),
      name: _map_NestedDto_To_Nested(model.name),
    );
  }

  Nested _map_NestedDto_To_Nested(NestedDto? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          'Mapping NestedDto → Nested failed because NestedDto was null, and no default value was provided. '
          'Consider setting the whenSourceIsNull parameter on the MapType<NestedDto, Nested> to handle null values during mapping.');
    }
    return Nested(
      id: model.id,
      name: model.name,
    );
  }
}
