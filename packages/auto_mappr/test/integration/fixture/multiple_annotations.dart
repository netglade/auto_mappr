import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

part 'multiple_annotations.g.dart';

class AnnotationA {
  const AnnotationA();
}

class AnnotationB {
  const AnnotationB();
}

@AnnotationA()
@AutoMappr([
  MapType<UserDto, User>(),
])
@AnnotationB()
class Mappr extends $Mappr {}

class User with EquatableMixin {
  final int age;
  final String name;

  @override
  List<Object?> get props => [age, name];

  const User({
    required this.age,
    required this.name,
  });
}

class UserDto {
  final int age;
  final String name;

  const UserDto({
    required this.age,
    required this.name,
  });
}
