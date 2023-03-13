import 'package:auto_mapper_annotation/auto_mapper.dart';
import 'package:equatable/equatable.dart';

part 'equatable.mapper.g.dart';

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

@AutoMapper(mappers: [
  AutoMap<UserDto, User>(),
])
class ExampleMapper extends $ExampleMapper {}
