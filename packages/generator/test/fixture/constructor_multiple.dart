import 'package:automapper/automapper.dart';

part 'fixtures/constructor_multiple.dart';

class User {
  final int id;
  final String name;

  User(this.id, this.name);

  User.named({required this.id, required this.name});

  User.moreParams({required this.id, required this.name, String? x, String? y});

  // This should be ignored
  factory User.fromParams(int id, String firstName, String secondName) => User(id, '$firstName $secondName');
}

class UserDto {
  final int id;
  final String name;

  UserDto(this.id, this.name);
}

@AutoMapper(mappers: [
  AutoMap<UserDto, User>(),
])
class Mapper extends $Mapper {}
