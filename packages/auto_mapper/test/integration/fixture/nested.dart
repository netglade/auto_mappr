import 'package:auto_mapper_annotation/auto_mapper.dart';
import 'package:equatable/equatable.dart';

part 'nested.g.dart';

class User extends Equatable {
  final int id;
  final Nested name;
  final NestedTag? tag;

  bool get hasTag => tag != null;

  @override
  List<Object?> get props => [id, name, tag];

  const User({
    required this.id,
    required this.name,
    this.tag,
  });
}

class Nested extends Equatable {
  final int id;
  final String name;
  final NestedTag tag;

  @override
  List<Object?> get props => [id, name, tag];

  Nested({
    required this.id,
    required this.name,
    required this.tag,
  });
}

class NestedTag extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserDto {
  final int id;
  final NestedDto name;
  final NestedTagDto tag;

  UserDto({
    required this.id,
    required this.name,
    required this.tag,
  });
}

class NestedDto {
  final int id;
  final String name;
  final NestedTagDto tag;

  NestedDto(this.id, {
    required this.name,
    required this.tag,
  });
}

class NestedTagDto {}

@AutoMapper(mappers: [
  AutoMap<UserDto, User>(),
  AutoMap<NestedDto, Nested>(),
  AutoMap<NestedTagDto, NestedTag>(),
])
class Mapper extends $Mapper {}
