import 'package:auto_mapper/auto_mapper.dart';
import 'package:equatable/equatable.dart';

part 'automapper.g.dart';

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

class NameDto {
  final int id;
  final String name;

  NameDto(
    this.id, {
    required this.name,
  });
}

class SetterNameDto {
  int id = 0;
  final String name;

  SetterNameDto({
    required this.name,
  });
}

class ListDtoNN {
  final List<String> names;

  ListDtoNN({
    required this.names,
  });
}

class ListDtoNullable {
  final List<String>? names;

  ListDtoNullable({
    required this.names,
  });
}

class ListTargetNN {
  final List<String> names;

  ListTargetNN({
    required this.names,
  });
}

class ListTargetNullable {
  final List<String>? names;

  ListTargetNullable({
    required this.names,
  });
}

@AutoMapper(mappers: [
  AutoMap<UserDto, User>(),
  //AutoMap<User, UserDto>(),
  // AutoMap<UserDto, NameDto>(),
  // AutoMap<UserDto, SetterNameDto>(),
  // AutoMap<ListDtoNN, ListTargetNN>(),
  // AutoMap<ListDtoNN, ListTargetNullable>(),
  // AutoMap<ListDtoNullable, ListTargetNullable>(),
  // AutoMap<ListDtoNullable, ListTargetNN>(),
])
class ExampleMapper extends $ExampleMapper {}
