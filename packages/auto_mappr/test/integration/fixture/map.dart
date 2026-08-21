import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'map.auto_mappr.dart';

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
  // nullable and non nullable
  MapType<NullableMap, NullableMap>(),
  MapType<NullableMap, NonNullableMap>(),
  MapType<NonNullableMap, NullableMap>(),
  MapType<NonNullableMap, NonNullableMap>(),
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
  final bool flag;

  const NestedTagDto({required this.flag});
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

// Primitive primitive

class PrimitivePrimitive with EquatableMixin {
  final Map<String, int> value;

  @override
  List<Object?> get props => [value];

  const PrimitivePrimitive(this.value);
}

class PrimitivePrimitiveDto with EquatableMixin {
  final Map<String, int> value;

  @override
  List<Object?> get props => [value];

  const PrimitivePrimitiveDto(this.value);
}

class PrimitivePrimitiveNullableKeyDto with EquatableMixin {
  final Map<String?, int> value;

  @override
  List<Object?> get props => [value];

  const PrimitivePrimitiveNullableKeyDto(this.value);
}

class PrimitivePrimitiveNullableValueDto with EquatableMixin {
  final Map<String, int?> value;

  @override
  List<Object?> get props => [value];

  const PrimitivePrimitiveNullableValueDto(this.value);
}

class PrimitivePrimitiveNullableBothDto with EquatableMixin {
  final Map<String?, int?> value;

  @override
  List<Object?> get props => [value];

  const PrimitivePrimitiveNullableBothDto(this.value);
}

// Primitive complex

class PrimitiveComplex with EquatableMixin {
  final Map<String, Nested> value;

  @override
  List<Object?> get props => [value];

  const PrimitiveComplex(this.value);
}

class PrimitiveComplexDto with EquatableMixin {
  final Map<String, NestedDto> value;

  @override
  List<Object?> get props => [value];

  const PrimitiveComplexDto(this.value);
}

// Complex primitive

class ComplexPrimitive with EquatableMixin {
  final Map<Nested, int> value;

  @override
  List<Object?> get props => [value];

  const ComplexPrimitive(this.value);
}

class ComplexPrimitiveDto with EquatableMixin {
  final Map<NestedDto, int> value;

  @override
  List<Object?> get props => [value];

  const ComplexPrimitiveDto(this.value);
}

// Complex complex

class ComplexComplex with EquatableMixin {
  final Map<Nested, Nested> value;

  @override
  List<Object?> get props => [value];

  const ComplexComplex(this.value);
}

class ComplexComplexDto with EquatableMixin {
  final Map<NestedDto, NestedDto> value;

  @override
  List<Object?> get props => [value];

  const ComplexComplexDto(this.value);
}

class ComplexComplexNullableKeyDto with EquatableMixin {
  final Map<NestedDto?, NestedDto> value;

  @override
  List<Object?> get props => [value];

  const ComplexComplexNullableKeyDto(this.value);
}

class ComplexComplexNullableValueDto with EquatableMixin {
  final Map<NestedDto, NestedDto?> value;

  @override
  List<Object?> get props => [value];

  const ComplexComplexNullableValueDto(this.value);
}

class ComplexComplexNullableBothDto with EquatableMixin {
  final Map<NestedDto?, NestedDto?> value;

  @override
  List<Object?> get props => [value];

  const ComplexComplexNullableBothDto(this.value);
}

// nullable and non nullable

class NullableMap with EquatableMixin {
  final Map<String, Object?>? data;

  @override
  List<Object?> get props => [data];

  const NullableMap({this.data});
}

class NonNullableMap with EquatableMixin {
  final Map<String, Object?> data;

  @override
  List<Object?> get props => [data];

  const NonNullableMap({required this.data});
}
