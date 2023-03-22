import 'package:auto_mappr_annotation/auto_mappr.dart';
import 'package:equatable/equatable.dart';

part 'map.g.dart';

@AutoMappr([
  MapType<NestedTagDto, NestedTag>(),
  MapType<NestedDto, Nested>(
    whenSourceIsNull: Nested(id: 666, name: 'default', tag: NestedTag(flag: true)),
  ),
  // primitive primitive
  MapType<PrimitivePrimitiveDto, PrimitivePrimitive>(),
  MapType<PrimitivePrimitiveNullableKeyDto, PrimitivePrimitive>(),
  MapType<PrimitivePrimitiveNullableValueDto, PrimitivePrimitive>(),
  MapType<PrimitivePrimitiveNullableBothDto, PrimitivePrimitive>(),
  // primitive complex
  MapType<PrimitiveComplexDto, PrimitiveComplex>(),
  // complex primitive
  MapType<ComplexPrimitiveDto, ComplexPrimitive>(),
  // complex complex
  MapType<ComplexComplexDto, ComplexComplex>(),
  MapType<ComplexComplexNullableKeyDto, ComplexComplex>(),
  MapType<ComplexComplexNullableValueDto, ComplexComplex>(),
  MapType<ComplexComplexNullableBothDto, ComplexComplex>(),
])
class Mapper extends $Mapper {}

class NestedTag extends Equatable {
  final bool flag;

  @override
  List<Object?> get props => [flag];

  const NestedTag({required this.flag});
}

class NestedTagDto {
  final bool flag;

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

// Primitive primitive

class PrimitivePrimitive extends Equatable {
  final Map<String, int> value;

  @override
  List<Object?> get props => [value];

  const PrimitivePrimitive(this.value);
}

class PrimitivePrimitiveDto extends Equatable {
  final Map<String, int> value;

  @override
  List<Object?> get props => [value];

  const PrimitivePrimitiveDto(this.value);
}

class PrimitivePrimitiveNullableKeyDto extends Equatable {
  final Map<String?, int> value;

  @override
  List<Object?> get props => [value];

  const PrimitivePrimitiveNullableKeyDto(this.value);
}

class PrimitivePrimitiveNullableValueDto extends Equatable {
  final Map<String, int?> value;

  @override
  List<Object?> get props => [value];

  const PrimitivePrimitiveNullableValueDto(this.value);
}

class PrimitivePrimitiveNullableBothDto extends Equatable {
  final Map<String?, int?> value;

  @override
  List<Object?> get props => [value];

  const PrimitivePrimitiveNullableBothDto(this.value);
}

// Primitive complex

class PrimitiveComplex extends Equatable {
  final Map<String, Nested> value;

  @override
  List<Object?> get props => [value];

  const PrimitiveComplex(this.value);
}

class PrimitiveComplexDto extends Equatable {
  final Map<String, NestedDto> value;

  @override
  List<Object?> get props => [value];

  const PrimitiveComplexDto(this.value);
}

// Complex primitive

class ComplexPrimitive extends Equatable {
  final Map<Nested, int> value;

  @override
  List<Object?> get props => [value];

  const ComplexPrimitive(this.value);
}

class ComplexPrimitiveDto extends Equatable {
  final Map<NestedDto, int> value;

  @override
  List<Object?> get props => [value];

  const ComplexPrimitiveDto(this.value);
}

// Complex complex

class ComplexComplex extends Equatable {
  final Map<Nested, Nested> value;

  @override
  List<Object?> get props => [value];

  const ComplexComplex(this.value);
}

class ComplexComplexDto extends Equatable {
  final Map<NestedDto, NestedDto> value;

  @override
  List<Object?> get props => [value];

  const ComplexComplexDto(this.value);
}

class ComplexComplexNullableKeyDto extends Equatable {
  final Map<NestedDto?, NestedDto> value;

  @override
  List<Object?> get props => [value];

  const ComplexComplexNullableKeyDto(this.value);
}

class ComplexComplexNullableValueDto extends Equatable {
  final Map<NestedDto, NestedDto?> value;

  @override
  List<Object?> get props => [value];

  const ComplexComplexNullableValueDto(this.value);
}

class ComplexComplexNullableBothDto extends Equatable {
  final Map<NestedDto?, NestedDto?> value;

  @override
  List<Object?> get props => [value];

  const ComplexComplexNullableBothDto(this.value);
}
