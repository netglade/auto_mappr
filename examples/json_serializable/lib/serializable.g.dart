// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializable.dart';

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: require_trailing_commas, unnecessary_const
// ignore_for_file: unnecessary_lambdas, unnecessary_parenthesis
// ignore_for_file: unnecessary_raw_strings

/// {@template package:auto_mappr_json_example/serializable.dart}
/// Available mappings:
/// - `UserDto` → `User`.
/// - `ValueHolderDto` → `ValueHolder`.
/// {@endtemplate}
class $Mappr implements AutoMapprInterface {
  const $Mappr();

  Type _typeOf<T>() => T;
  List<AutoMapprInterface> get _modules => const [];

  /// {@macro AutoMapprInterface:canConvert}
  /// {@macro package:auto_mappr_json_example/serializable.dart}
  @override
  bool canConvert<SOURCE, TARGET>(
    SOURCE? model, {
    bool recursive = true,
  }) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<UserDto>() ||
            sourceTypeOf == _typeOf<UserDto?>()) &&
        (targetTypeOf == _typeOf<User>() || targetTypeOf == _typeOf<User?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<ValueHolderDto>() ||
            sourceTypeOf == _typeOf<ValueHolderDto?>()) &&
        (targetTypeOf == _typeOf<ValueHolder>() ||
            targetTypeOf == _typeOf<ValueHolder?>())) {
      return true;
    }
    if (recursive) {
      for (final mappr in _modules) {
        if (mappr.canConvert<SOURCE, TARGET>(model)) {
          return true;
        }
      }
    }
    return false;
  }

  /// {@macro AutoMapprInterface:convert}
  /// {@macro package:auto_mappr_json_example/serializable.dart}
  @override
  TARGET convert<SOURCE, TARGET>(SOURCE? model) {
    if (canConvert<SOURCE, TARGET>(
      model,
      recursive: false,
    )) {
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
  /// {@macro package:auto_mappr_json_example/serializable.dart}
  @override
  TARGET? tryConvert<SOURCE, TARGET>(SOURCE? model) => _convert(
        model,
        canReturnNull: true,
      );

  /// {@macro AutoMapprInterface:convertIterable}
  /// {@macro package:auto_mappr_json_example/serializable.dart}
  @override
  Iterable<TARGET> convertIterable<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      model.map<TARGET>((item) => _convert(item)!);

  /// {@macro AutoMapprInterface:tryConvertIterable}
  /// {@macro package:auto_mappr_json_example/serializable.dart}
  @override
  Iterable<TARGET?> tryConvertIterable<SOURCE, TARGET>(
          Iterable<SOURCE?> model) =>
      model.map<TARGET?>((item) => _convert(item, canReturnNull: true));

  /// {@macro AutoMapprInterface:convertList}
  /// {@macro package:auto_mappr_json_example/serializable.dart}
  @override
  List<TARGET> convertList<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      convertIterable<SOURCE, TARGET>(model).toList();

  /// {@macro AutoMapprInterface:tryConvertList}
  /// {@macro package:auto_mappr_json_example/serializable.dart}
  @override
  List<TARGET?> tryConvertList<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      tryConvertIterable<SOURCE, TARGET>(model).toList();

  /// {@macro AutoMapprInterface:convertSet}
  /// {@macro package:auto_mappr_json_example/serializable.dart}
  @override
  Set<TARGET> convertSet<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      convertIterable<SOURCE, TARGET>(model).toSet();

  /// {@macro AutoMapprInterface:tryConvertSet}
  /// {@macro package:auto_mappr_json_example/serializable.dart}
  @override
  Set<TARGET?> tryConvertSet<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      tryConvertIterable<SOURCE, TARGET>(model).toSet();
  TARGET? _convert<SOURCE, TARGET>(
    SOURCE? model, {
    bool canReturnNull = false,
  }) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<UserDto>() ||
            sourceTypeOf == _typeOf<UserDto?>()) &&
        (targetTypeOf == _typeOf<User>() || targetTypeOf == _typeOf<User?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map_UserDto_To_User((model as UserDto?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<ValueHolderDto>() ||
            sourceTypeOf == _typeOf<ValueHolderDto?>()) &&
        (targetTypeOf == _typeOf<ValueHolder>() ||
            targetTypeOf == _typeOf<ValueHolder?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map_ValueHolderDto_To_ValueHolder((model as ValueHolderDto?))
          as TARGET);
    }
    throw Exception('No ${model.runtimeType} -> $targetTypeOf mapping.');
  }

  User _map_UserDto_To_User(UserDto? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          'Mapping UserDto → User failed because UserDto was null, and no default value was provided. '
          'Consider setting the whenSourceIsNull parameter on the MapType<UserDto, User> to handle null values during mapping.');
    }
    return User(
      firstName: model.firstName,
      lastName: model.lastName,
    );
  }

  ValueHolder _map_ValueHolderDto_To_ValueHolder(ValueHolderDto? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          'Mapping ValueHolderDto → ValueHolder failed because ValueHolderDto was null, and no default value was provided. '
          'Consider setting the whenSourceIsNull parameter on the MapType<ValueHolderDto, ValueHolder> to handle null values during mapping.');
    }
    return ValueHolder(model.json);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };

ValueHolderDto _$ValueHolderDtoFromJson(Map<String, dynamic> json) =>
    ValueHolderDto(
      json['json'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ValueHolderDtoToJson(ValueHolderDto instance) =>
    <String, dynamic>{
      'json': instance.json,
    };
