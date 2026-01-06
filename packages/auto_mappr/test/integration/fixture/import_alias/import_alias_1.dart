import 'package:equatable/equatable.dart';

export 'import_alias_1b.dart';

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

class Holder<A, B> with EquatableMixin {
  final A first;
  final B second;

  @override
  List<Object?> get props => [first, second];

  const Holder({required this.first, required this.second});
}
