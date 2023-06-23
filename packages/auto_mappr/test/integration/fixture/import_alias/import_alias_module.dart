import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

part 'import_alias_module.g.dart';

@AutoMappr([
  MapType<UserDto, User>(),
])
class ImportAliasModule extends $ImportAliasModule {
  const ImportAliasModule();
}

class UserDto {
  final String name;
  final int age;

  const UserDto({
    required this.name,
    required this.age,
  });
}

class User with EquatableMixin {
  final String name;
  final int age;

  @override
  List<Object?> get props => [name, age];

  const User({
    required this.name,
    required this.age,
  });
}
