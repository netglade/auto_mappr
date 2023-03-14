import 'package:auto_mapper_annotation/auto_mapper.dart';
import 'package:equatable/equatable.dart';

part 'rename.g.dart';

@AutoMapper(mappers: [
  // nested
  AutoMap<NestedDto, Nested>(
    mappings: [
      MapMember(member: 'id', from: 'idx'),
      MapMember(member: 'name', from: 'namex'),
    ],
  ),
  AutoMap<NestedReversedDto, NestedReversed>(
    mappings: [
      MapMember(member: 'id', from: 'namex'),
      MapMember(member: 'name', from: 'idx'),
    ],
  ),
  // same
  AutoMap<SamePositionalDto, SamePositional>(
    mappings: [
      MapMember(member: 'id', from: 'id'),
      MapMember(member: 'name', from: 'name'),
    ],
  ),
  AutoMap<SameNamedDto, SameNamed>(
    mappings: [
      MapMember(member: 'id', from: 'id'),
      MapMember(member: 'name', from: 'name'),
    ],
  ),
  // primitive
  AutoMap<PrimitivePositionalDto, PrimitivePositional>(
    mappings: [
      MapMember(member: 'id', from: 'idx'),
    ],
  ),
  AutoMap<PrimitiveNamedDto, PrimitiveNamed>(
    mappings: [
      MapMember(member: 'id', from: 'idx'),
    ],
  ),
  // primitive reversed
  AutoMap<PrimitivePositionalReversedDto, PrimitivePositionalReversed>(
    mappings: [
      MapMember(member: 'alpha', from: 'beta'),
      MapMember(member: 'beta', from: 'alpha'),
    ],
  ),
  AutoMap<PrimitiveNamedReversedDto, PrimitiveNamedReversed>(
    mappings: [
      MapMember(member: 'alpha', from: 'beta'),
      MapMember(member: 'beta', from: 'alpha'),
    ],
  ),
  // complex
  AutoMap<ComplexPositionalDto, ComplexPositional>(
    mappings: [
      MapMember(member: 'data', from: 'datax'),
    ],
  ),
  AutoMap<ComplexNamedDto, ComplexNamed>(
    mappings: [
      MapMember(member: 'data', from: 'datax'),
    ],
  ),
  // complex reversed
  AutoMap<ComplexPositionalReversedDto, ComplexPositionalReversed>(
    mappings: [
      MapMember(member: 'first', from: 'second'),
      MapMember(member: 'second', from: 'first'),
    ],
  ),
  AutoMap<ComplexNamedReversedDto, ComplexNamedReversed>(
    mappings: [
      MapMember(member: 'first', from: 'second'),
      MapMember(member: 'second', from: 'first'),
    ],
  ),
  // custom
  AutoMap<CustomPositionalDto, CustomPositional>(
    mappings: [
      MapMember(member: 'nameAndId', custom: Mapper.convertToNameAndIdPositional),
    ],
  ),
  AutoMap<CustomNamedDto, CustomNamed>(
    mappings: [
      MapMember(member: 'nameAndId', custom: Mapper.convertToNameAndIdNamed),
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

  Nested({required this.id, required this.name});
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

  NestedReversed({required this.id, required this.name});
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

class CustomPositionalDto extends Equatable {
  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];

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

class CustomNamedDto extends Equatable {
  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];

  const CustomNamedDto({
    required this.id,
    required this.name,
  });
}
