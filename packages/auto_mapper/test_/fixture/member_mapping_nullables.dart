// part 'fixtures/member_mapping_nullables.dart';
//
// @AutoMapper([
//   MapType<UserDto, User>(
//     fields: [
//       Field('name', custom: Mapper.mapName),
//       Field('age', custom: mapAge),
//       Field('ignoreByMapping', ignore: true)
//     ],
//   ),
// ])
// class Mapper extends $Mapper {
//   static String mapName(UserDto? from) => from!.name.toUpperCase();
// }
//
// // ignore: prefer-static-class, for test
// int mapAge(UserDto? _) => 55;

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
