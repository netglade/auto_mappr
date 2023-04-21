import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

part 'try_convert.g.dart';

@AutoMappr([
  MapType<NestedDto, Nested>(),
  // value
  MapType<ComplexValueDto, ComplexValue>(
    whenSourceIsNull: ComplexValue(99, Nested(id: 123, name: 'test qwerty')),
  ),
])
class Mappr extends $Mappr {}

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

//todo
class ComplexValue extends Equatable {
  final int age;
  final Nested name;

  @override
  List<Object?> get props => [age, name];

  const ComplexValue(this.age, this.name);
}

//todo
class ComplexValueDto {
  final int age;
  final NestedDto? name;

  ComplexValueDto(this.age, this.name);
}
