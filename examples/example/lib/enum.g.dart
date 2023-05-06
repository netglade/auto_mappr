// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum.dart';

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: require_trailing_commas, unnecessary_const
// ignore_for_file: unnecessary_lambdas, unnecessary_parenthesis
// ignore_for_file: unnecessary_raw_strings

/// {@template package:auto_mappr_example_another/enum.dart}
/// Available mappings:
/// - `UserType` → `PersonType`.
/// - `Vehicle` → `Vehicle`.
/// - `Vehicle` → `VehicleX`.
/// {@endtemplate}
class $Mappr implements AutoMapprInterface {
  const $Mappr();

  Type _typeOf<T>() => T;
  List<AutoMapprInterface> get _modules => const [];

  /// {@macro AutoMapprInterface:canConvert}
  /// {@macro package:auto_mappr_example_another/enum.dart}
  @override
  bool canConvert<SOURCE, TARGET>(
    SOURCE? model, {
    bool recursive = true,
  }) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<UserType>() ||
            sourceTypeOf == _typeOf<UserType?>()) &&
        (targetTypeOf == _typeOf<PersonType>() ||
            targetTypeOf == _typeOf<PersonType?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<Vehicle>() ||
            sourceTypeOf == _typeOf<Vehicle?>()) &&
        (targetTypeOf == _typeOf<Vehicle>() ||
            targetTypeOf == _typeOf<Vehicle?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<Vehicle>() ||
            sourceTypeOf == _typeOf<Vehicle?>()) &&
        (targetTypeOf == _typeOf<VehicleX>() ||
            targetTypeOf == _typeOf<VehicleX?>())) {
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
  /// {@macro package:auto_mappr_example_another/enum.dart}
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
  /// {@macro package:auto_mappr_example_another/enum.dart}
  @override
  TARGET? tryConvert<SOURCE, TARGET>(SOURCE? model) => _convert(
        model,
        canReturnNull: true,
      );

  /// {@macro AutoMapprInterface:convertIterable}
  /// {@macro package:auto_mappr_example_another/enum.dart}
  @override
  Iterable<TARGET> convertIterable<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      model.map<TARGET>((item) => _convert(item)!);

  /// {@macro AutoMapprInterface:tryConvertIterable}
  /// {@macro package:auto_mappr_example_another/enum.dart}
  @override
  Iterable<TARGET?> tryConvertIterable<SOURCE, TARGET>(
          Iterable<SOURCE?> model) =>
      model.map<TARGET?>((item) => _convert(item, canReturnNull: true));

  /// {@macro AutoMapprInterface:convertList}
  /// {@macro package:auto_mappr_example_another/enum.dart}
  @override
  List<TARGET> convertList<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      convertIterable<SOURCE, TARGET>(model).toList();

  /// {@macro AutoMapprInterface:tryConvertList}
  /// {@macro package:auto_mappr_example_another/enum.dart}
  @override
  List<TARGET?> tryConvertList<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      tryConvertIterable<SOURCE, TARGET>(model).toList();

  /// {@macro AutoMapprInterface:convertSet}
  /// {@macro package:auto_mappr_example_another/enum.dart}
  @override
  Set<TARGET> convertSet<SOURCE, TARGET>(Iterable<SOURCE?> model) =>
      convertIterable<SOURCE, TARGET>(model).toSet();

  /// {@macro AutoMapprInterface:tryConvertSet}
  /// {@macro package:auto_mappr_example_another/enum.dart}
  @override
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
      return (_map_UserType_To_PersonType((model as UserType?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<Vehicle>() ||
            sourceTypeOf == _typeOf<Vehicle?>()) &&
        (targetTypeOf == _typeOf<Vehicle>() ||
            targetTypeOf == _typeOf<Vehicle?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map_Vehicle_To_Vehicle((model as Vehicle?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<Vehicle>() ||
            sourceTypeOf == _typeOf<Vehicle?>()) &&
        (targetTypeOf == _typeOf<VehicleX>() ||
            targetTypeOf == _typeOf<VehicleX?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map_Vehicle_To_VehicleX((model as Vehicle?)) as TARGET);
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

  Vehicle _map_Vehicle_To_Vehicle(Vehicle? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          'Mapping Vehicle → Vehicle failed because Vehicle was null, and no default value was provided. '
          'Consider setting the whenSourceIsNull parameter on the MapType<Vehicle, Vehicle> to handle null values during mapping.');
    }
    return Vehicle.values.firstWhere((x) => x.name == model.name);
  }

  VehicleX _map_Vehicle_To_VehicleX(Vehicle? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          'Mapping Vehicle → VehicleX failed because Vehicle was null, and no default value was provided. '
          'Consider setting the whenSourceIsNull parameter on the MapType<Vehicle, VehicleX> to handle null values during mapping.');
    }
    return VehicleX.values.firstWhere((x) => x.name == model.name);
  }
}
