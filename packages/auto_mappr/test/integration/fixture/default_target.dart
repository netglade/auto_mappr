import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'default_target.auto_mappr.dart';

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
    whenSourceIsNull: Mappr.defaultComplexPositionalFunction,
  ),
  MapType<ComplexNamedFunctionDto, ComplexNamedFunction>(
    whenSourceIsNull: Mappr.defaultComplexNamedFunction,
  ),
  MapType<PrimitivePositionalFunctionDto, PrimitivePositionalFunction>(
    whenSourceIsNull: Mappr.defaultPrimitivePositionalFunction,
  ),
  MapType<PrimitiveNamedFunctionDto, PrimitiveNamedFunction>(
    whenSourceIsNull: Mappr.defaultPrimitiveNamedFunction,
  ),
])
class Mappr extends $Mappr {
  static ComplexPositionalFunction defaultComplexPositionalFunction() {
    return const ComplexPositionalFunction(
      99,
      Nested(id: 123, name: 'test qwerty'),
    );
  }

  static ComplexNamedFunction defaultComplexNamedFunction() {
    return const ComplexNamedFunction(
      age: 99,
      name: Nested(id: 123, name: 'test qwerty'),
    );
  }

  static PrimitivePositionalFunction defaultPrimitivePositionalFunction() {
    return const PrimitivePositionalFunction(99, 'bbb');
  }

  static PrimitiveNamedFunction defaultPrimitiveNamedFunction() {
    return const PrimitiveNamedFunction(age: 99, name: 'aaa');
  }
}

// Nested object

class Nested with EquatableMixin {
  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];

  const Nested({required this.id, required this.name});
}

class NestedDto {
  final int id;
  final String name;

  const NestedDto(this.id, {required this.name});
}

// --- Value

// Complex

class ComplexPositionalValue with EquatableMixin {
  final int age;
  final Nested name;

  @override
  List<Object?> get props => [age, name];

  const ComplexPositionalValue(this.age, this.name);
}

class ComplexPositionalValueDto {
  final int age;
  final NestedDto? name;

  const ComplexPositionalValueDto(this.age, this.name);
}

class ComplexNamedValue with EquatableMixin {
  final int age;
  final Nested name;

  @override
  List<Object?> get props => [age, name];

  const ComplexNamedValue({required this.age, required this.name});
}

class ComplexNamedValueDto {
  final int age;
  final NestedDto? name;

  const ComplexNamedValueDto({required this.age, required this.name});
}

// Primitive

class PrimitivePositionalValue with EquatableMixin {
  final int age;
  final String name;

  @override
  List<Object?> get props => [age, name];

  const PrimitivePositionalValue(this.age, this.name);
}

class PrimitivePositionalValueDto {
  final int age;
  final String name;

  const PrimitivePositionalValueDto(this.age, this.name);
}

class PrimitiveNamedValue with EquatableMixin {
  final int age;
  final String name;

  @override
  List<Object?> get props => [age, name];

  const PrimitiveNamedValue({required this.age, required this.name});
}

class PrimitiveNamedValueDto {
  final int age;
  final String name;

  const PrimitiveNamedValueDto({required this.age, required this.name});
}

// --- Function

// Complex

class ComplexPositionalFunction with EquatableMixin {
  final int age;
  final Nested name;

  @override
  List<Object?> get props => [age, name];

  const ComplexPositionalFunction(this.age, this.name);
}

class ComplexPositionalFunctionDto {
  final int age;
  final NestedDto? name;

  const ComplexPositionalFunctionDto(this.age, this.name);
}

class ComplexNamedFunction with EquatableMixin {
  final int age;
  final Nested name;

  @override
  List<Object?> get props => [age, name];

  const ComplexNamedFunction({required this.age, required this.name});
}

class ComplexNamedFunctionDto {
  final int age;
  final NestedDto? name;

  const ComplexNamedFunctionDto({required this.age, required this.name});
}

// Primitive

class PrimitivePositionalFunction with EquatableMixin {
  final int age;
  final String name;

  @override
  List<Object?> get props => [age, name];

  const PrimitivePositionalFunction(this.age, this.name);
}

class PrimitivePositionalFunctionDto {
  final int age;
  final String name;

  const PrimitivePositionalFunctionDto(this.age, this.name);
}

class PrimitiveNamedFunction with EquatableMixin {
  final int age;
  final String name;

  @override
  List<Object?> get props => [age, name];

  const PrimitiveNamedFunction({required this.age, required this.name});
}

class PrimitiveNamedFunctionDto {
  final int age;
  final String name;

  const PrimitiveNamedFunctionDto({required this.age, required this.name});
}
