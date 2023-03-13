// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debug.dart';

// **************************************************************************
// AutoMapperGenerator
// **************************************************************************

class $Mapper {
  Type _typeOf<X>() => X;
  R convert<I, R>(I model) {
    return _convert(model, canReturnNull: false);
  }

  R _convert<I, R>(
    I model, {
    bool canReturnNull = false,
  }) {
    if ((_typeOf<I>() == _typeOf<NestedDto>() ||
            _typeOf<I>() == _typeOf<NestedDto?>()) &&
        (_typeOf<R>() == _typeOf<Nested>() ||
            _typeOf<R>() == _typeOf<Nested?>())) {
      return (_mapNestedDtoToNested(
        (model as NestedDto?),
        canReturnNull: canReturnNull,
      ) as R);
    }
    if ((_typeOf<I>() == _typeOf<ComplexPositionalDto>() ||
            _typeOf<I>() == _typeOf<ComplexPositionalDto?>()) &&
        (_typeOf<R>() == _typeOf<ComplexPositional>() ||
            _typeOf<R>() == _typeOf<ComplexPositional?>())) {
      return (_mapComplexPositionalDtoToComplexPositional(
        (model as ComplexPositionalDto?),
        canReturnNull: canReturnNull,
      ) as R);
    }
    if ((_typeOf<I>() == _typeOf<ComplexNamedDto>() ||
            _typeOf<I>() == _typeOf<ComplexNamedDto?>()) &&
        (_typeOf<R>() == _typeOf<ComplexNamed>() ||
            _typeOf<R>() == _typeOf<ComplexNamed?>())) {
      return (_mapComplexNamedDtoToComplexNamed(
        (model as ComplexNamedDto?),
        canReturnNull: canReturnNull,
      ) as R);
    }
    if ((_typeOf<I>() == _typeOf<PrimitivePositionalDto>() ||
            _typeOf<I>() == _typeOf<PrimitivePositionalDto?>()) &&
        (_typeOf<R>() == _typeOf<PrimitivePositional>() ||
            _typeOf<R>() == _typeOf<PrimitivePositional?>())) {
      return (_mapPrimitivePositionalDtoToPrimitivePositional(
        (model as PrimitivePositionalDto?),
        canReturnNull: canReturnNull,
      ) as R);
    }
    if ((_typeOf<I>() == _typeOf<PrimitiveNamedDto>() ||
            _typeOf<I>() == _typeOf<PrimitiveNamedDto?>()) &&
        (_typeOf<R>() == _typeOf<PrimitiveNamed>() ||
            _typeOf<R>() == _typeOf<PrimitiveNamed?>())) {
      return (_mapPrimitiveNamedDtoToPrimitiveNamed(
        (model as PrimitiveNamedDto?),
        canReturnNull: canReturnNull,
      ) as R);
    }
    throw Exception('No mapping from ${model.runtimeType} -> ${_typeOf<R>()}');
  }

  Nested? _mapNestedDtoToNested(
    NestedDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping NestedDto -> Nested when null but no default value provided!');
    }
    final result = Nested(
      id: model.id,
      name: model.name,
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
    final result = ComplexPositional(
      model.age,
      model.name == null
          ? Mapper.defaultNested()
          : _convert(
              model.name,
              canReturnNull: false,
            ),
    );
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
    final result = ComplexNamed(
      age: model.age,
      name: model.name == null
          ? Mapper.defaultNested()
          : _convert(
              model.name,
              canReturnNull: false,
            ),
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
    final result = PrimitivePositional(
      model.age,
      model.name ?? Mapper.defaultString(),
    );
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
    final result = PrimitiveNamed(
      age: model.age,
      name: model.name ?? Mapper.defaultString(),
    );
    return result;
  }
}
