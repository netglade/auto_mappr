import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

part 'forced_null_source_field.g.dart';

@AutoMappr([
  MapType<Source, Target>(
    ignoreFieldNull: true,
    fields: [Field('name', whenNull: 'NULL NAME')],
  ),
  MapType<SourceField, TargeField>(
    fields: [
      Field('id', ignoreNull: true),
      Field('name', whenNull: 'NULL NAME'),
    ],
  ),
  MapType<SourceGlobal, TargeGlobal>(),
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
