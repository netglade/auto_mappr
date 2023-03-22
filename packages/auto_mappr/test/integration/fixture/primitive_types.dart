// ignore_for_file:avoid_positional_boolean_parameters

import 'package:auto_mappr_annotation/auto_mappr.dart';

part 'primitive_types.g.dart';

@AutoMappr([
  MapType<NumHolderDto, NumHolder>(),
  MapType<IntHolderDto, IntHolder>(),
  MapType<DoubleHolderDto, DoubleHolder>(),
  MapType<StringHolderDto, StringHolder>(),
  MapType<BoolHolderDto, BoolHolder>(),
  MapType<EnumHolderDto, EnumHolder>(),
])
class Mapper extends $Mapper {}

class NumHolder {
  final num value;

  NumHolder(this.value);
}

class NumHolderDto {
  final num value;

  NumHolderDto(this.value);
}

class IntHolder {
  final int value;

  IntHolder(this.value);
}

class IntHolderDto {
  final int value;

  IntHolderDto(this.value);
}

class DoubleHolder {
  final double value;

  DoubleHolder(this.value);
}

class DoubleHolderDto {
  final double value;

  DoubleHolderDto(this.value);
}

class StringHolder {
  final String value;

  StringHolder(this.value);
}

class StringHolderDto {
  final String value;

  StringHolderDto(this.value);
}

class BoolHolder {
  final bool value;

  BoolHolder(this.value);
}

class BoolHolderDto {
  final bool value;

  BoolHolderDto(this.value);
}

enum Enum { alpha, beta, gama }

class EnumHolder {
  final Enum value;

  EnumHolder(this.value);
}

class EnumHolderDto {
  final Enum value;

  EnumHolderDto(this.value);
}
