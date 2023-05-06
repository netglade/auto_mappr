// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freezed_example.dart';

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: require_trailing_commas, unnecessary_lambdas
// ignore_for_file: unnecessary_parenthesis, unnecessary_raw_strings

/// {@template package:auto_mappr_freezed_example/freezed_example.dart}
/// Available mappings:
/// - `UserInfo` → `UserInfoCompanion`.
/// {@endtemplate}
class $Mappr implements AutoMapprInterface {
  const $Mappr();

  Type _typeOf<T>() => T;
  List<AutoMapprInterface> get _modules => const [];

  /// {@macro AutoMapprInterface:canConvert}
  /// {@macro package:auto_mappr_freezed_example/freezed_example.dart}
  @override
  bool canConvert<SOURCE, TARGET>(SOURCE? model) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<UserInfo>() ||
            sourceTypeOf == _typeOf<UserInfo?>()) &&
        (targetTypeOf == _typeOf<UserInfoCompanion>() ||
            targetTypeOf == _typeOf<UserInfoCompanion?>())) {
      return true;
    }
    return false;
  }

  /// {@macro AutoMapprInterface:convert}
  /// {@macro package:auto_mappr_freezed_example/freezed_example.dart}
  @override
  TARGET convert<SOURCE, TARGET>(SOURCE? model) {
    if (canConvert<SOURCE, TARGET>(model)) {
      return _convert(model)!;
    }
    for (final mappr in _modules) {
      if (mappr.canConvert<SOURCE, TARGET>(model)) {
        return mappr.convert(model)!;
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// {@macro AutoMapprInterface:tryConvert}
  /// {@macro package:auto_mappr_freezed_example/freezed_example.dart}
  @override
  TARGET? tryConvert<SOURCE, TARGET>(SOURCE? model) => _convert(
        model,
        canReturnNull: true,
      );

  /// {@macro AutoMapprInterface:convertIterable}
  /// {@macro package:auto_mappr_freezed_example/freezed_example.dart}
  @override
  Iterable<TARGET> convertIterable<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      model.map<TARGET>((item) => _convert(item)!);

  /// {@macro AutoMapprInterface:tryConvertIterable}
  /// {@macro package:auto_mappr_freezed_example/freezed_example.dart}
  @override
  Iterable<TARGET?> tryConvertIterable<SOURCE, TARGET>(
          Iterable<SOURCE?> model) =>
      model.map<TARGET?>((item) => _convert(item, canReturnNull: true));

  /// {@macro AutoMapprInterface:convertList}
  /// {@macro package:auto_mappr_freezed_example/freezed_example.dart}
  @override
  List<TARGET> convertList<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      convertIterable<SOURCE, TARGET>(model).toList();

  /// {@macro AutoMapprInterface:tryConvertList}
  /// {@macro package:auto_mappr_freezed_example/freezed_example.dart}
  @override
  List<TARGET?> tryConvertList<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      tryConvertIterable<SOURCE, TARGET>(model).toList();

  /// {@macro AutoMapprInterface:convertSet}
  /// {@macro package:auto_mappr_freezed_example/freezed_example.dart}
  @override
  Set<TARGET> convertSet<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      convertIterable<SOURCE, TARGET>(model).toSet();

  /// {@macro AutoMapprInterface:tryConvertSet}
  /// {@macro package:auto_mappr_freezed_example/freezed_example.dart}
  @override
  Set<TARGET?> tryConvertSet<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      tryConvertIterable<SOURCE, TARGET>(model).toSet();
  TARGET? _convert<SOURCE, TARGET>(
    SOURCE? model, {
    bool canReturnNull = false,
  }) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<UserInfo>() ||
            sourceTypeOf == _typeOf<UserInfo?>()) &&
        (targetTypeOf == _typeOf<UserInfoCompanion>() ||
            targetTypeOf == _typeOf<UserInfoCompanion?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map_UserInfo_To_UserInfoCompanion((model as UserInfo?))
          as TARGET);
    }
    throw Exception('No ${model.runtimeType} -> $targetTypeOf mapping.');
  }

  UserInfoCompanion _map_UserInfo_To_UserInfoCompanion(UserInfo? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          'Mapping UserInfo → UserInfoCompanion failed because UserInfo was null, and no default value was provided. '
          'Consider setting the whenSourceIsNull parameter on the MapType<UserInfo, UserInfoCompanion> to handle null values during mapping.');
    }
    return UserInfoCompanion(
      email: model.email,
      loginIdentifier: model.loginIdentifier,
      updatedAt: model.updatedAt,
    );
  }
}
