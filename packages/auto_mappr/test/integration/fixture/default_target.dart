import 'package:auto_mappr_annotation/auto_mappr.dart';
import 'package:equatable/equatable.dart';

part 'default_target.g.dart';

@AutoMappr([
  MapType<NestedDto, Nested>(),
  // value
  MapType<ComplexPositionalValueDto, ComplexPositionalValue>(
    whenSourceIsNull: ComplexPositionalValue(99, Nested(id: 123, name: 'test qwerty')),
  ),
  MapType<ComplexNamedValueDto, ComplexNamedValue>(
    whenSourceIsNull: ComplexNamedValue(age: 4567, name: Nested(id: 12, name: 'mko')),
  ),
  MapType<PrimitivePositionalValueDto, PrimitivePositionalValue>(
    whenSourceIsNull: PrimitivePositionalValue(99, 'xyx'),
  ),
  MapType<PrimitiveNamedValueDto, PrimitiveNamedValue>(
    whenSourceIsNull: PrimitiveNamedValue(age: 99, name: 'xyx'),
  ),
  // function
  MapType<ComplexPositionalFunctionDto, ComplexPositionalFunction>(
    whenSourceIsNull: Mapper.defaultComplexPositionalFunction,
  ),
  MapType<ComplexNamedFunctionDto, ComplexNamedFunction>(
    whenSourceIsNull: Mapper.defaultComplexNamedFunction,
  ),
  MapType<PrimitivePositionalFunctionDto, PrimitivePositionalFunction>(
    whenSourceIsNull: Mapper.defaultPrimitivePositionalFunction,
  ),
  MapType<PrimitiveNamedFunctionDto, PrimitiveNamedFunction>(
    whenSourceIsNull: Mapper.defaultPrimitiveNamedFunction,
  ),
])
class Mapper extends $Mapper {
  static ComplexPositionalFunction defaultComplexPositionalFunction() {
    return const ComplexPositionalFunction(99, Nested(id: 123, name: 'test qwerty'));
  }

  static ComplexNamedFunction defaultComplexNamedFunction() {
    return const ComplexNamedFunction(age: 99, name: Nested(id: 123, name: 'test qwerty'));
  }

  static PrimitivePositionalFunction defaultPrimitivePositionalFunction() {
    return const PrimitivePositionalFunction(99, 'bbb');
  }

  static PrimitiveNamedFunction defaultPrimitiveNamedFunction() {
    return const PrimitiveNamedFunction(age: 99, name: 'aaa');
  }
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

  const ComplexPositionalValue(this.age, this.name);
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

  const ComplexNamedValue({required this.age, required this.name});
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

  const PrimitivePositionalValue(this.age, this.name);
}

class PrimitivePositionalValueDto {
  final int age;
  final String name;

  PrimitivePositionalValueDto(this.age, this.name);
}

class PrimitiveNamedValue extends Equatable {
  final int age;
  final String name;

  @override
  List<Object?> get props => [age, name];

  const PrimitiveNamedValue({required this.age, required this.name});
}

class PrimitiveNamedValueDto {
  final int age;
  final String name;

  PrimitiveNamedValueDto({required this.age, required this.name});
}

// --- Function

// Complex

class ComplexPositionalFunction extends Equatable {
  final int age;
  final Nested name;

  @override
  List<Object?> get props => [age, name];

  const ComplexPositionalFunction(this.age, this.name);
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

  const ComplexNamedFunction({required this.age, required this.name});
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

  const PrimitivePositionalFunction(this.age, this.name);
}

class PrimitivePositionalFunctionDto {
  final int age;
  final String name;

  PrimitivePositionalFunctionDto(this.age, this.name);
}

class PrimitiveNamedFunction extends Equatable {
  final int age;
  final String name;

  @override
  List<Object?> get props => [age, name];

  const PrimitiveNamedFunction({required this.age, required this.name});
}

class PrimitiveNamedFunctionDto {
  final int age;
  final String name;

  PrimitiveNamedFunctionDto({required this.age, required this.name});
}
