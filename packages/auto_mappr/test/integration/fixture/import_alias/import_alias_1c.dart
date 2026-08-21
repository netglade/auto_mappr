import 'package:equatable/equatable.dart';

class YyyDto {
  final String name;
  final int age;

  const YyyDto({required this.name, required this.age});
}

class Yyy with Equatable {
  final String name;
  final int age;

  @override
  List<Object?> get props => [name, age];

  const Yyy({required this.name, required this.age});
}
