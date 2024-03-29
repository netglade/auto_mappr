import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'package:examples_example/nullable.auto_mappr.dart';

@AutoMappr([
  MapType<UserDto, User>(
    whenSourceIsNull: User(id: 1, tag: Nested(id: 1, name: 'default')),
    fields: [
      Field('tag', whenNull: Mappr.defaultNested),
    ],
  ),
  MapType<NestedDto, Nested>(),
])
class Mappr extends $Mappr {
  static Nested defaultNested() => const Nested(id: 1, name: 'default_TAG');
}

class User extends Equatable {
  final int id;
  final Nested? name;
  final Nested tag;

  const User({
    required this.id,
    required this.tag,
    this.name,
  });

  @override
  List<Object?> get props => [id, name, tag];
}

class Nested {
  final int id;
  final String name;

  const Nested({
    required this.id,
    required this.name,
  });
}

class UserDto {
  final int id;
  final NestedDto? name;
  final NestedDto? tag;

  UserDto({
    required this.id,
    required this.name,
    this.tag,
  });
}

class NestedDto {
  final int id;
  final String name;

  NestedDto(
    this.id, {
    required this.name,
  });
}
