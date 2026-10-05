import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

import 'package:examples_example/constructor.auto_mappr.dart';

@AutoMappr([
  MapType<UserDto, User>(
    // Used for UserDto -> User.
    targetConstructor: 'fromDto',
    // Used for the reverse User -> UserDto.
    sourceConstructor: 'fromUser',
    reverse: true,
  ),
])
class Mappr extends $Mappr {}

class User {
  final int id;
  final String displayName;

  const User({required this.id, required this.displayName});

  // `name` is not a field of User, it is filled from UserDto.name.
  const User.fromDto({required this.id, required String name}) : displayName = 'User $name';

  @override
  String toString() => 'User(id: $id, displayName: $displayName)';
}

class UserDto {
  final int id;
  final String name;

  const UserDto({required this.id, required this.name});

  // `displayName` is not a field of UserDto, it is filled from User.displayName.
  const UserDto.fromUser({required this.id, required String displayName}) : name = displayName;

  @override
  String toString() => 'UserDto(id: $id, name: $name)';
}
