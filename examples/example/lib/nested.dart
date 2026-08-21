// ignore_for_file: always_put_required_named_parameters_first

import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:examples_example/nested.auto_mappr.dart';

@AutoMappr([
  MapType<UserDto, User>(),
  MapType<NestedDto, Nested>(),
  MapType<NestedTagDto, NestedTag>(),
])
class Mappr extends $Mappr {}

class User with EquatableMixin {
  final int id;
  final Nested name;
  final NestedTag? tag;
  final List<Nested> nestedItems;
  final List<Nested> nestedItemsNullable;
  final List<Nested>? nestedItemsNullable2;
  final List<Nested> itemsWithNullableItem;
  final List<Nested?> itemsWithNullableItem2;

  bool get hasTag => tag != null;

  const User({
    required this.id,
    required this.name,
    required this.tag,
    required this.nestedItems,
    required this.nestedItemsNullable,
    this.nestedItemsNullable2,
    required this.itemsWithNullableItem,
    required this.itemsWithNullableItem2,
  });

  @override
  List<Object?> get props => [id, name, tag];
}

class Nested {
  final int id;
  final String name;
  final NestedTag tag;

  Nested({
    required this.id,
    required this.name,
    required this.tag,
  });
}

class NestedTag {}

class UserDto {
  final int id;
  final NestedDto name;
  final int age;
  final List<NestedDto> nestedItems;
  final List<NestedDto>? nestedItemsNullable;
  final List<NestedDto> nestedItemsNullable2;
  final List<NestedDto?> itemsWithNullableItem;
  final List<NestedDto> itemsWithNullableItem2;

  UserDto({
    required this.id,
    required this.name,
    required this.age,
    required this.nestedItems,
    this.nestedItemsNullable,
    required this.nestedItemsNullable2,
    required this.itemsWithNullableItem,
    required this.itemsWithNullableItem2,
  });
}

class NestedDto {
  final int id;
  final String name;
  final NestedTagDto tag;

  NestedDto(
    this.id, {
    required this.name,
    required this.tag,
  });
}

class NestedTagDto {}
