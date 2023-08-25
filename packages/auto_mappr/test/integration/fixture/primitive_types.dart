// ignore_for_file: avoid_positional_boolean_parameters, prefer-named-boolean-parameters

import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

part 'primitive_types.g.dart';

@AutoMappr([
  MapType<NumHolderDto, NumHolder>(),
  MapType<IntHolderDto, IntHolder>(),
  MapType<DoubleHolderDto, DoubleHolder>(),
  MapType<StringHolderDto, StringHolder>(),
  MapType<BoolHolderDto, BoolHolder>(),
  MapType<EnumHolderDto, EnumHolder>(),
])
class Mappr extends $Mappr {
  const Mappr();
}

class NumHolder {
  final num value;

  const NumHolder(this.value);
}

class NumHolderDto {
  final num value;

  const NumHolderDto(this.value);
}

class IntHolder {
  final int value;

  const IntHolder(this.value);
}

class IntHolderDto {
  final int value;

  const IntHolderDto(this.value);
}

class DoubleHolder {
  final double value;

  const DoubleHolder(this.value);
}

class DoubleHolderDto {
  final double value;

  const DoubleHolderDto(this.value);
}

class StringHolder {
  final String value;

  const StringHolder(this.value);
}

class StringHolderDto {
  final String value;

  const StringHolderDto(this.value);
}

class BoolHolder {
  final bool value;

  const BoolHolder(this.value);
}

class BoolHolderDto {
  final bool value;

  const BoolHolderDto(this.value);
}

enum Enum { alpha, beta, gama }

class EnumHolder {
  final Enum value;

  const EnumHolder(this.value);
}

class EnumHolderDto {
  final Enum value;

  const EnumHolderDto(this.value);
}
