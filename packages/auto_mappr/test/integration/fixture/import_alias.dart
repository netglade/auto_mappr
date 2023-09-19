import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'import_alias.auto_mappr.dart';
import 'import_alias/import_alias_1.dart' as a1;
import 'import_alias/import_alias_2.dart' as a2;
import 'import_alias/import_alias_module.dart' as module;

@AutoMappr(
  [
    MapType<UserDto, User>(),
    MapType<UserDto, a1.User>(),
    MapType<UserDto, a2.User>(),
    MapType<a1.UserDto, User>(),
    MapType<a1.UserDto, a1.User>(),
    MapType<a1.UserDto, a2.User>(),
    MapType<a2.UserDto, User>(),
    MapType<a2.UserDto, a1.User>(),
    MapType<a2.UserDto, a2.User>(),
    // export from a1
    MapType<a1.XxxDto, a1.Xxx>(),
    MapType<a1.YyyDto, a1.Yyy>(),
    // generics
    MapType<Holder<a1.UserDto, a2.UserDto>, a2.Holder<a1.User, a2.User>>(),
    // iterable
    MapType<ListHolder<UserDto>, ListHolder<a1.User>>(),
    MapType<MapHolder<UserDto>, MapHolder<a2.User>>(),
  ],
  delegates: [module.ImportAliasModule()],
)
class Mappr extends $Mappr {
  const Mappr();
}

class UserDto {
  final String name;
  final int age;

  const UserDto({required this.name, required this.age});
}

class User with EquatableMixin {
  final String name;
  final int age;

  @override
  List<Object?> get props => [name, age];

  const User({required this.name, required this.age});
}

class Holder<A, B> extends Equatable {
  final A first;
  final B second;

  @override
  List<Object?> get props => [first, second];

  const Holder({required this.first, required this.second});
}

// iterables

class ListHolder<T> with EquatableMixin {
  final List<T> list;

  @override
  List<Object?> get props => [list];

  const ListHolder(this.list);
}

class MapHolder<T> with EquatableMixin {
  final Map<String, T> map;

  @override
  List<Object?> get props => [map];

  const MapHolder(this.map);
}
