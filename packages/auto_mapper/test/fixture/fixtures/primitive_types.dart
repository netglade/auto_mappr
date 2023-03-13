part of '../primitive_types.dart';

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
    if ((_typeOf<I>() == _typeOf<NumHolderDto>() ||
            _typeOf<I>() == _typeOf<NumHolderDto?>()) &&
        (_typeOf<R>() == _typeOf<NumHolder>() ||
            _typeOf<R>() == _typeOf<NumHolder?>())) {
      return (_mapNumHolderDtoToNumHolder(
        (model as NumHolderDto?),
        canReturnNull: canReturnNull,
      ) as R);
    }
    if ((_typeOf<I>() == _typeOf<IntHolderDto>() ||
            _typeOf<I>() == _typeOf<IntHolderDto?>()) &&
        (_typeOf<R>() == _typeOf<IntHolder>() ||
            _typeOf<R>() == _typeOf<IntHolder?>())) {
      return (_mapIntHolderDtoToIntHolder(
        (model as IntHolderDto?),
        canReturnNull: canReturnNull,
      ) as R);
    }
    if ((_typeOf<I>() == _typeOf<DoubleHolderDto>() ||
            _typeOf<I>() == _typeOf<DoubleHolderDto?>()) &&
        (_typeOf<R>() == _typeOf<DoubleHolder>() ||
            _typeOf<R>() == _typeOf<DoubleHolder?>())) {
      return (_mapDoubleHolderDtoToDoubleHolder(
        (model as DoubleHolderDto?),
        canReturnNull: canReturnNull,
      ) as R);
    }
    if ((_typeOf<I>() == _typeOf<StringHolderDto>() ||
            _typeOf<I>() == _typeOf<StringHolderDto?>()) &&
        (_typeOf<R>() == _typeOf<StringHolder>() ||
            _typeOf<R>() == _typeOf<StringHolder?>())) {
      return (_mapStringHolderDtoToStringHolder(
        (model as StringHolderDto?),
        canReturnNull: canReturnNull,
      ) as R);
    }
    if ((_typeOf<I>() == _typeOf<BoolHolderDto>() ||
            _typeOf<I>() == _typeOf<BoolHolderDto?>()) &&
        (_typeOf<R>() == _typeOf<BoolHolder>() ||
            _typeOf<R>() == _typeOf<BoolHolder?>())) {
      return (_mapBoolHolderDtoToBoolHolder(
        (model as BoolHolderDto?),
        canReturnNull: canReturnNull,
      ) as R);
    }
    if ((_typeOf<I>() == _typeOf<EnumHolderDto>() ||
            _typeOf<I>() == _typeOf<EnumHolderDto?>()) &&
        (_typeOf<R>() == _typeOf<EnumHolder>() ||
            _typeOf<R>() == _typeOf<EnumHolder?>())) {
      return (_mapEnumHolderDtoToEnumHolder(
        (model as EnumHolderDto?),
        canReturnNull: canReturnNull,
      ) as R);
    }
    throw Exception('No mapping from ${model.runtimeType} -> ${_typeOf<R>()}');
  }

  NumHolder? _mapNumHolderDtoToNumHolder(
    NumHolderDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping NumHolderDto -> NumHolder when null but no default value provided!');
    }
    final result = NumHolder(model.value);
    return result;
  }

  IntHolder? _mapIntHolderDtoToIntHolder(
    IntHolderDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping IntHolderDto -> IntHolder when null but no default value provided!');
    }
    final result = IntHolder(model.value);
    return result;
  }

  DoubleHolder? _mapDoubleHolderDtoToDoubleHolder(
    DoubleHolderDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping DoubleHolderDto -> DoubleHolder when null but no default value provided!');
    }
    final result = DoubleHolder(model.value);
    return result;
  }

  StringHolder? _mapStringHolderDtoToStringHolder(
    StringHolderDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping StringHolderDto -> StringHolder when null but no default value provided!');
    }
    final result = StringHolder(model.value);
    return result;
  }

  BoolHolder? _mapBoolHolderDtoToBoolHolder(
    BoolHolderDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping BoolHolderDto -> BoolHolder when null but no default value provided!');
    }
    final result = BoolHolder(model.value);
    return result;
  }

  EnumHolder? _mapEnumHolderDtoToEnumHolder(
    EnumHolderDto? input, {
    required bool canReturnNull,
  }) {
    final model = input;
    if (model == null) {
      return canReturnNull
          ? null
          : throw Exception(
              'Mapping EnumHolderDto -> EnumHolder when null but no default value provided!');
    }
    final result = EnumHolder(model.value);
    return result;
  }
}
