import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'try_convert.auto_mappr.dart';

@AutoMappr([
  MapType<NestedDto, Nested>(),
  // value
  MapType<ComplexValueDto, ComplexValue>(
    safeMapping: true,
    whenSourceIsNull: ComplexValue(99, Nested(id: 123, name: 'test qwerty'), 'male'),
  ),
  MapType<ExampleDto, Example>(ignoreFieldNull: true),
])
class Mappr extends $Mappr {
  const Mappr();
}

// Other object

class Example extends Equatable {
  final int id;

  @override
  List<Object?> get props => [id];

  const Example(this.id);
}

class ExampleDto {
  final int? id;

  const ExampleDto({this.id});
}

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

  const NestedDto(this.id, {required this.name});
}

// --- Value

// Complex

class ComplexValue extends Equatable {
  final int age;
  final String gender;
  final Nested name;

  @override
  List<Object?> get props => [age, name, gender];

  const ComplexValue(this.age, this.name, this.gender);
}

class ComplexValueDto {
  final int age;
  final NestedDto? name;
  final String? gender;

  const ComplexValueDto(this.age, this.name, this.gender);
}
