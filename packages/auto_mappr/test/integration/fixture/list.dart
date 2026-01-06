import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'list.auto_mappr.dart';

@AutoMappr([
  MapType<NestedTagDto, NestedTag>(),
  MapType<NestedDto, Nested>(),
  MapType<PrimitiveDto, Primitive>(),
  MapType<PrimitiveNullableDto, Primitive>(),
  MapType<ComplexDto, Complex>(),
  MapType<ComplexNullableDto, Complex>(),
  MapType<ComplexDtoWithNullList, ComplexWithNullList>(),
])
class Mappr extends $Mappr {
  const Mappr();
}

class NestedTag with EquatableMixin {
  final bool flag;

  @override
  List<Object?> get props => [flag];

  const NestedTag({required this.flag});
}

class NestedTagDto {
  bool flag;

  NestedTagDto({required this.flag});
}

class Nested with EquatableMixin {
  final int id;
  final String name;
  final NestedTag tag;

  @override
  List<Object?> get props => [id, name, tag];

  const Nested({required this.id, required this.name, required this.tag});
}

class NestedDto {
  final int id;
  final String name;
  final NestedTagDto tag;

  const NestedDto(this.id, {required this.name, required this.tag});
}

// primitive

class Primitive with EquatableMixin {
  final List<int> value;

  @override
  List<Object?> get props => [value];

  const Primitive(this.value);
}

class PrimitiveDto with EquatableMixin {
  final List<int> value;

  @override
  List<Object?> get props => [value];

  const PrimitiveDto(this.value);
}

class PrimitiveNullableDto with EquatableMixin {
  final List<int?> value;

  @override
  List<Object?> get props => [value];

  const PrimitiveNullableDto(this.value);
}

// complex

class Complex with EquatableMixin {
  final List<Nested> value;

  @override
  List<Object?> get props => [value];

  const Complex(this.value);
}

class ComplexWithNullList with EquatableMixin {
  final List<Nested>? value;

  @override
  List<Object?> get props => [value];

  const ComplexWithNullList(this.value);
}

class ComplexDto with EquatableMixin {
  final List<NestedDto> value;

  @override
  List<Object?> get props => [value];

  const ComplexDto(this.value);
}

class ComplexDtoWithNullList with EquatableMixin {
  final List<NestedDto>? value;

  @override
  List<Object?> get props => [value];

  const ComplexDtoWithNullList(this.value);
}

class ComplexNullableDto with EquatableMixin {
  final List<NestedDto?> value;

  @override
  List<Object?> get props => [value];

  const ComplexNullableDto(this.value);
}
