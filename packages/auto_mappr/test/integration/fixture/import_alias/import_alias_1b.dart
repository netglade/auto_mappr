import 'package:equatable/equatable.dart';

export 'import_alias_1c.dart';

class XxxDto {
  final String name;
  final int age;

  const XxxDto({
    required this.name,
    required this.age,
  });
}

class Xxx with EquatableMixin {
  final String name;
  final int age;

  @override
  List<Object?> get props => [name, age];

  const Xxx({
    required this.name,
    required this.age,
  });
}
