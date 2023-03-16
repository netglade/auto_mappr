part 'fixtures/only_required_named.dart';

// @AutoMapper([
//   MapType<UserDto, User>(),
// ])
// class Mapper extends $Mapper {}

class User {
  final int id;
  final String name;

  User({
    required this.id,
    required this.name,
  });
}

class UserDto {
  final int id;
  final String name;

  UserDto(this.id, this.name);
}
