import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'primary_constructor.auto_mappr.dart';

@AutoMappr([
  MapType<PositionalDto, PositionalTarget>(),
  MapType<NamedDto, NamedTarget>(),
  MapType<NamedDto, NamedConstructorTarget>(),
  MapType<PositionalDto, MutableTarget>(),
  MapType<PositionalDto, NonDeclaringParameterTarget>(fields: [Field('b', from: 'b')]),
  MapType<EmployeeDto, Employee>(),
  MapType<PositionalDto, ClassicTarget>(),
  MapType<PositionalDto, SecondaryConstructorTarget>(constructor: 'secondary'),
  MapType<RemoteStatus, LocalStatus>(whenSourceIsNull: LocalStatus.unknown),
])
class Mappr extends $Mappr {
  const Mappr();
}

// Sources declared with primary constructors.

class const PositionalDto(final int a, final int b, final int c);

class const NamedDto({required final String name, required final int age, final String? nickname});

class const EmployeeDto(final String name, final int age, final String role);

enum RemoteStatus(final String code) {
  active('A'),
  archived('X'),
  inactive('I'),
}

// Targets declared with primary constructors.

class const PositionalTarget(final int a, final int b, final int c) with Equatable {
  @override
  List<Object?> get props => [a, b, c];
}

class const NamedTarget({required final String name, required final int age, final String? nickname}) with Equatable {
  @override
  List<Object?> get props => [name, age, nickname];
}

class const NamedConstructorTarget.create({required final String name, required final int age}) with Equatable {
  @override
  List<Object?> get props => [name, age];
}

// `var` declaring parameters induce mutable fields; `c` is not a constructor parameter and is set through its setter.
class MutableTarget(var int a, var int b) {
  int? c;
}

// `b` is a non-declaring parameter: it induces no field, so it has to be mapped explicitly with `Field.from`.
class NonDeclaringParameterTarget(final int a, int b) with Equatable {
  final int doubled = b * 2;

  @override
  List<Object?> get props => [a, doubled];

  this : assert(a >= 0, 'a must not be negative');
}

class const Person(final String name, final int age);

class const Employee(super.name, super.age, final String role) extends Person with Equatable {
  @override
  List<Object?> get props => [name, age, role];
}

class ClassicTarget with Equatable {
  final int a;
  final int b;

  @override
  List<Object?> get props => [a, b];

  const ClassicTarget(this.a, this.b);
}

class const SecondaryConstructorTarget(final int a, final int b, final int c) with Equatable {
  @override
  List<Object?> get props => [a, b, c];

  const SecondaryConstructorTarget.secondary(int a) : this(a, -1, -1);
}

enum LocalStatus(final String code) {
  active('a'),
  inactive('i'),
  unknown('?'),
}
