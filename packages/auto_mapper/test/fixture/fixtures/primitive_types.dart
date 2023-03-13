part of '../primitive_types.dart';

// **************************************************************************
// AutoMapperGenerator
// **************************************************************************

class $Mapper {
  Type _typeOf<X>() => X;
  R convert<I, R>(I model) {
    return _convert(model);
  }

  R _convert<I, R>(I model) {
    if ((_typeOf<I>() == _typeOf<NumHolderDto>() ||
            _typeOf<I>() == _typeOf<NumHolderDto?>()) &&
        (_typeOf<R>() == _typeOf<NumHolder>() ||
            _typeOf<R>() == _typeOf<NumHolder?>())) {
      return (_mapNumHolderDtoToNumHolder((model as NumHolderDto)) as R);
    }
    if ((_typeOf<I>() == _typeOf<IntHolderDto>() ||
            _typeOf<I>() == _typeOf<IntHolderDto?>()) &&
        (_typeOf<R>() == _typeOf<IntHolder>() ||
            _typeOf<R>() == _typeOf<IntHolder?>())) {
      return (_mapIntHolderDtoToIntHolder((model as IntHolderDto)) as R);
    }
    if ((_typeOf<I>() == _typeOf<DoubleHolderDto>() ||
            _typeOf<I>() == _typeOf<DoubleHolderDto?>()) &&
        (_typeOf<R>() == _typeOf<DoubleHolder>() ||
            _typeOf<R>() == _typeOf<DoubleHolder?>())) {
      return (_mapDoubleHolderDtoToDoubleHolder((model as DoubleHolderDto))
          as R);
    }
    if ((_typeOf<I>() == _typeOf<StringHolderDto>() ||
            _typeOf<I>() == _typeOf<StringHolderDto?>()) &&
        (_typeOf<R>() == _typeOf<StringHolder>() ||
            _typeOf<R>() == _typeOf<StringHolder?>())) {
      return (_mapStringHolderDtoToStringHolder((model as StringHolderDto))
          as R);
    }
    if ((_typeOf<I>() == _typeOf<BoolHolderDto>() ||
            _typeOf<I>() == _typeOf<BoolHolderDto?>()) &&
        (_typeOf<R>() == _typeOf<BoolHolder>() ||
            _typeOf<R>() == _typeOf<BoolHolder?>())) {
      return (_mapBoolHolderDtoToBoolHolder((model as BoolHolderDto)) as R);
    }
    throw Exception('No mapping from ${model.runtimeType} -> ${_typeOf<R>()}');
  }

  NumHolder _mapNumHolderDtoToNumHolder(NumHolderDto input) {
    final model = input;
    final result = NumHolder(model.value);
    return result;
  }

  IntHolder _mapIntHolderDtoToIntHolder(IntHolderDto input) {
    final model = input;
    final result = IntHolder(model.value);
    return result;
  }

  DoubleHolder _mapDoubleHolderDtoToDoubleHolder(DoubleHolderDto input) {
    final model = input;
    final result = DoubleHolder(model.value);
    return result;
  }

  StringHolder _mapStringHolderDtoToStringHolder(StringHolderDto input) {
    final model = input;
    final result = StringHolder(model.value);
    return result;
  }

  BoolHolder _mapBoolHolderDtoToBoolHolder(BoolHolderDto input) {
    final model = input;
    final result = BoolHolder(model.value);
    return result;
  }
}
