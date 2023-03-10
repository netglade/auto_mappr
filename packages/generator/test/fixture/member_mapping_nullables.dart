import 'package:auto_mapper/auto_mapper.dart';

part 'fixtures/member_mapping_nullables.dart';

class User {
  final int id;
  final String name;
  final String? positionalCanbeIgnoredByNull;

  int age = 0;

  int ignoreByMapping = 0;

  final int? namedIgnoredByNull;

  User(
    this.positionalCanbeIgnoredByNull, {
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
        MapMember(member: 'name', target: Mapper.m),
        MapMember(member: 'age', target: mapAge),
        MapMember(member: 'ignoreByMapping', ignore: true)
      ],
    ),
  ],
)
class Mapper extends $Mapper {
  static String m(UserDto from) => from.name;
}

// ignore: prefer-static-class, for test
int mapAge(UserDto _) => 55;
