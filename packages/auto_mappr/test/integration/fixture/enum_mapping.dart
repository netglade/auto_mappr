import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

part 'enum_mapping.g.dart';

enum Person { employee, parent, student }

enum User { admin, employee, parent, student }

enum LocalPerson { employee, parent, student, unknown }

enum RemotePerson { director, employee, parent, student, vp }

enum EnhancedSource {
  employee(3, 'employee'),
  parent(2, 'parent'),
  student(1, 'student');

  const EnhancedSource(this.id, this.name);

  final int id;
  final String name;

  String get row => '$id+$name';
}

enum EnhancedSourceWithUnknown {
  alien(4, 'alien'),
  employee(3, 'employee'),
  parent(2, 'parent'),
  student(1, 'student');

  const EnhancedSourceWithUnknown(this.id, this.name);

  final int id;
  final String name;

  String get row => '$id+$name';
}

enum EnhancedTarget {
  admin(4, 'admin', isAdmin: true),
  employee(3, 'employee', isAdmin: false),
  parent(2, 'parent', isAdmin: false),
  student(1, 'student', isAdmin: false),
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
class Mappr extends $Mappr {
  const Mappr();
}
