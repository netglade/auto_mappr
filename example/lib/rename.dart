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

@AutoMapper([
  MapType<UserDto, User>(
    fields: [
      Field('name', from: 'xname'),
    ],
  ),
])
class ExampleMapper extends $ExampleMapper {}
