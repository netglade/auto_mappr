import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:auto_mappr_example/mappr.auto_mappr.dart';

class Utils {
  static DateTime mapDateTime() {
    return DateTime.now();
  }

  static String? mapSpecial(UserDto model) => '${model.xname}?!';
}

@AutoMappr([
  MapType<UserDto, User>(
    fields: [Field('name', from: 'xname'), Field('born', custom: Utils.mapDateTime)],
  ),
  MapType<UserDto, AnotherUser>(
    fields: [
      Field('name', from: 'xname'),
      Field('born', custom: Utils.mapDateTime),
      Field('special', custom: Utils.mapSpecial),
    ],
  ),
])
class Mappr extends $Mappr {}

class User {
  final int id;
  final String name;
  final DateTime born;

  const User({
    required this.id,
    required this.name,
    required this.born,
  });
}

class AnotherUser {
  final int id;
  final String name;
  final DateTime born;
  final String? special;

  AnotherUser({
    required this.id,
    required this.name,
    required this.born,
    this.special,
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
