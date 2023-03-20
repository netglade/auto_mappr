// ignore_for_file: avoid_positional_boolean_parameters

import 'package:auto_mapper_annotation/auto_mapper.dart';
import 'package:equatable/equatable.dart';

part 'custom_mapping.g.dart';

@AutoMapper([
  // custom type
  MapType<CustomValueFromEmptyDto, CustomValueHolder>(
    fields: [
      Field('value', custom: CustomValue(42)),
    ],
  ),
  MapType<CustomValueFromEmptyDto, CustomValueHolderNamed>(
    fields: [
      Field('value', custom: CustomValue.named(420, xxx: 421)),
    ],
  ),
  MapType<CustomValueFromEmptyDto, CustomListValue>(
    fields: [
      Field(
        'list',
        custom: [
          CustomListValue([
            CustomListValue([CustomValue(1)]),
            CustomValue.named(2, xxx: 3)
          ])
        ],
      ),
    ],
  ),
  // from empty
  MapType<CustomValueFromEmptyDto, CustomValueFromEmpty>(
    fields: [
      Field('numValue', custom: 5),
      Field('intValue', custom: 123),
      Field('doubleValue', custom: 12.45),
      Field('stringValue', custom: 'test text'),
      Field('boolValue', custom: false),
      Field('listValue', custom: ['alpha', 3, true, null]),
      Field(
        'listListValue',
        custom: [
          ['alpha', 3],
          [true, null]
        ],
      ),
      Field('setValue', custom: {3, -1, 123, -888}),
      Field('mapValue', custom: {'alpha': 1, 'beta': 2, 'gama': 3}),
    ],
  ),
  MapType<CustomFunctionFromEmptyDto, CustomFunctionFromEmpty>(
    fields: [
      Field('numValue', custom: Mapper.emptyToNumValue),
      Field('intValue', custom: Mapper.emptyToIntValue),
      Field('doubleValue', custom: Mapper.emptyToDoubleValue),
      Field('stringValue', custom: Mapper.emptyToStringValue),
      Field('boolValue', custom: Mapper.emptyToBoolValue),
      Field('listValue', custom: Mapper.emptyToListValue),
      Field('listListValue', custom: Mapper.emptyToListListValue),
      Field('setValue', custom: Mapper.emptyToSetValue),
      Field('mapValue', custom: Mapper.emptyToMapValue),
    ],
  ),
  // from value
  MapType<CustomValuePositionalDto, CustomValuePositional>(
    fields: [
      Field('nameAndId', custom: r'''hello there, $obi "ben" wan'''),
    ],
  ),
  MapType<CustomValueNamedDto, CustomValueNamed>(
    fields: [
      Field('nameAndId', custom: 'hello "there" kenobi'),
    ],
  ),
  // from function
  MapType<CustomFunctionPositionalDto, CustomFunctionPositional>(
    fields: [
      Field('nameAndId', custom: Mapper.convertToNameAndIdPositional),
    ],
  ),
  MapType<CustomFunctionNamedDto, CustomFunctionNamed>(
    fields: [
      Field('nameAndId', custom: Mapper.convertToNameAndIdNamed),
    ],
  ),
])
class Mapper extends $Mapper {
  static num emptyToNumValue(CustomFunctionFromEmptyDto? _) => 1.2;

  static int emptyToIntValue(CustomFunctionFromEmptyDto? _) => 2;

  static double emptyToDoubleValue(CustomFunctionFromEmptyDto? _) => 74.58;

  static String emptyToStringValue(CustomFunctionFromEmptyDto? _) => 'some test';

  static bool emptyToBoolValue(CustomFunctionFromEmptyDto? _) => true;

  static List<Object?> emptyToListValue(CustomFunctionFromEmptyDto? _) => [null, true, 3, 8.6];

  static List<List<Object?>> emptyToListListValue(CustomFunctionFromEmptyDto? _) => [
        [null, 'xx'],
        [true, 3, 8.6],
      ];

  static Set<int> emptyToSetValue(CustomFunctionFromEmptyDto? _) => {1, 2, 3, 4, 5};

  static Map<String, int> emptyToMapValue(CustomFunctionFromEmptyDto? _) => {'one': 11, 'two': 22, 'three': 33};

