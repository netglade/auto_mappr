import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'complex_types.auto_mappr.dart';

@AutoMappr(
  [
    MapType<UserDto, User>(),
    MapType<NestedDto, Nested>(),
    MapType<NestedTagDto, NestedTag>(),
  ],
)
class Mappr extends $Mappr {
  const Mappr();
}

class NestedTag extends Equatable {
  @override
  List<Object?> get props => [];

  const NestedTag();
}

class NestedTagDto {
  const NestedTagDto();
}

class Nested extends Equatable {
  final int id;
  final String name;
  final NestedTag tag;

  @override
  List<Object?> get props => [id, name, tag];

  const Nested({required this.id, required this.name, required this.tag});
}

class NestedDto {
  final int id;
  final String name;
  final NestedTagDto tag;

  const NestedDto(this.id, {required this.name, required this.tag});
}

class UserDto {
  final int id;
  final NestedDto name;
  final NestedTagDto tag;

  const UserDto({required this.id, required this.name, required this.tag});
}

class User extends Equatable {
  final int id;
  final Nested name;
  final NestedTag? tag;

  bool get hasTag => tag != null;

  @override
  List<Object?> get props => [id, name, tag];

  const User({required this.id, required this.name, this.tag});
}
