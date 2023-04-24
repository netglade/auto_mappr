// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_serializable.dart';

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: require_trailing_commas, unnecessary_parenthesis
// ignore_for_file: unnecessary_raw_strings

/// {@template auto_mappr:auto_mappr_json_example/test/fixture/json_serializable.dart}
/// Available mappings:
/// - `UserDto` → `User`.
/// - `ValueHolderDto` → `ValueHolder`.
/// {@endtemplate}
class $Mappr {
  Type _typeOf<T>() => T;

  /// Converts from SOURCE to TARGET if such mapping is configured.
  ///
  /// When source model is null, returns `whenSourceIsNull` if defined or throws an exception.
  ///
  /// {@macro auto_mappr:auto_mappr_json_example/test/fixture/json_serializable.dart}
  TARGET convert<SOURCE, TARGET>(SOURCE? model) => _convert(model)!;

  /// Converts from SOURCE to TARGET if such mapping is configured.
  ///
  /// When source model is null, returns `whenSourceIsNull` if defined or null.
  ///
  /// {@macro auto_mappr:auto_mappr_json_example/test/fixture/json_serializable.dart}
  TARGET? tryConvert<SOURCE, TARGET>(SOURCE? model) => _convert(
        model,
        canReturnNull: true,
      );

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into Iterable.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or throws an exception.
  ///
  /// {@macro auto_mappr:auto_mappr_json_example/test/fixture/json_serializable.dart}
  Iterable<TARGET> convertIterable<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      model.map<TARGET>((item) => _convert(item)!);

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into Iterable.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null
  ///
  /// {@macro auto_mappr:auto_mappr_json_example/test/fixture/json_serializable.dart}
  Iterable<TARGET?> tryConvertIterable<SOURCE, TARGET>(
          Iterable<SOURCE?> model) =>
      model.map<TARGET?>((item) => _convert(item, canReturnNull: true));

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into List.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or throws an exception.
  ///
  /// {@macro auto_mappr:auto_mappr_json_example/test/fixture/json_serializable.dart}
  List<TARGET> convertList<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      convertIterable<SOURCE, TARGET>(model).toList();

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into List.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null
  ///
  /// {@macro auto_mappr:auto_mappr_json_example/test/fixture/json_serializable.dart}
  List<TARGET?> tryConvertList<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      tryConvertIterable<SOURCE, TARGET>(model).toList();

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into Set.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or throws an exception.
  ///
  /// {@macro auto_mappr:auto_mappr_json_example/test/fixture/json_serializable.dart}
  Set<TARGET> convertSet<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      convertIterable<SOURCE, TARGET>(model).toSet();

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into Set.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null
  ///
  /// {@macro auto_mappr:auto_mappr_json_example/test/fixture/json_serializable.dart}
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
