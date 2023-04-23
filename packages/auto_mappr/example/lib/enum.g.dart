// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum.dart';

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
  /// - `UserType` → `PersonType`.
  TARGET convert<SOURCE, TARGET>(SOURCE? model) => _convert(model)!;

  /// Converts from SOURCE to TARGET if such mapping is configured.
  ///
  /// If source model is null returns value from `whenSourceIsNull` if defined or null.
  ///
  /// Available mappings:
  /// - `UserType` → `PersonType`.
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
    if ((sourceTypeOf == _typeOf<UserType>() ||
            sourceTypeOf == _typeOf<UserType?>()) &&
        (targetTypeOf == _typeOf<PersonType>() ||
            targetTypeOf == _typeOf<PersonType?>())) {
      if (checkForNull && model == null) {
        return null;
      }
      return (_map_UserType_To_PersonType((model as UserType?)) as TARGET);
    }
    throw Exception('No ${model.runtimeType} -> $targetTypeOf mapping.');
  }

  PersonType _map_UserType_To_PersonType(UserType? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          'Mapping UserType → PersonType failed because UserType was null, and no default value was provided. '
          'Consider setting the whenSourceIsNull parameter on the MapType<UserType, PersonType> to handle null values during mapping.');
    }
    return PersonType.values.firstWhere((x) => x.name == model.name);
  }
}
