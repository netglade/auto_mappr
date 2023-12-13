// ignore_for_file: avoid_positional_boolean_parameters, prefer-named-boolean-parameters

import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'custom_mapping.auto_mappr.dart';

@AutoMappr([
  // custom type
  MapType<CustomValueFromEmptyDto, CustomValueHolder>(
    fields: [Field.custom('value', custom: CustomValue(42))],
  ),
  MapType<CustomValueFromEmptyDto, CustomValueHolderNamed>(
    fields: [
      Field.custom('value', custom: CustomValue.named(420, xxx: 421)),
    ],
  ),
  MapType<CustomValueFromEmptyDto, CustomListValue>(
    fields: [
      Field.custom(
        'list',
        custom: [
          CustomListValue([
            CustomListValue([CustomValue(1)]),
            CustomValue.named(2, xxx: 3),
          ]),
        ],
      ),
    ],
  ),
  // from empty
  MapType<CustomValueFromEmptyDto, CustomValueFromEmpty>(
    fields: [
      Field.custom('numValue', custom: 5),
      Field.custom('intValue', custom: 123),
      Field.custom('doubleValue', custom: 12.45),
      Field.custom('stringValue', custom: 'test text'),
      Field.custom('boolValue', custom: false),
      Field.custom('listValue', custom: ['alpha', 3, true, null]),
      Field.custom(
        'listListValue',
        custom: [
          ['alpha', 3],
          [true, null],
        ],
      ),
      Field.custom('setValue', custom: {3, -1, 123, -888}),
      Field.custom('mapValue', custom: {'alpha': 1, 'beta': 2, 'gama': 3}),
    ],
  ),
  MapType<CustomFunctionFromEmptyDto, CustomFunctionFromEmpty>(
    fields: [
      Field.custom('numValue', custom: Mappr.emptyToNumValue),
      Field.custom('intValue', custom: Mappr.emptyToIntValue),
      Field.custom('doubleValue', custom: Mappr.emptyToDoubleValue),
      Field.custom('stringValue', custom: Mappr.emptyToStringValue),
      Field.custom('boolValue', custom: Mappr.emptyToBoolValue),
      Field.custom('listValue', custom: Mappr.emptyToListValue),
      Field.custom('listListValue', custom: Mappr.emptyToListListValue),
      Field.custom('setValue', custom: Mappr.emptyToSetValue),
      Field.custom('mapValue', custom: Mappr.emptyToMapValue),
      Field.custom('dateValue', custom: Mappr.dateTimeFixed),
    ],
  ),
  // from value
  MapType<CustomValuePositionalDto, CustomValuePositional>(
    fields: [
      Field.custom('nameAndId', custom: r'''hello there, $obi "ben" wan'''),
    ],
  ),
  MapType<CustomValueNamedDto, CustomValueNamed>(
    fields: [Field.custom('nameAndId', custom: 'hello "there" kenobi')],
  ),
  // from function
  MapType<CustomFunctionPositionalDto, CustomFunctionPositional>(
    fields: [
      Field.custom('nameAndId', custom: Mappr.convertToNameAndIdPositional),
    ],
  ),
  MapType<CustomFunctionNamedDto, CustomFunctionNamed>(
    fields: [
      Field.custom('nameAndId', custom: Mappr.convertToNameAndIdNamed),
    ],
  ),
])
class Mappr extends $Mappr {
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

  static DateTime dateTimeFixed() => DateTime(2023);
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
  final DateTime dateValue;

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
        dateValue,
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
    this.dateValue,
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

  const CustomValuePositional(this.nameAndId);
}

class CustomValuePositionalDto {
  final int id;
  final String name;

  const CustomValuePositionalDto(this.id, this.name);
}

class CustomValueNamed extends Equatable {
  final String nameAndId;

  @override
  List<Object?> get props => [nameAndId];

  const CustomValueNamed({required this.nameAndId});
}

class CustomValueNamedDto {
  final int id;
  final String name;

  const CustomValueNamedDto({required this.id, required this.name});
}

class CustomFunctionPositional extends Equatable {
  final String nameAndId;

  @override
  List<Object?> get props => [nameAndId];

  const CustomFunctionPositional(this.nameAndId);
}

class CustomFunctionPositionalDto {
  final int id;
  final String name;

  const CustomFunctionPositionalDto(this.id, this.name);
}

class CustomFunctionNamed extends Equatable {
  final String nameAndId;

  @override
  List<Object?> get props => [nameAndId];

  const CustomFunctionNamed({required this.nameAndId});
}

class CustomFunctionNamedDto {
  final int id;
  final String name;

  const CustomFunctionNamedDto({required this.id, required this.name});
}
