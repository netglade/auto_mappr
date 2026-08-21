import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'iterable.auto_mappr.dart';

@AutoMappr([
  MapType<NestedTagDto, NestedTag>(),
  MapType<NestedDto, Nested>(),
  // primitive
  MapType<PrimitiveDto, Primitive>(),
  MapType<PrimitiveNullableDto, Primitive>(),
  // complex
  MapType<ComplexDto, Complex>(),
  MapType<ComplexNullableDto, Complex>(),
  // From List
  MapType<ListHolder, ListHolder>(),
  MapType<ListHolder, SetHolder>(),
  MapType<ListHolder, IterableHolder>(),
  // From Set
  MapType<SetHolder, ListHolder>(),
  MapType<SetHolder, SetHolder>(),
  MapType<SetHolder, IterableHolder>(),
  // From Iterable
  MapType<IterableHolder, ListHolder>(),
  MapType<IterableHolder, SetHolder>(),
  MapType<IterableHolder, IterableHolder>(),
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
  final Iterable<int> value;

  @override
  List<Object?> get props => [value];

  const Primitive(this.value);
}

class PrimitiveDto with EquatableMixin {
  final Iterable<int> value;

  @override
  List<Object?> get props => [value];

  const PrimitiveDto(this.value);
}

class PrimitiveNullableDto with EquatableMixin {
  final Iterable<int?> value;

  @override
  List<Object?> get props => [value];

  const PrimitiveNullableDto(this.value);
}

// complex

class Complex with EquatableMixin {
  final Iterable<Nested> value;

  @override
  List<Object?> get props => [value];

  const Complex(this.value);
}

class ComplexDto with EquatableMixin {
  final Iterable<NestedDto> value;

  @override
  List<Object?> get props => [value];

  const ComplexDto(this.value);
}

class ComplexNullableDto with EquatableMixin {
  final Iterable<NestedDto?> value;

  @override
  List<Object?> get props => [value];

  const ComplexNullableDto(this.value);
}

// List, Set, Iterable

class ListHolder with EquatableMixin {
  final List<int> value;

  @override
  List<Object?> get props => [value];

  const ListHolder(this.value);
}

class SetHolder with EquatableMixin {
  final Set<int> value;

  @override
  List<Object?> get props => [value];

  const SetHolder(this.value);
}

class IterableHolder with EquatableMixin {
  final Iterable<int> value;

  @override
  List<Object?> get props => [value];

  const IterableHolder(this.value);
}
