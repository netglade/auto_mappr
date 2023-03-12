import 'package:auto_mapper_annotation/auto_mapper.dart';

part 'rename.g.dart';

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
  final String xname;

  UserDto({
    required this.id,
    required this.xname,
  });
}

@AutoMapper(mappers: [
  AutoMap<UserDto, User>(
    mappings: [
      MapMember(member: 'name', rename: 'xname'),
    ],
  ),
])
class ExampleMapper extends $ExampleMapper {}
