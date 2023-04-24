// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freezed_example.dart';

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: require_trailing_commas, unnecessary_parenthesis
// ignore_for_file: unnecessary_raw_strings

class $Mappr {
  Type _typeOf<T>() => T;
  TARGET convert<SOURCE, TARGET>(SOURCE? model) {
    return _convert(model);
  }

  TARGET _convert<SOURCE, TARGET>(SOURCE? model) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<UserInfo>() ||
            sourceTypeOf == _typeOf<UserInfo?>()) &&
        (targetTypeOf == _typeOf<UserInfoCompanion>() ||
            targetTypeOf == _typeOf<UserInfoCompanion?>())) {
      return (_map_UserInfo_To_UserInfoCompanion((model as UserInfo?))
          as TARGET);
    }
    throw Exception('No ${model.runtimeType} -> $targetTypeOf mapping.');
  }

  UserInfoCompanion _map_UserInfo_To_UserInfoCompanion(UserInfo? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          'Mapping UserInfo -> UserInfoCompanion failed because UserInfo was null, and no default value was provided. '
          'Consider setting the whenSourceIsNull parameter on the MapType<UserInfo, UserInfoCompanion> to handle null values during mapping.');
    }
    return UserInfoCompanion(
      email: model.email,
      loginIdentifier: model.loginIdentifier,
      updatedAt: model.updatedAt,
    );
  }
}
