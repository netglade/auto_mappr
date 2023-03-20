import 'package:auto_mapper_annotation/auto_mapper.dart';
import 'package:equatable/equatable.dart';

part 'constructor_parameters.g.dart';

@AutoMapper([
  MapType<Positional, Positional>(),
  MapType<Positional, Named>(),
  MapType<Named, Positional>(),
  MapType<Named, Named>(),
])
class Mapper extends $Mapper {}

class Positional extends Equatable {
  final int age;
  final String name;
  final String? note;

  @override
  List<Object?> get props => [age, name, note];

  const Positional(
    this.age,
    this.name, [
    this.note,
  ]);
}

class Named extends Equatable {
  final int age;
  final String name;
  final String? note;

  @override
  List<Object?> get props => [age, name, note];

  const Named({
    required this.age,
    required this.name,
    this.note,
  });
}
