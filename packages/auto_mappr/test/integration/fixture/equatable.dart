import 'package:auto_mappr_annotation/auto_mappr.dart';
import 'package:equatable/equatable.dart';

part 'equatable.g.dart';

@AutoMappr([
  MapType<Source, Target>(),
])
class Mapper extends $Mapper {}

class Target extends Equatable {
  final int value;

  bool get secondValue => false;

  @override
  List<Object?> get props => [value, secondValue];

  const Target(this.value);
}

class Source extends Equatable {
  final int value;

  bool get secondValue => true;

  @override
  List<Object?> get props => [value, secondValue];

  const Source(this.value);
}
