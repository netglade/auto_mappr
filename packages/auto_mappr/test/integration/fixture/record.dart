// ignore_for_file: move-records-to-typedefs

import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'record.auto_mappr.dart';

@AutoMappr([
  // simple
  MapType<PositionalDto, Positional>(),
  MapType<PositionalNullableDto, PositionalNullable>(),
  MapType<PositionalDto, PositionalNullable>(),
  MapType<NamedDto, Named>(),
  MapType<NamedDto, NamedNullable>(),
  // complex
  MapType<ComplexPositionalDto, ComplexPositional>(),
  MapType<ComplexNamedDto, ComplexNamed>(),
])
class Mappr extends $Mappr {
  const Mappr();
}

// positional

class Positional extends Equatable {
  final (int, bool, String) value;

  @override
  List<Object?> get props => [value];

  const Positional(this.value);
}

class PositionalDto extends Equatable {
  final (int, bool, String) value;

  @override
  List<Object?> get props => [value];

  const PositionalDto(this.value);
}

class PositionalNullable extends Equatable {
  final (int?, bool?, String?, int?, bool?) value;

  @override
  List<Object?> get props => [value];

  const PositionalNullable(this.value);
}

class PositionalNullableDto extends Equatable {
  final (int?, bool?, String?) value;

  @override
  List<Object?> get props => [value];

  const PositionalNullableDto(this.value);
}

class Named extends Equatable {
  final ({int alpha, bool beta, String gama}) value;

  @override
  List<Object?> get props => [value];

  const Named(this.value);
}

class NamedNullable extends Equatable {
  // ignore: record-fields-ordering, greek alphabet
  final ({int alpha, bool beta, String gama, int? delta, bool? epsilon}) value;

  @override
  List<Object?> get props => [value];

  const NamedNullable(this.value);
}

class NamedDto extends Equatable {
  final ({int alpha, bool beta, String gama}) value;

  @override
  List<Object?> get props => [value];

  const NamedDto(this.value);
}

// complex

class ComplexPositional extends Equatable {
  final List<Positional> value;

  @override
  List<Object?> get props => [value];

  const ComplexPositional(this.value);
}

class ComplexPositionalDto extends Equatable {
  final List<PositionalDto> value;

  @override
  List<Object?> get props => [value];

  const ComplexPositionalDto(this.value);
}

class ComplexNamed extends Equatable {
  final List<Named> value;

  @override
  List<Object?> get props => [value];

  const ComplexNamed(this.value);
}

class ComplexNamedDto extends Equatable {
  final List<NamedDto> value;

  @override
  List<Object?> get props => [value];

  const ComplexNamedDto(this.value);
}
