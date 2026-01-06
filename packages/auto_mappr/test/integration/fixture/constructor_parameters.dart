import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'constructor_parameters.auto_mappr.dart';

@AutoMappr([
  MapType<Positional, Positional>(),
  MapType<Positional, Named>(),
  MapType<Named, Positional>(),
  MapType<Named, Named>(),
])
class MapprX extends $MapprX {
  const MapprX();
}

class Positional with EquatableMixin {
  final int age;
  final String name;
  final String? note;

  @override
  List<Object?> get props => [age, name, note];

  const Positional(this.age, this.name, [this.note]);
}

class Named with EquatableMixin {
  final int age;
  final String name;
  final String? note;

  @override
  List<Object?> get props => [age, name, note];

  const Named({required this.age, required this.name, this.note});
}
