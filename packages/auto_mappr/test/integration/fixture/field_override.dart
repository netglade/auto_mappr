import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'field_override.auto_mappr.dart';

@AutoMappr([
  MapType<Source, Target>(),
  MapType<NestedSource, NestedTarget>(),
  MapType<SourceData, TargetData>(),
])
class Mappr extends $Mappr {
  const Mappr();
}

abstract interface class IData {
  int get value;
}

class Source implements IData {
  @override
  final int value;

  const Source({required this.value});
}

class Target with EquatableMixin implements IData {
  @override
  final int value;

  @override
  List<Object?> get props => [value];

  const Target({required this.value});
}

// NESTED

class SourceData implements IData {
  @override
  final int value;

  const SourceData({required this.value});
}

class TargetData with EquatableMixin implements IData {
  @override
  final int value;

  @override
  List<Object?> get props => [value];

  const TargetData({required this.value});
}

abstract interface class INestedData {
  IData get value;
}

class NestedSource implements INestedData {
  @override
  final SourceData value;

  const NestedSource({required this.value});
}

class NestedTarget with EquatableMixin implements INestedData {
  @override
  final TargetData value;

  @override
  List<Object?> get props => [value];

  const NestedTarget({required this.value});
}
