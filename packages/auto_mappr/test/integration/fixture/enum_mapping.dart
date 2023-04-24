import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

part 'enum_mapping.g.dart';

enum Person { student, parent, employee }

enum User { student, parent, employee, admin }

enum EnhancedSource {
  student(1, 'student'),
  parent(2, 'parent'),
  employee(3, 'employee');

  const EnhancedSource(this.id, this.name);

  final int id;
  final String name;

  String get row => '$id+$name';
}

enum EnhancedTarget {
  student(1, 'student', isAdmin: false),
  parent(2, 'parent', isAdmin: false),
  employee(3, 'employee', isAdmin: false),
  admin(4, 'admin', isAdmin: true);

  const EnhancedTarget(this.id, this.name, {required this.isAdmin});

  final int id;
  final String name;
  final bool isAdmin;

  String get row => '$id+$name';
}

@AutoMappr([
  MapType<Person, User>(),
  MapType<EnhancedSource, EnhancedTarget>(),
])
class Mappr extends $Mappr {}
