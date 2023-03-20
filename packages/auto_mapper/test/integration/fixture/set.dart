import 'package:auto_mapper_annotation/auto_mapper.dart';
import 'package:equatable/equatable.dart';

part 'set.g.dart';

@AutoMapper([
  MapType<PrimitiveDto, Primitive>(),
  MapType<NestedTagDto, NestedTag>(),
  MapType<NestedDto, Nested>(),
  MapType<ComplexDto, Complex>(),
])
class Mapper extends $Mapper {}

class Primitive extends Equatable {
  final Set<int> value;

  @override
  List<Object?> get props => [value];

  const Primitive(this.value);
}

class PrimitiveDto extends Equatable {
  final Set<int> value;

  @override
  List<Object?> get props => [value];

  const PrimitiveDto(this.value);
}

// nested

class NestedTag extends Equatable {
  bool flag;

  @override
  List<Object?> get props => [flag];

  NestedTag({required this.flag});
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

// complex

class Complex extends Equatable {
  final Set<Nested> value;

  @override
  List<Object?> get props => [value];

  const Complex(this.value);
}

class ComplexDto extends Equatable {
  final Set<NestedDto> value;

  @override
  List<Object?> get props => [value];

  const ComplexDto(this.value);
}
