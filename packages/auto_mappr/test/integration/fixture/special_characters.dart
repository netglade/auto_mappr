// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'special_characters.auto_mappr.dart';

@AutoMappr([
  // in class
  MapType<Dollar$Class, Dollar$Class>(),
  MapType<Dollar$Class, Underscore_Class>(),
  MapType<Dollar$Class, Number123Class>(),
  MapType<Underscore_Class, Dollar$Class>(),
  MapType<Underscore_Class, Underscore_Class>(),
  MapType<Underscore_Class, Number123Class>(),
  MapType<Number123Class, Dollar$Class>(),
  MapType<Number123Class, Underscore_Class>(),
  MapType<Number123Class, Number123Class>(),
  // in field
  MapType<DollarField, DollarField>(
    fields: [Field(r'val$ue', from: r'val$ue')],
  ),
  MapType<DollarField, UnderscoreField>(
    fields: [Field('val_ue', from: r'val$ue')],
  ),
  MapType<DollarField, NumberField>(
    fields: [Field('val123ue', from: r'val$ue')],
  ),
  MapType<UnderscoreField, DollarField>(
    fields: [Field(r'val$ue', from: 'val_ue')],
  ),
  MapType<UnderscoreField, UnderscoreField>(
    fields: [Field('val_ue', from: 'val_ue')],
  ),
  MapType<UnderscoreField, NumberField>(
    fields: [Field('val123ue', from: 'val_ue')],
  ),
  MapType<NumberField, DollarField>(
    fields: [Field(r'val$ue', from: 'val123ue')],
  ),
  MapType<NumberField, UnderscoreField>(
    fields: [Field('val_ue', from: 'val123ue')],
  ),
  MapType<NumberField, NumberField>(
    fields: [Field('val123ue', from: 'val123ue')],
  ),
])
class Mappr extends $Mappr {
  const Mappr();
}

class Dollar$Class with EquatableMixin {
  final int value;

  @override
  List<Object?> get props => [value];

  const Dollar$Class({required this.value});
}

class Underscore_Class with EquatableMixin {
  final int value;

  @override
  List<Object?> get props => [value];

  const Underscore_Class({required this.value});
}

class Number123Class with EquatableMixin {
  final int value;

  @override
  List<Object?> get props => [value];

  const Number123Class({required this.value});
}

class DollarField with EquatableMixin {
  final int val$ue;

  @override
  List<Object?> get props => [val$ue];

  const DollarField({required this.val$ue});
}

class UnderscoreField with EquatableMixin {
  final int val_ue;

  @override
  List<Object?> get props => [val_ue];

  const UnderscoreField({required this.val_ue});
}

class NumberField with EquatableMixin {
  final int val123ue;

  @override
  List<Object?> get props => [val123ue];

  const NumberField({required this.val123ue});
}
