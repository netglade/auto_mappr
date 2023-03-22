import 'package:auto_mappr_annotation/auto_mappr.dart';
import 'package:equatable/equatable.dart';

part 'rename.g.dart';

@AutoMappr([
  // nested
  MapType<NestedDto, Nested>(
    fields: [
      Field('id', from: 'idx'),
      Field('name', from: 'namex'),
    ],
  ),
  MapType<NestedReversedDto, NestedReversed>(
    fields: [
      Field('id', from: 'namex'),
      Field('name', from: 'idx'),
    ],
  ),
  // same
  MapType<SamePositionalDto, SamePositional>(
    fields: [
      Field('id', from: 'id'),
      Field('name', from: 'name'),
    ],
  ),
  MapType<SameNamedDto, SameNamed>(
    fields: [
      Field('id', from: 'id'),
      Field('name', from: 'name'),
    ],
  ),
  // primitive
  MapType<PrimitivePositionalDto, PrimitivePositional>(
    fields: [
      Field('id', from: 'idx'),
    ],
  ),
  MapType<PrimitiveNamedDto, PrimitiveNamed>(
    fields: [
      Field('id', from: 'idx'),
    ],
  ),
  // primitive reversed
  MapType<PrimitivePositionalReversedDto, PrimitivePositionalReversed>(
    fields: [
      Field('alpha', from: 'beta'),
      Field('beta', from: 'alpha'),
    ],
  ),
  MapType<PrimitiveNamedReversedDto, PrimitiveNamedReversed>(
    fields: [
      Field('alpha', from: 'beta'),
      Field('beta', from: 'alpha'),
    ],
  ),
  // complex
  MapType<ComplexPositionalDto, ComplexPositional>(
    fields: [
      Field('data', from: 'datax'),
    ],
  ),
  MapType<ComplexNamedDto, ComplexNamed>(
    fields: [
      Field('data', from: 'datax'),
    ],
  ),
  // complex reversed
  MapType<ComplexPositionalReversedDto, ComplexPositionalReversed>(
    fields: [
      Field('first', from: 'second'),
      Field('second', from: 'first'),
    ],
  ),
  MapType<ComplexNamedReversedDto, ComplexNamedReversed>(
    fields: [
      Field('first', from: 'second'),
      Field('second', from: 'first'),
    ],
  ),
  // custom
  MapType<CustomPositionalDto, CustomPositional>(
    fields: [
      Field.custom('nameAndId', custom: Mapper.convertToNameAndIdPositional),
    ],
  ),
  MapType<CustomNamedDto, CustomNamed>(
    fields: [
      Field.custom('nameAndId', custom: Mapper.convertToNameAndIdNamed),
    ],
  ),
])
class Mapper extends $Mapper {
  static String convertToNameAndIdPositional(CustomPositionalDto? dto) => '${dto?.name} #${dto?.id}';

  static String convertToNameAndIdNamed(CustomNamedDto? dto) => '${dto?.name} #${dto?.id}';
}

// same

class SamePositional extends Equatable {
  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];

  const SamePositional(
    this.id,
    this.name,
  );
}

class SamePositionalDto {
  final int id;
  final String name;

  const SamePositionalDto(
    this.id,
    this.name,
  );
}

class SameNamed extends Equatable {
  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];

  const SameNamed({
    required this.id,
    required this.name,
  });
}

class SameNamedDto {
  final int id;
  final String name;

  const SameNamedDto({
    required this.id,
    required this.name,
  });
}

// primitive

class PrimitivePositional extends Equatable {
  final int id;

  @override
  List<Object?> get props => [id];

  const PrimitivePositional(
    this.id,
  );
}

class PrimitivePositionalDto {
  final int idx;

  PrimitivePositionalDto(
    this.idx,
  );
}

class PrimitiveNamed extends Equatable {
  final int id;

  @override
  List<Object?> get props => [id];

  const PrimitiveNamed({
    required this.id,
  });
}

class PrimitiveNamedDto {
  final int idx;

  PrimitiveNamedDto({
    required this.idx,
  });
}

// primitive reversed

class PrimitivePositionalReversed extends Equatable {
  final int alpha;
  final String beta;

  @override
  List<Object?> get props => [alpha, beta];

  const PrimitivePositionalReversed(
    this.alpha,
    this.beta,
  );
}

class PrimitivePositionalReversedDto {
  final int beta;
  final String alpha;

  PrimitivePositionalReversedDto(
    this.alpha,
    this.beta,
  );
}

class PrimitiveNamedReversed extends Equatable {
  final int alpha;
  final String beta;

  @override
  List<Object?> get props => [alpha, beta];

  const PrimitiveNamedReversed({
    required this.alpha,
    required this.beta,
  });
}

class PrimitiveNamedReversedDto {
  final int beta;
  final String alpha;

  PrimitiveNamedReversedDto({
    required this.alpha,
    required this.beta,
  });
}

// complex

class Nested extends Equatable {
  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];

  const Nested({required this.id, required this.name});
}

class NestedDto {
  final int idx;

  final String namex;

  NestedDto(this.idx, {required this.namex});
}

class ComplexPositional extends Equatable {
  final Nested data;

  @override
  List<Object?> get props => [data];

  const ComplexPositional(
    this.data,
  );
}

class ComplexPositionalDto {
  final NestedDto datax;

  ComplexPositionalDto(
    this.datax,
  );
}

class ComplexNamed extends Equatable {
  final Nested data;

  @override
  List<Object?> get props => [data];

  const ComplexNamed({
    required this.data,
  });
}

class ComplexNamedDto {
  final NestedDto datax;

  ComplexNamedDto({
    required this.datax,
  });
}

// complex reversed

class NestedReversed extends Equatable {
  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];

  const NestedReversed({required this.id, required this.name});
}

class NestedReversedDto {
  final int namex;
  final String idx;

  NestedReversedDto(this.idx, {required this.namex});
}

class ComplexPositionalReversed extends Equatable {
  final int first;
  final NestedReversed second;

  @override
  List<Object?> get props => [first, second];

  const ComplexPositionalReversed(
    this.first,
    this.second,
  );
}

class ComplexPositionalReversedDto {
  final int second;
  final NestedReversedDto first;

  ComplexPositionalReversedDto(
    this.first,
    this.second,
  );
}

class ComplexNamedReversed extends Equatable {
  final int first;
  final NestedReversed second;

  @override
  List<Object?> get props => [first, second];

  const ComplexNamedReversed({
    required this.first,
    required this.second,
  });
}

class ComplexNamedReversedDto {
  final int second;
  final NestedReversedDto first;

  ComplexNamedReversedDto({
    required this.first,
    required this.second,
  });
}

// custom

class CustomPositional extends Equatable {
  final String nameAndId;

  @override
  List<Object?> get props => [nameAndId];

  const CustomPositional(
    this.nameAndId,
  );
}

class CustomPositionalDto {
  final int id;
  final String name;

  const CustomPositionalDto(
    this.id,
    this.name,
  );
}

class CustomNamed extends Equatable {
  final String nameAndId;

  @override
  List<Object?> get props => [nameAndId];

  const CustomNamed({
    required this.nameAndId,
  });
}

class CustomNamedDto {
  final int id;
  final String name;

  const CustomNamedDto({
    required this.id,
    required this.name,
  });
}
