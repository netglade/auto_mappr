part 'fixtures/only_positional.dart';

// @AutoMapper([
//   MapType<UserDto, User>(),
// ])
// class Mapper extends $Mapper {}

class User {
  final int id;
  final String name;

  User(this.id, this.name);
}

class UserDto {
  final int id;
  final String name;

  UserDto(this.id, this.name);
}
