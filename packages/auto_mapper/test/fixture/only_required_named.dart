import 'package:auto_mapper/auto_mapper.dart';

part 'fixtures/only_required_named.dart';

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

@AutoMapper(mappers: [
  AutoMap<UserDto, User>(),
])
class Mapper extends $Mapper {}
