import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

part 'constructor_parameters.g.dart';

@AutoMappr([
  MapType<Positional, Positional>(),
  MapType<Positional, Named>(),
  MapType<Named, Positional>(),
  MapType<Named, Named>(),
])
class Mappr extends $Mappr {}

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
