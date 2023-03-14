import 'package:auto_mapper_annotation/auto_mapper.dart';
import 'package:equatable/equatable.dart';

part 'when_null_default.g.dart';

@AutoMapper(mappers: [
  AutoMap<NestedDto, Nested>(),
  AutoMap<ComplexPositionalDto, ComplexPositional>(mappings: [
    MapMember(member: 'name', whenNullDefault: Mapper.defaultNested),
  ]),
  AutoMap<ComplexNamedDto, ComplexNamed>(mappings: [
    MapMember(member: 'name', whenNullDefault: Mapper.defaultNested),
  ]),
  AutoMap<PrimitivePositionalDto, PrimitivePositional>(mappings: [
    MapMember(member: 'name', whenNullDefault: Mapper.defaultString),
  ]),
  AutoMap<PrimitiveNamedDto, PrimitiveNamed>(mappings: [
    MapMember(member: 'name', whenNullDefault: Mapper.defaultString),
  ]),
])
class Mapper extends $Mapper {
  static Nested defaultNested() => Nested(id: 1, name: 'default_TAG');
  static String defaultString() => 'Test123';
}

// Nested object

class Nested extends Equatable {
  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];

  Nested({required this.id, required this.name});
}

class NestedDto {
  final int id;
  final String name;

  NestedDto(this.id, {required this.name});
}

// Complex

class ComplexPositional extends Equatable {
  final int age;
  final Nested name;

  @override
  List<Object?> get props => [age, name];

  ComplexPositional(this.age, this.name);
}

class ComplexPositionalDto {
  final int age;
  final NestedDto? name;

  ComplexPositionalDto(this.age, this.name);
}

class ComplexNamed extends Equatable {
  final int age;
  final Nested name;

  @override
  List<Object?> get props => [age, name];

  ComplexNamed({required this.age, required this.name});
}

class ComplexNamedDto {
  final int age;
  final NestedDto? name;

  ComplexNamedDto({required this.age, required this.name});
}

// Primitive

class PrimitivePositional extends Equatable {
  final int age;
  final String name;

  @override
  List<Object?> get props => [age, name];

  PrimitivePositional(this.age, this.name);
}

class PrimitivePositionalDto {
  final int age;
  final String? name;

  PrimitivePositionalDto(this.age, this.name);
}

class PrimitiveNamed extends Equatable {
  final int age;
  final String name;

  @override
  List<Object?> get props => [age, name];

  PrimitiveNamed({required this.age, required this.name});
}

class PrimitiveNamedDto {
  final int age;
  final String? name;

  PrimitiveNamedDto({required this.age, required this.name});
}
