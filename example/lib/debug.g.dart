// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debug.dart';

// **************************************************************************
// AutoMapperGenerator
// **************************************************************************

class $Mapper {
  Type _typeOf<T>() => T;
  TARGET convert<SOURCE, TARGET>(SOURCE model) {
    return _convert(model, canReturnNull: false);
  }

  TARGET _convert<SOURCE, TARGET>(
    SOURCE model, {
    bool canReturnNull = false,
  }) {
    if ((_typeOf<SOURCE>() == _typeOf<SamePositionalDto>() ||
            _typeOf<SOURCE>() == _typeOf<SamePositionalDto?>()) &&
        (_typeOf<TARGET>() == _typeOf<SamePositional>() ||
            _typeOf<TARGET>() == _typeOf<SamePositional?>())) {
      return (_mapSamePositionalDtoToSamePositional(
        (model as SamePositionalDto?),
        canReturnNull: canReturnNull,
      ) as TARGET);
    }
    if ((_typeOf<SOURCE>() == _typeOf<SameNamedDto>() ||
            _typeOf<SOURCE>() == _typeOf<SameNamedDto?>()) &&
        (_typeOf<TARGET>() == _typeOf<SameNamed>() ||
            _typeOf<TARGET>() == _typeOf<SameNamed?>())) {
      return (_mapSameNamedDtoToSameNamed(
        (model as SameNamedDto?),
        canReturnNull: canReturnNull,
      ) as TARGET);
    }
    if ((_typeOf<SOURCE>() == _typeOf<PrimitivePositionalDto>() ||
            _typeOf<SOURCE>() == _typeOf<PrimitivePositionalDto?>()) &&
        (_typeOf<TARGET>() == _typeOf<PrimitivePositional>() ||
            _typeOf<TARGET>() == _typeOf<PrimitivePositional?>())) {
      return (_mapPrimitivePositionalDtoToPrimitivePositional(
        (model as PrimitivePositionalDto?),
        canReturnNull: canReturnNull,
      ) as TARGET);
    }
    if ((_typeOf<SOURCE>() == _typeOf<PrimitiveNamedDto>() ||
            _typeOf<SOURCE>() == _typeOf<PrimitiveNamedDto?>()) &&
        (_typeOf<TARGET>() == _typeOf<PrimitiveNamed>() ||
            _typeOf<TARGET>() == _typeOf<PrimitiveNamed?>())) {
      return (_mapPrimitiveNamedDtoToPrimitiveNamed(
        (model as PrimitiveNamedDto?),
        canReturnNull: canReturnNull,
      ) as TARGET);
    }
    if ((_typeOf<SOURCE>() == _typeOf<PrimitivePositionalReversedDto>() ||
            _typeOf<SOURCE>() == _typeOf<PrimitivePositionalReversedDto?>()) &&
        (_typeOf<TARGET>() == _typeOf<PrimitivePositionalReversed>() ||
            _typeOf<TARGET>() == _typeOf<PrimitivePositionalReversed?>())) {
      return (_mapPrimitivePositionalReversedDtoToPrimitivePositionalReversed(
        (model as PrimitivePositionalReversedDto?),
        canReturnNull: canReturnNull,
      ) as TARGET);
    }
    if ((_typeOf<SOURCE>() == _typeOf<PrimitiveNamedReversedDto>() ||
            _typeOf<SOURCE>() == _typeOf<PrimitiveNamedReversedDto?>()) &&
        (_typeOf<TARGET>() == _typeOf<PrimitiveNamedReversed>() ||
            _typeOf<TARGET>() == _typeOf<PrimitiveNamedReversed?>())) {
      return (_mapPrimitiveNamedReversedDtoToPrimitiveNamedReversed(
        (model as PrimitiveNamedReversedDto?),
        canReturnNull: canReturnNull,
      ) as TARGET);
    }
    if ((_typeOf<SOURCE>() == _typeOf<ComplexPositionalDto>() ||
            _typeOf<SOURCE>() == _typeOf<ComplexPositionalDto?>()) &&
        (_typeOf<TARGET>() == _typeOf<ComplexPositional>() ||
            _typeOf<TARGET>() == _typeOf<ComplexPositional?>())) {
      return (_mapComplexPositionalDtoToComplexPositional(
        (model as ComplexPositionalDto?),
        canReturnNull: canReturnNull,
      ) as TARGET);
    }
    if ((_typeOf<SOURCE>() == _typeOf<ComplexNamedDto>() ||
            _typeOf<SOURCE>() == _typeOf<ComplexNamedDto?>()) &&
        (_typeOf<TARGET>() == _typeOf<ComplexNamed>() ||
            _typeOf<TARGET>() == _typeOf<ComplexNamed?>())) {
      return (_mapComplexNamedDtoToComplexNamed(
        (model as ComplexNamedDto?),
        canReturnNull: canReturnNull,
      ) as TARGET);
    }
    if ((_typeOf<SOURCE>() == _typeOf<ComplexPositionalReversedDto>() ||
            _typeOf<SOURCE>() == _typeOf<ComplexPositionalReversedDto?>()) &&
        (_typeOf<TARGET>() == _typeOf<ComplexPositionalReversed>() ||
            _typeOf<TARGET>() == _typeOf<ComplexPositionalReversed?>())) {
      return (_mapComplexPositionalReversedDtoToComplexPositionalReversed(
        (model as ComplexPositionalReversedDto?),
        canReturnNull: canReturnNull,
      ) as TARGET);
    }
    if ((_typeOf<SOURCE>() == _typeOf<ComplexNamedReversedDto>() ||
            _typeOf<SOURCE>() == _typeOf<ComplexNamedReversedDto?>()) &&
        (_typeOf<TARGET>() == _typeOf<ComplexNamedReversed>() ||
            _typeOf<TARGET>() == _typeOf<ComplexNamedReversed?>())) {
      return (_mapComplexNamedReversedDtoToComplexNamedReversed(
        (model as ComplexNamedReversedDto?),
        canReturnNull: canReturnNull,
      ) as TARGET);
    }
    if ((_typeOf<SOURCE>() == _typeOf<CustomPositionalDto>() ||
            _typeOf<SOURCE>() == _typeOf<CustomPositionalDto?>()) &&
        (_typeOf<TARGET>() == _typeOf<CustomPositional>() ||
            _typeOf<TARGET>() == _typeOf<CustomPositional?>())) {
      return (_mapCustomPositionalDtoToCustomPositional(
        (model as CustomPositionalDto?),
        canReturnNull: canReturnNull,
      ) as TARGET);
    }
    if ((_typeOf<SOURCE>() == _typeOf<CustomNamedDto>() ||
            _typeOf<SOURCE>() == _typeOf<CustomNamedDto?>()) &&
        (_typeOf<TARGET>() == _typeOf<CustomNamed>() ||
            _typeOf<TARGET>() == _typeOf<CustomNamed?>())) {
      return (_mapCustomNamedDtoToCustomNamed(
        (model as CustomNamedDto?),
        canReturnNull: canReturnNull,
      ) as TARGET);
    }
    throw Exception(
        'No mapping from ${model.runtimeType} -> ${_typeOf<TARGET>()}');
  }