  static String convertToNameAndIdPositional(CustomFunctionPositionalDto? dto) => '${dto?.name} #${dto?.id}';

  static String convertToNameAndIdNamed(CustomFunctionNamedDto? dto) => '${dto?.name} #${dto?.id}';
}

// custom type

class CustomValue extends Equatable {
  final int id;
  final int xxx;

  @override
  List<Object?> get props => [id, xxx];

  const CustomValue(this.id) : xxx = 0;

  const CustomValue.named(this.id, {required this.xxx});
}

class CustomListValue extends Equatable {
  final List<Object> list;

  @override
  List<Object?> get props => [list];

  const CustomListValue(this.list);
}

class CustomValueHolder extends Equatable {
  final CustomValue value;

  @override
  List<Object?> get props => [value];

  const CustomValueHolder(this.value);
}

class CustomValueHolderNamed extends Equatable {
  final CustomValue value;

  @override
  List<Object?> get props => [value];

  const CustomValueHolderNamed(this.value);
}

// empty

class CustomValueFromEmpty extends Equatable {
  final num numValue;
  final int intValue;
  final double doubleValue;
  final String stringValue;
  final bool boolValue;
  final List<Object?> listValue;
  final List<List<Object?>> listListValue;
  final Set<int> setValue;
  final Map<String, int> mapValue;

  @override
  List<Object?> get props => [
        numValue,
        intValue,
        doubleValue,
        stringValue,
        boolValue,
        listValue,
        listListValue,
        setValue,
        mapValue,
      ];

  const CustomValueFromEmpty(
    this.numValue,
    this.intValue,
    this.doubleValue,
    this.stringValue,
    this.boolValue,
    this.listValue,
    this.listListValue,
    this.setValue,
    this.mapValue,
  );
}

class CustomValueFromEmptyDto {
  const CustomValueFromEmptyDto();
}

class CustomFunctionFromEmpty extends Equatable {
  final num numValue;
  final int intValue;
  final double doubleValue;
  final String stringValue;
  final bool boolValue;
  final List<Object?> listValue;
  final List<List<Object?>> listListValue;
  final Set<int> setValue;
  final Map<String, int> mapValue;

  @override
  List<Object?> get props => [
        numValue,
        intValue,
        doubleValue,
        stringValue,
        boolValue,
        listValue,
        listListValue,
        setValue,
        mapValue,
      ];

  const CustomFunctionFromEmpty(
    this.numValue,
    this.intValue,
    this.doubleValue,
    this.stringValue,
    this.boolValue,
    this.listValue,
    this.listListValue,
    this.setValue,
    this.mapValue,
  );
}

class CustomFunctionFromEmptyDto {
  const CustomFunctionFromEmptyDto();
}

// positional and named

class CustomValuePositional extends Equatable {
  final String nameAndId;

  @override
  List<Object?> get props => [nameAndId];

  const CustomValuePositional(
    this.nameAndId,
  );
}

class CustomValuePositionalDto {
  final int id;
  final String name;

  const CustomValuePositionalDto(
    this.id,
    this.name,
  );
}

class CustomValueNamed extends Equatable {
  final String nameAndId;

  @override
  List<Object?> get props => [nameAndId];

  const CustomValueNamed({
    required this.nameAndId,
  });
}

class CustomValueNamedDto {
  final int id;
  final String name;

  const CustomValueNamedDto({
    required this.id,
    required this.name,
  });
}

class CustomFunctionPositional extends Equatable {
  final String nameAndId;

  @override
  List<Object?> get props => [nameAndId];

  const CustomFunctionPositional(
    this.nameAndId,
  );
}

class CustomFunctionPositionalDto {
  final int id;
  final String name;

  const CustomFunctionPositionalDto(
    this.id,
    this.name,
  );
}

class CustomFunctionNamed extends Equatable {
  final String nameAndId;

  @override
  List<Object?> get props => [nameAndId];

  const CustomFunctionNamed({
    required this.nameAndId,
  });
}

class CustomFunctionNamedDto {
  final int id;
  final String name;

  const CustomFunctionNamedDto({
    required this.id,
    required this.name,
  });
}
