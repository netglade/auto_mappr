import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

part 'equatable.g.dart';

@AutoMappr([
  MapType<UserDto, User>(),
])
class Mappr extends $Mappr {}

class User extends Equatable {
  final int id;
  final String name;
  final String? tag;

  bool get hasTag => tag != null;

  const User({
    required this.id,
    required this.name,
    required this.tag,
  });

  @override
  List<Object?> get props => [id, name, tag];
}

class UserDto {
  final int id;
  final String name;
  final int age;

  UserDto({
    required this.id,
    required this.name,
    required this.age,
  });
}
