import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:examples_injectable/mappr.auto_mappr.dart';
import 'package:injectable/injectable.dart';

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
  final String name;

  UserDto({
    required this.id,
    required this.name,
  });
}

@LazySingleton()
@AutoMappr([MapType<UserDto, User>()])
class Mappr extends $Mappr {}
