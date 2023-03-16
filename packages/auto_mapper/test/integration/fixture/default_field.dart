import 'package:auto_mapper_annotation/auto_mapper.dart';
import 'package:equatable/equatable.dart';

part 'default_field.g.dart';

@AutoMapper([
  MapType<NestedDto, Nested>(),
  // value
  MapType<ComplexPositionalValueDto, ComplexPositionalValue>(fields: [
    Field('name', whenNull: Nested(id: 963, name: 'tag test')),
  ]),
  MapType<ComplexNamedValueDto, ComplexNamedValue>(fields: [
    Field('name', whenNull: Nested(id: 492, name: 'tag test 2')),
  ]),
  MapType<PrimitivePositionalValueDto, PrimitivePositionalValue>(fields: [
    Field('name', whenNull: 'test abc'),
  ]),
  MapType<PrimitiveNamedValueDto, PrimitiveNamedValue>(fields: [
    Field('name', whenNull: 'test def'),
  ]),
  // function
  MapType<ComplexPositionalFunctionDto, ComplexPositionalFunction>(fields: [
    Field('name', whenNull: Mapper.defaultNested),
  ]),
  MapType<ComplexNamedFunctionDto, ComplexNamedFunction>(fields: [
    Field('name', whenNull: Mapper.defaultNested),
  ]),
  MapType<PrimitivePositionalFunctionDto, PrimitivePositionalFunction>(fields: [
    Field('name', whenNull: Mapper.defaultString),
  ]),
  MapType<PrimitiveNamedFunctionDto, PrimitiveNamedFunction>(fields: [
    Field('name', whenNull: Mapper.defaultString),
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

  const Nested({required this.id, required this.name});
}

class NestedDto {
  final int id;
  final String name;

  NestedDto(this.id, {required this.name});
}

// --- Value

// Complex

class ComplexPositionalValue extends Equatable {
  final int age;
  final Nested name;

  @override
  List<Object?> get props => [age, name];

  ComplexPositionalValue(this.age, this.name);
}

class ComplexPositionalValueDto {
  final int age;
  final NestedDto? name;

  ComplexPositionalValueDto(this.age, this.name);
}

class ComplexNamedValue extends Equatable {
  final int age;
  final Nested name;

  @override
  List<Object?> get props => [age, name];

  ComplexNamedValue({required this.age, required this.name});
}

class ComplexNamedValueDto {
  final int age;
  final NestedDto? name;

  ComplexNamedValueDto({required this.age, required this.name});
}

// Primitive

class PrimitivePositionalValue extends Equatable {
  final int age;
  final String name;

  @override
  List<Object?> get props => [age, name];

  PrimitivePositionalValue(this.age, this.name);
}

class PrimitivePositionalValueDto {
  final int age;
  final String? name;

  PrimitivePositionalValueDto(this.age, this.name);
}

class PrimitiveNamedValue extends Equatable {
  final int age;
  final String name;

  @override
  List<Object?> get props => [age, name];

  PrimitiveNamedValue({required this.age, required this.name});
}

class PrimitiveNamedValueDto {
  final int age;
  final String? name;

  PrimitiveNamedValueDto({required this.age, required this.name});
}

// --- Function

// Complex

class ComplexPositionalFunction extends Equatable {
  final int age;
  final Nested name;

  @override
  List<Object?> get props => [age, name];

  ComplexPositionalFunction(this.age, this.name);
}

class ComplexPositionalFunctionDto {
  final int age;
  final NestedDto? name;

  ComplexPositionalFunctionDto(this.age, this.name);
}

class ComplexNamedFunction extends Equatable {
  final int age;
  final Nested name;

  @override
  List<Object?> get props => [age, name];

  ComplexNamedFunction({required this.age, required this.name});
}

class ComplexNamedFunctionDto {
  final int age;
  final NestedDto? name;

  ComplexNamedFunctionDto({required this.age, required this.name});
}

// Primitive

class PrimitivePositionalFunction extends Equatable {
  final int age;
  final String name;

  @override
  List<Object?> get props => [age, name];

  PrimitivePositionalFunction(this.age, this.name);
}

class PrimitivePositionalFunctionDto {
  final int age;
  final String? name;

  PrimitivePositionalFunctionDto(this.age, this.name);
}

class PrimitiveNamedFunction extends Equatable {
  final int age;
  final String name;

  @override
  List<Object?> get props => [age, name];

  PrimitiveNamedFunction({required this.age, required this.name});
}

class PrimitiveNamedFunctionDto {
  final int age;
  final String? name;

  PrimitiveNamedFunctionDto({required this.age, required this.name});
}
