import 'package:auto_mapper/auto_mapper.dart';

part 'fixtures/only_positional.dart';

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

@AutoMapper(
  mappers: [
    AutoMap<UserDto, User>(),
  ],
)
class Mapper extends $Mapper {}
