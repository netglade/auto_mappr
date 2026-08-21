import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'equatable.auto_mappr.dart';

@AutoMappr([MapType<Source, Target>()])
class Mappr extends $Mappr {
  const Mappr();
}

class Target with EquatableMixin {
  final int value;

  bool get secondValue => false;

  @override
  List<Object?> get props => [value, secondValue];

  const Target(this.value);
}

class Source with EquatableMixin {
  final int value;

  bool get secondValue => true;

  @override
  List<Object?> get props => [value, secondValue];

  const Source(this.value);
}