  SamePositional? _mapSamePositionalDtoToSamePositional(
    SamePositionalDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping SamePositionalDto -> SamePositional when null but no default value provided!');
    }
    final result = SamePositional(
      model.id,
      model.name,
    );
    return result;
  }

  SameNamed? _mapSameNamedDtoToSameNamed(
    SameNamedDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping SameNamedDto -> SameNamed when null but no default value provided!');
    }
    final result = SameNamed(
      id: model.id,
      name: model.name,
    );
    return result;
  }

  PrimitivePositional? _mapPrimitivePositionalDtoToPrimitivePositional(
    PrimitivePositionalDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping PrimitivePositionalDto -> PrimitivePositional when null but no default value provided!');
    }
    final result = PrimitivePositional(model.idx);
    return result;
  }

  PrimitiveNamed? _mapPrimitiveNamedDtoToPrimitiveNamed(
    PrimitiveNamedDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping PrimitiveNamedDto -> PrimitiveNamed when null but no default value provided!');
    }
    final result = PrimitiveNamed(id: model.idx);
    return result;
  }

  PrimitivePositionalReversed?
      _mapPrimitivePositionalReversedDtoToPrimitivePositionalReversed(
    PrimitivePositionalReversedDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping PrimitivePositionalReversedDto -> PrimitivePositionalReversed when null but no default value provided!');
    }
    final result = PrimitivePositionalReversed(
      model.beta,
      model.alpha,
    );
    return result;
  }

  PrimitiveNamedReversed? _mapPrimitiveNamedReversedDtoToPrimitiveNamedReversed(
    PrimitiveNamedReversedDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping PrimitiveNamedReversedDto -> PrimitiveNamedReversed when null but no default value provided!');
    }
    final result = PrimitiveNamedReversed(
      alpha: model.beta,
      beta: model.alpha,
    );
    return result;
  }

  ComplexPositional? _mapComplexPositionalDtoToComplexPositional(
    ComplexPositionalDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping ComplexPositionalDto -> ComplexPositional when null but no default value provided!');
    }
    final result = ComplexPositional(model.datax);
    return result;
  }

  ComplexNamed? _mapComplexNamedDtoToComplexNamed(
    ComplexNamedDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping ComplexNamedDto -> ComplexNamed when null but no default value provided!');
    }
    final result = ComplexNamed(data: model.datax);
    return result;
  }

  ComplexPositionalReversed?
      _mapComplexPositionalReversedDtoToComplexPositionalReversed(
    ComplexPositionalReversedDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping ComplexPositionalReversedDto -> ComplexPositionalReversed when null but no default value provided!');
    }
    final result = ComplexPositionalReversed(
      model.second,
      model.first,
    );
    return result;
  }

  ComplexNamedReversed? _mapComplexNamedReversedDtoToComplexNamedReversed(
    ComplexNamedReversedDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping ComplexNamedReversedDto -> ComplexNamedReversed when null but no default value provided!');
    }
    final result = ComplexNamedReversed(
      first: model.second,
      second: model.first,
    );
    return result;
  }

  CustomPositional? _mapCustomPositionalDtoToCustomPositional(
    CustomPositionalDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping CustomPositionalDto -> CustomPositional when null but no default value provided!');
    }
    final result = CustomPositional(Mapper.convertToNameAndIdPositional(model));
    return result;
  }

  CustomNamed? _mapCustomNamedDtoToCustomNamed(
    CustomNamedDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping CustomNamedDto -> CustomNamed when null but no default value provided!');
    }
    final result =
        CustomNamed(nameAndId: Mapper.convertToNameAndIdNamed(model));
    return result;
  }
}
