import 'package:auto_mapper/auto_mapper.dart';
import 'package:equatable/equatable.dart';

part 'nullable.g.dart';

class User extends Equatable {
  final int id;
  final Nested? name;
  final Nested tag;

  const User({
    required this.id,
    this.name,
    required this.tag,
  });

  @override
  List<Object?> get props => [id, name, tag];
}

class Nested {
  final int id;
  final String name;

  Nested({
    required this.id,
    required this.name,
  });
}

class UserDto {
  final int id;
  final NestedDto name;
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

@AutoMapper(mappers: [
  AutoMap<UserDto, User>(),
  AutoMap<NestedDto?, Nested>(whenNullDefault: ExampleMapper.defaultNested),
])
class ExampleMapper extends $ExampleMapper {
  static Nested defaultNested() => Nested(id: 1, name: 'default');
}
