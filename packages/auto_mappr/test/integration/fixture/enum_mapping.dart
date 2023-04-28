import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

part 'enum_mapping.g.dart';

enum Person { student, parent, employee }

enum User { student, parent, employee, admin }

enum LocalPerson { student, parent, employee, unknown }

enum RemotePerson { student, parent, employee, vp, director }

enum EnhancedSource {
  student(1, 'student'),
  parent(2, 'parent'),
  employee(3, 'employee');

  const EnhancedSource(this.id, this.name);

  final int id;
  final String name;

  String get row => '$id+$name';
}

enum EnhancedSourceWithUnknown {
  student(1, 'student'),
  parent(2, 'parent'),
  employee(3, 'employee'),
  alien(4, 'alien');

  const EnhancedSourceWithUnknown(this.id, this.name);

  final int id;
  final String name;

  String get row => '$id+$name';
}

enum EnhancedTarget {
  student(1, 'student', isAdmin: false),
  parent(2, 'parent', isAdmin: false),
  employee(3, 'employee', isAdmin: false),
  admin(4, 'admin', isAdmin: true),
  unknown(5, 'unknown', isAdmin: false);

  const EnhancedTarget(this.id, this.name, {required this.isAdmin});

  final int id;
  final String name;
  final bool isAdmin;

  String get row => '$id+$name';
}

LocalPerson _localRemoteUnknownDefault() => LocalPerson.unknown;

@AutoMappr([
  MapType<Person, User>(),
  MapType<RemotePerson, LocalPerson>(
    whenSourceIsNull: _localRemoteUnknownDefault,
  ),
  MapType<EnhancedSource, EnhancedTarget>(),
  MapType<EnhancedSourceWithUnknown, EnhancedTarget>(
    whenSourceIsNull: EnhancedTarget.unknown,
  ),
])
class Mappr extends $Mappr {}
