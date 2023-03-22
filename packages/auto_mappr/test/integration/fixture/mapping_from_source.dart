import 'package:auto_mappr_annotation/auto_mappr.dart';
import 'package:equatable/equatable.dart';

part 'mapping_from_source.g.dart';

@AutoMappr([
  MapType<InstanceField, ValueHolder>(),
  MapType<InstanceGetter, ValueHolder>(),
  MapType<StaticField, ValueHolder>(),
  MapType<StaticGetter, ValueHolder>(),
])
class Mapper extends $Mapper {}

// ignore: must_be_immutable, for testing
class ValueHolder extends Equatable {
  final int value;
  String? secondValue;

  @override
  List<Object?> get props => [value, secondValue];

  ValueHolder(this.value);
}

class InstanceField {
  final int value;
  final String secondValue = 'test 1';

  InstanceField(this.value);
}

class InstanceGetter {
  int? _value;

  int get value => _value ?? 0;

  String get secondValue => 'test 2';

  set value(int newValue) => _value = newValue;
}

class StaticField {
  // ignore: avoid-global-state, for testing
  static int value = 666;
  static const String secondValue = 'test 3';
}

class StaticGetter {
  static int? _value;

  static int get value => _value ?? 0;

  static String get secondValue => 'test 4';

  static set value(int newValue) => _value = newValue;
}
