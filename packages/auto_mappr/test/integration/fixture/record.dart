// ignore_for_file: move-records-to-typedefs

import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

part 'record.g.dart';

// TODO(records)
// @AutoMappr([
//   // simple
//   MapType<PositionalDto, Positional>(),
//   MapType<PositionalNullableDto, PositionalNullable>(),
//   MapType<PositionalDto, PositionalNullable>(),
//   // MapType<PositionalNullableDto, Positional>(), // TODO
//   MapType<NamedDto, Named>(),
//   // complex
//   // MapType<ComplexDto, Complex>(),
//   // MapType<ComplexNullableDto, Complex>(),
// ])
// class Mappr extends $Mappr {
//   const Mappr();
// }

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
  final (int?, bool?, String?) value;

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

class NamedDto extends Equatable {
  final ({int alpha, bool beta, String gama}) value;

  @override
  List<Object?> get props => [value];

  const NamedDto(this.value);
}

// complex

// class Complex extends Equatable {
//   final Iterable<Nested> value;

//   @override
//   List<Object?> get props => [value];

//   const Complex(this.value);
// }

// class ComplexDto extends Equatable {
//   final Iterable<NestedDto> value;

//   @override
//   List<Object?> get props => [value];

//   const ComplexDto(this.value);
// }

// class ComplexNullableDto extends Equatable {
//   final Iterable<NestedDto?> value;

//   @override
//   List<Object?> get props => [value];

//   const ComplexNullableDto(this.value);
// }

// // List, Set, Iterable

// class ListHolder extends Equatable {
//   final List<int> value;

//   @override
//   List<Object?> get props => [value];

//   const ListHolder(this.value);
// }

// class SetHolder extends Equatable {
//   final Set<int> value;

//   @override
//   List<Object?> get props => [value];

//   const SetHolder(this.value);
// }

// class IterableHolder extends Equatable {
//   final Iterable<int> value;

//   @override
//   List<Object?> get props => [value];

//   const IterableHolder(this.value);
// }
