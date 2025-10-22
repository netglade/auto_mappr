// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoMapprGenerator
// **************************************************************************

// ignore_for_file: type=lint, unnecessary_cast, unused_local_variable

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_mappr_annotation/auto_mappr_annotation.dart' as _i1;
import 'package:examples_example/enum.dart' as _i2;

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
  TARGET? tryConvert<SOURCE, TARGET>(
    SOURCE? model, {
    void Function(Object error, StackTrace stackTrace, SOURCE? source)?
    onMappingError,
  }) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return _safeConvert(model, onMappingError: onMappingError);
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvert(model, onMappingError: onMappingError);
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
    Iterable<SOURCE?> model, {
    void Function(Object error, StackTrace stackTrace, SOURCE? source)?
    onMappingError,
  }) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return model.map<TARGET?>(
        (item) => _safeConvert(item, onMappingError: onMappingError),
      );
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvertIterable(model, onMappingError: onMappingError);
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
  List<TARGET?> tryConvertList<SOURCE, TARGET>(
    Iterable<SOURCE?> model, {
    void Function(Object error, StackTrace stackTrace, SOURCE? source)?
    onMappingError,
  }) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return tryConvertIterable<SOURCE, TARGET>(
        model,
        onMappingError: onMappingError,
      ).toList();
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvertList(model, onMappingError: onMappingError);
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
  Set<TARGET?> tryConvertSet<SOURCE, TARGET>(
    Iterable<SOURCE?> model, {
    void Function(Object error, StackTrace stackTrace, SOURCE? source)?
    onMappingError,
  }) {
    if (canConvert<SOURCE, TARGET>(recursive: false)) {
      return tryConvertIterable<SOURCE, TARGET>(
        model,
        onMappingError: onMappingError,
      ).toSet();
    }
    for (final mappr in _delegates) {
      if (mappr.canConvert<SOURCE, TARGET>()) {
        return mappr.tryConvertSet(model, onMappingError: onMappingError);
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
      return (_map__i2$UserType_To__i2$PersonType((model as _i2.UserType?))
          as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i2.Vehicle>() ||
            sourceTypeOf == _typeOf<_i2.Vehicle?>()) &&
        (targetTypeOf == _typeOf<_i2.Vehicle>() ||
            targetTypeOf == _typeOf<_i2.Vehicle?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i2$Vehicle_To__i2$Vehicle((model as _i2.Vehicle?))
          as TARGET);
    }
    if ((sourceTypeOf == _typeOf<_i2.Vehicle>() ||
            sourceTypeOf == _typeOf<_i2.Vehicle?>()) &&
        (targetTypeOf == _typeOf<_i2.VehicleX>() ||
            targetTypeOf == _typeOf<_i2.VehicleX?>())) {
      if (canReturnNull && model == null) {
        return null;
      }
      return (_map__i2$Vehicle_To__i2$VehicleX((model as _i2.Vehicle?))
          as TARGET);
    }
    throw Exception('No ${model.runtimeType} -> $targetTypeOf mapping.');
  }

  TARGET? _safeConvert<SOURCE, TARGET>(
    SOURCE? model, {
    void Function(Object error, StackTrace stackTrace, SOURCE? source)?
    onMappingError,
  }) {
    if (!useSafeMapping<SOURCE, TARGET>()) {
      return _convert(model, canReturnNull: true);
    }
    try {
      return _convert(model, canReturnNull: true);
    } catch (e, s) {
      onMappingError?.call(e, s, model);
      return null;
    }
  }

  /// {@macro AutoMapprInterface:useSafeMapping}
  /// {@macro package:examples_example/enum.dart}
  @override
  bool useSafeMapping<SOURCE, TARGET>() {
    return false;
  }

  _i2.PersonType _map__i2$UserType_To__i2$PersonType(_i2.UserType? input) {
    final model = input;
    if (model == null) {
      throw Exception(
        r'Mapping UserType → PersonType failed because UserType was null, and no default value was provided. '
        r'Consider setting the whenSourceIsNull parameter on the MapType<UserType, PersonType> to handle null values during mapping.',
      );
    }
    return _i2.PersonType.values.firstWhere((x) => x.name == model.name);
  }

  _i2.Vehicle _map__i2$Vehicle_To__i2$Vehicle(_i2.Vehicle? input) {
    final model = input;
    if (model == null) {
      throw Exception(
        r'Mapping Vehicle → Vehicle failed because Vehicle was null, and no default value was provided. '
        r'Consider setting the whenSourceIsNull parameter on the MapType<Vehicle, Vehicle> to handle null values during mapping.',
      );
    }
    return _i2.Vehicle.values.firstWhere((x) => x.name == model.name);
  }

  _i2.VehicleX _map__i2$Vehicle_To__i2$VehicleX(_i2.Vehicle? input) {
    final model = input;
    if (model == null) {
      throw Exception(
        r'Mapping Vehicle → VehicleX failed because Vehicle was null, and no default value was provided. '
        r'Consider setting the whenSourceIsNull parameter on the MapType<Vehicle, VehicleX> to handle null values during mapping.',
      );
    }
    return _i2.VehicleX.values.firstWhere((x) => x.name == model.name);
  }
}
