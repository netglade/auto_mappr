// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum.dart';

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: require_trailing_commas, unnecessary_lambdas
// ignore_for_file: unnecessary_parenthesis, unnecessary_raw_strings

/// {@template package:examples_example/enum.dart}
/// Available mappings:
/// - `UserType` → `PersonType`.
/// - `Vehicle` → `Vehicle`.
/// - `Vehicle` → `VehicleX`.
/// {@endtemplate}
class $Mappr {
  Type _typeOf<T>() => T;

  /// Converts from SOURCE to TARGET if such mapping is configured.
  ///
  /// When source model is null, returns `whenSourceIsNull` if defined or throws an exception.
  ///
  /// {@macro package:examples_example/enum.dart}
  TARGET convert<SOURCE, TARGET>(SOURCE? model) => _convert(model)!;

  /// Converts from SOURCE to TARGET if such mapping is configured.
  ///
  /// When source model is null, returns `whenSourceIsNull` if defined or null.
  ///
  /// {@macro package:examples_example/enum.dart}
  TARGET? tryConvert<SOURCE, TARGET>(SOURCE? model) => _convert(
        model,
        canReturnNull: true,
      );

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into Iterable.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or throws an exception.
  ///
  /// {@macro package:examples_example/enum.dart}
  Iterable<TARGET> convertIterable<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      model.map<TARGET>((item) => _convert(item)!);

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into Iterable.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null
  ///
  /// {@macro package:examples_example/enum.dart}
  Iterable<TARGET?> tryConvertIterable<SOURCE, TARGET>(
          Iterable<SOURCE?> model) =>
      model.map<TARGET?>((item) => _convert(item, canReturnNull: true));

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into List.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or throws an exception.
  ///
  /// {@macro package:examples_example/enum.dart}
  List<TARGET> convertList<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      convertIterable<SOURCE, TARGET>(model).toList();

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into List.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null
  ///
  /// {@macro package:examples_example/enum.dart}
  List<TARGET?> tryConvertList<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      tryConvertIterable<SOURCE, TARGET>(model).toList();

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into Set.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or throws an exception.
  ///
  /// {@macro package:examples_example/enum.dart}
  Set<TARGET> convertSet<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      convertIterable<SOURCE, TARGET>(model).toSet();

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into Set.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null
  ///
  /// {@macro package:examples_example/enum.dart}
  Set<TARGET?> tryConvertSet<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      tryConvertIterable<SOURCE, TARGET>(model).toSet();
  TARGET? _convert<SOURCE, TARGET>(
    SOURCE? model, {
    bool canReturnNull = false,
  }) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<UserType>() ||
            sourceTypeOf == _typeOf<UserType?>()) &&
        (targetTypeOf == _typeOf<PersonType>() ||
            targetTypeOf == _typeOf<PersonType?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__UserType__To__PersonType((model as UserType?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<Vehicle>() ||
            sourceTypeOf == _typeOf<Vehicle?>()) &&
        (targetTypeOf == _typeOf<Vehicle>() ||
            targetTypeOf == _typeOf<Vehicle?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__Vehicle__To__Vehicle((model as Vehicle?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<Vehicle>() ||
            sourceTypeOf == _typeOf<Vehicle?>()) &&
        (targetTypeOf == _typeOf<VehicleX>() ||
            targetTypeOf == _typeOf<VehicleX?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__Vehicle__To__VehicleX((model as Vehicle?)) as TARGET);
    }
    throw Exception('No ${model.runtimeType} -> $targetTypeOf mapping.');
  }

  PersonType _map__UserType__To__PersonType(UserType? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          'Mapping UserType → PersonType failed because UserType was null, and no default value was provided. '
          'Consider setting the whenSourceIsNull parameter on the MapType<UserType, PersonType> to handle null values during mapping.');
    }
    return PersonType.values.firstWhere((x) => x.name == model.name);
  }

  Vehicle _map__Vehicle__To__Vehicle(Vehicle? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          'Mapping Vehicle → Vehicle failed because Vehicle was null, and no default value was provided. '
          'Consider setting the whenSourceIsNull parameter on the MapType<Vehicle, Vehicle> to handle null values during mapping.');
    }
    return Vehicle.values.firstWhere((x) => x.name == model.name);
  }

  VehicleX _map__Vehicle__To__VehicleX(Vehicle? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          'Mapping Vehicle → VehicleX failed because Vehicle was null, and no default value was provided. '
          'Consider setting the whenSourceIsNull parameter on the MapType<Vehicle, VehicleX> to handle null values during mapping.');
    }
    return VehicleX.values.firstWhere((x) => x.name == model.name);
  }
}
