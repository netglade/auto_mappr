import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

import 'forced_null_source_field.auto_mappr.dart';

@AutoMappr([
  MapType<Source, Target>(ignoreFieldNull: true),
  MapType<SourceWithNestedObject, TargetWithNestedObject>(ignoreFieldNull: true),
  MapType<SourceField, TargeField>(
    fields: [
      Field('id', ignoreNull: true),
      Field('name', whenNull: 'NULL NAME'),
    ],
  ),
  MapType<SourceFieldWithNestedObject, TargetFieldWithNestedObject>(
    fields: [
      Field('id', ignoreNull: true),
      Field('name', whenNull: 'NULL NAME'),
    ],
  ),
  MapType<SourceGlobal, TargeGlobal>(),
  MapType<SourceGlobalWithNestedObject, TargetGlobalWithNestedObject>(),
])
class Mappr extends $Mappr {
  const Mappr();
}

// * BASED on MapType settings

class Source {
  final String? id;
  final String? name;

  const Source({this.id, this.name});
}

class Target {
  final String id;
  final String name;

  const Target({required this.id, required this.name});
}

class SourceWithNestedObject {
  final InnerClass? id;
  final String? name;

  const SourceWithNestedObject({this.id, this.name});
}

class TargetWithNestedObject {
  final InnerClass id;
  final String name;

  const TargetWithNestedObject({required this.id, required this.name});
}

// * BASED on Field settings

class SourceField {
  final String? id;
  final String? name;

  const SourceField({this.id, this.name});
}

class TargeField {
  final String id;
  final String name;

  const TargeField({required this.id, required this.name});
}

class SourceFieldWithNestedObject {
  final InnerClass? id;
  final String? name;

  const SourceFieldWithNestedObject({this.id, this.name});
}

class TargetFieldWithNestedObject {
  final InnerClass id;
  final String name;

  const TargetFieldWithNestedObject({required this.id, required this.name});
}

// * BASED on Global settings

class SourceGlobal {
  final String? id;
  final String? name;

  const SourceGlobal({this.id, this.name});
}

class TargeGlobal {
  final String id;
  final String name;

  const TargeGlobal({required this.id, required this.name});
}

class SourceGlobalWithNestedObject {
  final InnerClass? id;
  final String? name;

  const SourceGlobalWithNestedObject({this.id, this.name});
}

class TargetGlobalWithNestedObject {
  final InnerClass id;
  final String name;

  const TargetGlobalWithNestedObject({required this.id, required this.name});
}

// * Helper types

class InnerClass {
  const InnerClass();
}
