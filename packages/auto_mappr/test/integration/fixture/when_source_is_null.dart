import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

part 'when_source_is_null.g.dart';

class SourceValue {
  final String? name;

  SourceValue(this.name);
}

class SourceStatic extends SourceValue {
  SourceStatic(super.name);
}

class SourceTopLevel extends SourceValue {
  SourceTopLevel(super.name);
}

class Target {
  final String name;

  Target(this.name);
}

@AutoMappr([
  MapType<SourceValue, Target>(
    fields: [
      Field('name', whenNull: 'static'),
    ],
  ),
  MapType<SourceStatic, Target>(
    fields: [
      Field('name', whenNull: Mappr._whenSourceIsNull),
    ],
  ),
  MapType<SourceTopLevel, Target>(
    fields: [
      Field('name', whenNull: _whenSourceIsNullTopLevel),
    ],
  ),
])
class Mappr extends $Mappr {
  static String _whenSourceIsNull() {
    return 'whenSourceIsNull';
  }
}

String _whenSourceIsNullTopLevel() {
  return 'whenSourceIsNullTopLevel';
}
