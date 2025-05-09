import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'constructor_rename.auto_mappr.dart';

@AutoMappr([
  MapType<Source, Target>(
    constructor: 'rename',
    fields: [
      Field('nick', custom: ConstructorRenameMappr.mapName),
      Field('home', from: 'address'),
    ],
  ),
])
class ConstructorRenameMappr extends $ConstructorRenameMappr {
  static String mapName(Source s) => s.name;
}

class Source extends Equatable {
  final String name;
  final String address;
  final String note;

  @override
  List<Object?> get props => [name, address, note];

  const Source({required this.name, required this.address, required this.note});
}

class Target extends Equatable {
  final String name;
  final String address;
  final String note;

  @override
  List<Object?> get props => [name, address, note];

  const Target({required this.name, required this.address, required this.note});

  const Target.rename({
    required String nick,
    required String home,
    required String note,
  }) : this(name: nick, address: home, note: note);
}
