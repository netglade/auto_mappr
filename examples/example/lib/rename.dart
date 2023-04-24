import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

part 'rename.g.dart';

@AutoMappr([
  MapType<UserDto, User>(
    fields: [
      Field('name', from: 'xname'),
    ],
  ),
])
class Mappr extends $Mappr {}

class User {
  final int id;
  final String name;

  const User({
    required this.id,
    required this.name,
  });
}

class UserDto {
  final int id;
  final String xname;

  UserDto({
    required this.id,
    required this.xname,
  });
}
