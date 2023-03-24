# AutoMappr

<a href="https://netglade.com/en">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/netglade/.github/main/assets/netglade_logo_light.png">
    <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/netglade/.github/main/assets/netglade_logo_dark.png">
    <img alt="netglade" src="https://raw.githubusercontent.com/netglade/.github/main/assets/netglade_logo_dark.png">
  </picture>
</a>

Developed with 💚 by [netglade][netglade_link]

[![auto_mappr][auto_mappr_pub_badge]][auto_mappr_pub_link]
[![build][build_badge]][build_badge_link]
[![license: MIT][license_badge]][license_badge_link]
[![style: netglade analysis][style_badge]][style_badge_link]

---

A mapper that maps between different objects with ease.
Heavily inspired by [C# AutoMapper][auto_mapper_net_link].

Thanks to code generation, you can generate AutoMappr classes,
which will allow mapping between different objects automatically
without the need to write these mapping by hand.

## Feature list

- ✅ [primitive objects mapping](#primitive-objects-mapping)
- ✅ [complex objects mapping](#complex-objects-mapping)
- ✅ [field mapping](#field-mapping)
- ✅ [custom mapping](#custom-mapping)
- ✅ [ignoring mapping](#custom-mapping)
- ✅ [list-like objects mapping](#list-like-objects-mapping)
- ✅ [maps objects mapping](#map-objects-mapping)
- ✅ [default field value](#default-field-value)
- ✅ [default object value](#default-object-value)
- ✅ [constructor selection](#constructor-selection)
- ✅ [positional and named constructor parameters](#positional-and-named-constructor-parameters)
- ✅ [mapping to target (constructor parameters or public setters)](#mapping-to-target)
- ✅ [mapping from source (public instance or static getters)](#mapping-from-source)
- ✅ [nullability handling](#nullability-handling)
- ✅ [works with `equatable`](#works-with-equatable)
- ✅ [works with `json_serializable`](#works-with-jsonserializable)

## Getting started

### How to use

Create a mapping class with `@AutoMappr` annotation.
You will also need to import the annotation.

```dart
import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

part 'my_file.g.dart';

@AutoMappr([
  MapType<UserDto, User>(
    fields: [
      Field('name', target: Mappr.mapName),
      Field('age', target: mapAge),
      Field('tag', ignore: true)
    ],
  ),
])
class Mappr extends $Mappr {
  static String mapName(UserDto dto) => dto.name.toUpperCase();
}

int mapAge(UserDto _) => 55;
```

## Install

To use AutoMappr, install these three packages:

- [`build_runner`](https://pub.dev/packages/build_runner) -- the tool to run code-generators
- [`auto_mappr`](https://pub.dev/packages/auto_mappr) -- the AutoMappr code generator
- [`auto_mappr_annotation`](https://pub.dev/packages/auto_mappr_annotation) -- the AutoMappr annotation

For a Flutter project:

```shell
flutter pub add auto_mappr_annotation
flutter pub add --dev build_runner
flutter pub add --dev auto_mappr
```

For a Dart project:

```shell
dart pub add auto_mappr_annotation
dart pub add --dev build_runner
dart pub add --dev auto_mappr
```

### Run the generator

For a Flutter project:

```shell
flutter pub run build_runner build
```

For a Dart project:

```shell
dart run build_runner build
```

## Features

### Primitive objects mapping

Primitive objects like `num`, `int`, `double`, `String`, `bool`, `Symbol`, `Type`, and `null`
are copied to target object with no additional processing.

### Complex objects mapping

Complex (or nested) objects are mapped according to their `MapType<SOURCE, TARGET>()` mapping setup.
The generator generates mapping methods for each `MapType`.
These mapping methods are used in nested objects.

### Field mapping

When target and source fields' name do not match,
you can change source field by using the `from` argument in a `Field()` mapping.
Alternatively, you can use the `Field.from()` constructor
which hides other then-invalid parameters. 

```dart
@AutoMappr([
  MapType<UserDto, User>(
    fields: [
      Field('name', from: 'myName'),
      Field.from('age', from: 'myAge'),
    ],
  ),
])
class Mappr extends $Mappr {}
```

### Custom mapping

When you need to assign a custom function or a const value as a value for given target field,
you can use the `custom` argument in a `Field` mapping.
Alternatively, you can use the `Field.custom()` constructor
which hides other then-invalid parameters.

You can set up `Target Function(Source dto)` function or `const Target` value.

```dart
@AutoMappr([
  MapType<UserDto, User>(
    fields: [
      Field('name', custom: Mappr.mapName), // Static Mappr method.
      Field('age', custom: mapAge), // Global method.
      Field.custom('note', custom: 'constant value'), // Constant value.
    ],
  ),
])
class Mappr extends $Mappr {
  static String mapName(UserDto dto) => dto.name.toUpperCase();
}

int mapAge(UserDto _) => 42;
```

### Ignore mapping

To completely ignore some target field,
so it is not mapped into a constructor or into a setter,
you can use the `ignore` argument in a `Field` mapping.
Alternatively, you can use the `Field.ignore()` constructor
which hides other then-invalid parameters.

```dart
@AutoMappr([
  MapType<UserDto, User>(
    fields: [
      Field('name', ignore: true),
      Field.ignore('age', ignore: true),
    ],
  ),
])
class Mappr extends $Mappr {}
```

### List-like objects mapping

Values in list-like collections like `List`, `Set`, or `Iterable`
are mapped using the `.map()` method when the values are complex types.
When needed, mostly after mapping, `.toList()` or `.toSet()` methods are called
to cast an `Iterable` into a `List`/`Set`. 

### Map objects mapping

Maps are a specific case of `Iterable`s,
that has to be handled a bit differently.
For example, we must make sure that both keys and values of `MapEntry` are mapped correctly
based on whether they are primitive or complex types.

### Default field value

To make sure that a default value is assigned to a target field
when a source field is `null`
you can set up a `whenNull` property on `Field`
which takes a constant value of target field type.

You can set up default field value
by using `Target Function()` function or `const Target` value
on `Field`, `Field.from`, and `Field.custom`, constructors but not on `Field.ignore` constructor.

```dart
@AutoMappr([
  MapType<UserDto, User>(
    fields: [
      Field('name', whenNull: 'John Smith'),
    ],
  ),
])
class Mappr extends $Mappr {}
```

### Default object value

When the whole source object is null,
you can set up a default value for it using the `whenSourceIsNull` property on `MapType`.
It can also take a constant value of target object type.

You can set up `Target Function()` function or `const Target` value.

```dart
@AutoMappr([
  MapType<UserDto, User>(
    whenSourceIsNull: User(name: 'Neo', age: 28),
  ),
])
class Mappr extends $Mappr {}
```

### Constructor selection

The mapping automatically selects a constructor with the most parameters.
When you want to specifically select a certain constructor,
set the `constructor` property on `MapType`.

Imagine that you have a `User(String name, int age, String note)`
and `User.fromDto(String name, int age)` constructors.
Default algorithm selects the default constructor because it has the most parameters.
To change the selected constructor, do:

```dart
@AutoMappr([
  MapType<UserDto, User>(
    constructor: 'fromDto',
  ),
])
class Mappr extends $Mappr {}
```

### Positional and named constructor parameters

The mapping automatically assigns source getters to constructor parameters
no matter if they are positional or named.

### Mapping to target

Mapping into a target object can be done in two places.
First, the mapping tries to map all the fields to selected constructor.
And for the target fields that have not been mapped,
it tries to set them using public setters (both explicit ones or implicit ones created by fields),
if they have any.

### Mapping from source

Mapping from a source object can be done from either public getters or static getters.
Getters can be both explicit ones or implicit ones created by fields.

### Nullability handling

For each `MapType<SOURCE, TARGET>()` mapping the generator generates at most two mapping methods.
One with nullable return type `TARGET?`, second with non-nullable return type `TARGET`.
If the mapping has `MapType.whenSourceIsNull` set, the nullable method is not generated.

### Works with `equatable`

Mapping works with the Equatable package.
Some mapping tools tries to map the `props` getter,
but since AutoMappr maps only to public explicit or implicit setters,
Equatable and other packages with similar conditions implicitly works.

### Works with `json_serializable`

AutoMappr uses a `SharedPartBuilder`.
That means it can share the `.g.dart` file with packages like JSON Serializable
to generate other code to the generated super class.

## Contributing

Your contributions are always welcome! Feel free to open pull request.

[netglade_link]: https://netglade.com/en

[build_badge]: https://github.com/netglade/auto_mappr/actions/workflows/build.yaml/badge.svg
[build_badge_link]: https://github.com/netglade/auto_mappr/actions

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_badge_link]: https://opensource.org/licenses/MIT

[style_badge]: https://img.shields.io/badge/style-netglade_analysis-26D07C.svg
[style_badge_link]: https://pub.dev/packages/netglade_analysis

[auto_mappr_pub_badge]: https://img.shields.io/pub/v/auto_mappr.svg
[auto_mappr_pub_link]: https://pub.dartlang.org/packages/auto_mappr

[auto_mappr_annotation_pub_badge]: https://img.shields.io/pub/v/auto_mappr_annotation.svg
[auto_mappr_annotation_pub_link]: https://pub.dartlang.org/packages/auto_mappr_annotation

[auto_mapper_net_link]: https://automapper.org
