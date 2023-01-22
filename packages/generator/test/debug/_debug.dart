import 'package:automapper/automapper.dart';

class User {
  final int id;
  final String name;
  final String? tag;

  int age = 0;

  User({
    required this.id,
    required this.name,
    required this.tag,
  });
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
  AutoMap<UserDto, User>(reverse: true, mappings: [
    MapMember(member: 'name', target: ExampleMapper.mapUserDtoName),
  ]),
  AutoMap<User, UserDto>(),
  // AutoMap<UserDto, User>(reverse: true),
  //AutoMap<UserDto, User>(reverse: true),
  //AutoMap<NameDto, User>(),
])
abstract class ExampleMapper {
  static String mapUserDtoName(UserDto dto) => dto.name.toUpperCase();
}
