import 'package:auto_mapper/auto_mapper.dart';

part 'fixtures/member_mapping_nullables.dart';

class User {
  final int id;
  final String name;
  final String? positionalCanBeIgnoredByNull;

  int age = 0;

  int ignoreByMapping = 0;

  final int? namedIgnoredByNull;

  User(
    this.positionalCanBeIgnoredByNull, {
    required this.id,
    required this.name,
    required this.namedIgnoredByNull,
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

@AutoMapper(
  mappers: [
    AutoMap<UserDto, User>(
      mappings: [
        MapMember(member: 'name', custom: Mapper.mapName),
        MapMember(member: 'age', custom: mapAge),
        MapMember(member: 'ignoreByMapping', ignore: true)
      ],
    ),
  ],
)
class Mapper extends $Mapper {
  static String mapName(UserDto from) => from.name.toUpperCase();
}

// ignore: prefer-static-class, for test
int mapAge(UserDto _) => 55;
