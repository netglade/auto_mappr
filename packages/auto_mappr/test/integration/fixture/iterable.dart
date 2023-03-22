import 'package:auto_mappr_annotation/auto_mappr.dart';
import 'package:equatable/equatable.dart';

part 'iterable.g.dart';

@AutoMappr([
  MapType<NestedTagDto, NestedTag>(),
  MapType<NestedDto, Nested>(),
  // primitive
  MapType<PrimitiveDto, Primitive>(),
  MapType<PrimitiveNullableDto, Primitive>(),
  // complex
  MapType<ComplexDto, Complex>(),
  MapType<ComplexNullableDto, Complex>(),
])
class Mapper extends $Mapper {}

class NestedTag extends Equatable {
  final bool flag;

  @override
  List<Object?> get props => [flag];

  const NestedTag({required this.flag});
}

class NestedTagDto {
  bool flag;

  NestedTagDto({required this.flag});
}

class Nested extends Equatable {
  final int id;
  final String name;
  final NestedTag tag;

  @override
  List<Object?> get props => [id, name, tag];

  const Nested({
    required this.id,
    required this.name,
    required this.tag,
  });
}

class NestedDto {
  final int id;
  final String name;
  final NestedTagDto tag;

  NestedDto(
    this.id, {
    required this.name,
    required this.tag,
  });
}

// primitive

class Primitive extends Equatable {
  final Iterable<int> value;

  @override
  List<Object?> get props => [value];

  const Primitive(this.value);
}

class PrimitiveDto extends Equatable {
  final Iterable<int> value;

  @override
  List<Object?> get props => [value];

  const PrimitiveDto(this.value);
}

class PrimitiveNullableDto extends Equatable {
  final Iterable<int?> value;

  @override
  List<Object?> get props => [value];

  const PrimitiveNullableDto(this.value);
}

// complex

class Complex extends Equatable {
  final Iterable<Nested> value;

  @override
  List<Object?> get props => [value];

  const Complex(this.value);
}

class ComplexDto extends Equatable {
  final Iterable<NestedDto> value;

  @override
  List<Object?> get props => [value];

  const ComplexDto(this.value);
}

class ComplexNullableDto extends Equatable {
  final Iterable<NestedDto?> value;

  @override
  List<Object?> get props => [value];

  const ComplexNullableDto(this.value);
}