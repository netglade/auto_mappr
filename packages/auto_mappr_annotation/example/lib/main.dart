import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

// part 'main.auto_mappr.dart';

@AutoMappr([
  MapType<UserDto, User>(),
])
class Mappr {} // extends $Mappr {}

class User {
  final int age;
  final String username;

  const User({
    required this.age,
    required this.username,
  });
}

class UserDto {
  final int age;
  final String username;

  const UserDto(this.age, this.username);
}

void main() {}
