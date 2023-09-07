// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: require_trailing_commas, unnecessary_const
// ignore_for_file: unnecessary_lambdas, unnecessary_parenthesis
// ignore_for_file: unnecessary_raw_strings

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_mappr_annotation/auto_mappr_annotation.dart' as _i1;

import 'enum.dart' as _i2;

/// {@template package:examples_example/enum.dart}
/// Available mappings:
/// - `UserType` → `PersonType`.
/// - `Vehicle` → `Vehicle`.
/// - `Vehicle` → `VehicleX`.
/// {@endtemplate}
class $Mappr implements _i1.AutoMapprInterface {
  const $Mappr();

  Type _typeOf<T>() => T;
  List<_i1.AutoMapprInterface> get _delegates => const [];

  /// {@macro AutoMapprInterface:canConvert}
  /// {@macro package:examples_example/enum.dart}
  @override
  bool canConvert<SOURCE, TARGET>({bool recursive = true}) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<_i2.UserType>() ||
            sourceTypeOf == _typeOf<_i2.UserType?>()) &&
        (targetTypeOf == _typeOf<_i2.PersonType>() ||
            targetTypeOf == _typeOf<_i2.PersonType?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i2.Vehicle>() ||
            sourceTypeOf == _typeOf<_i2.Vehicle?>()) &&
        (targetTypeOf == _typeOf<_i2.Vehicle>() ||
            targetTypeOf == _typeOf<_i2.Vehicle?>())) {
      return true;
    }
    if ((sourceTypeOf == _typeOf<_i2.Vehicle>() ||
            sourceTypeOf == _typeOf<_i2.Vehicle?>()) &&
        (targetTypeOf == _typeOf<_i2.VehicleX>() ||
            targetTypeOf == _typeOf<_i2.VehicleX?>())) {
      return true;
    }
    if (recursive) {
      for (final mappr in _delegates) {
        if (mappr.canConvert<SOURCE, TARGET>()) {
          return true;
        }
      }
    }
    return false;
  }

  /// {@macro AutoMapprInterface:convert}
  /// {@macro package:examples_example/enum.dart}
  @override
  TARGET convert<SOURCE, TARGET>(SOURCE? model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return _convert(model)!;
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.convert(model)!;
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// {@macro AutoMapprInterface:tryConvert}
  /// {@macro package:examples_example/enum.dart}
  @override
  TARGET? tryConvert<SOURCE, TARGET>(SOURCE? model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return _convert(
        model,
        canReturnNull: true,
      );
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvert(model);
      }
    }

    return null;
  }

  /// {@macro AutoMapprInterface:convertIterable}
  /// {@macro package:examples_example/enum.dart}
  @override
  Iterable<TARGET> convertIterable<SOURCE, TARGET>(Iterable<SOURCE?> model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return model.map<TARGET>((item) => _convert(item)!);
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.convertIterable(model);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into Iterable.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null
  ///
  /// {@macro package:examples_example/enum.dart}
  @override
  Iterable<TARGET?> tryConvertIterable<SOURCE, TARGET>(
      Iterable<SOURCE?> model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return model.map<TARGET?>((item) => _convert(item, canReturnNull: true));
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvertIterable(model);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// {@macro AutoMapprInterface:convertList}
  /// {@macro package:examples_example/enum.dart}
  @override
  List<TARGET> convertList<SOURCE, TARGET>(Iterable<SOURCE?> model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return convertIterable<SOURCE, TARGET>(model).toList();
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.convertList(model);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into List.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null
  ///
  /// {@macro package:examples_example/enum.dart}
  @override
  List<TARGET?> tryConvertList<SOURCE, TARGET>(Iterable<SOURCE?> model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return tryConvertIterable<SOURCE, TARGET>(model).toList();
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvertList(model);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// {@macro AutoMapprInterface:convertSet}
  /// {@macro package:examples_example/enum.dart}
  @override
  Set<TARGET> convertSet<SOURCE, TARGET>(Iterable<SOURCE?> model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return convertIterable<SOURCE, TARGET>(model).toSet();
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.convertSet(model);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  /// For iterable items, converts from SOURCE to TARGET if such mapping is configured, into Set.
  ///
  /// When an item in the source iterable is null, uses `whenSourceIsNull` if defined or null
  ///
  /// {@macro package:examples_example/enum.dart}
  @override
  Set<TARGET?> tryConvertSet<SOURCE, TARGET>(Iterable<SOURCE?> model) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return tryConvertIterable<SOURCE, TARGET>(model).toSet();
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvertSet(model);
      }
    }

    throw Exception('No ${_typeOf<SOURCE>()} -> ${_typeOf<TARGET>()} mapping.');
  }

  TARGET? _convert<SOURCE, TARGET>(
    SOURCE? model, {
    bool canReturnNull = false,
  }) {
    final sourceTypeOf = _typeOf<SOURCE>();
    final targetTypeOf = _typeOf<TARGET>();
    if ((sourceTypeOf == _typeOf<_i2.UserType>() ||
            sourceTypeOf == _typeOf<_i2.UserType?>()) &&
        (targetTypeOf == _typeOf<_i2.PersonType>() ||
            targetTypeOf == _typeOf<_i2.PersonType?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__UserType__To__PersonType((model as UserType?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i2.Vehicle>() ||
            sourceTypeOf == _typeOf<_i2.Vehicle?>()) &&
        (targetTypeOf == _typeOf<_i2.Vehicle>() ||
            targetTypeOf == _typeOf<_i2.Vehicle?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__Vehicle__To__Vehicle((model as Vehicle?)) as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i2.Vehicle>() ||
            sourceTypeOf == _typeOf<_i2.Vehicle?>()) &&
        (targetTypeOf == _typeOf<_i2.VehicleX>() ||
            targetTypeOf == _typeOf<_i2.VehicleX?>())) {
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
          r'Mapping UserType → PersonType failed because UserType was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<UserType, PersonType> to handle null values during mapping.');
    }
    return PersonType.values.firstWhere((x) => x.name == model.name);
  }

  Vehicle _map__Vehicle__To__Vehicle(Vehicle? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping Vehicle → Vehicle failed because Vehicle was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<Vehicle, Vehicle> to handle null values during mapping.');
    }
    return Vehicle.values.firstWhere((x) => x.name == model.name);
  }

  VehicleX _map__Vehicle__To__VehicleX(Vehicle? input) {
    final model = input;
    if (model == null) {
      throw Exception(
          r'Mapping Vehicle → VehicleX failed because Vehicle was null, and no default value was provided. '
          r'Consider setting the whenSourceIsNull parameter on the MapType<Vehicle, VehicleX> to handle null values during mapping.');
    }
    return VehicleX.values.firstWhere((x) => x.name == model.name);
  }
}
