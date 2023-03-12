import 'package:auto_mapper_annotation/auto_mapper.dart';

part 'reverse.g.dart';

class User {
  final int id;
  final String name;

  const User({
    required this.id,
    required this.name,
  });
}

class UserDto {
  final int id;
  final String name;

  UserDto({
    required this.id,
    required this.name,
  });
}

@AutoMapper(mappers: [
  AutoMap<UserDto, User>(reverse: true),
])
class ExampleMapper extends $ExampleMapper {}
