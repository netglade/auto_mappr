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

* [Getting started](#getting-started)
  * [How to use](#how-to-use)
  * [Install](#install)
  * [Run the generator](#run-the-generator)
* [Features](#features)
  * ✅ [Primitive objects mapping](#primitive-objects-mapping)
  * ✅ [Complex objects mapping](#complex-objects-mapping)
  * ✅ [Field mapping](#field-mapping)
  * ✅ [Custom mapping](#custom-mapping)
  * ✅ [Ignore mapping](#ignore-mapping)
  * ✅ [List-like objects mapping](#list-like-objects-mapping)
  * ✅ [Map objects mapping](#map-objects-mapping)
  * ✅ [Default field value](#default-field-value)
  * ✅ [Default object value](#default-object-value)
  * ✅ [Constructor selection](#constructor-selection)
  * ✅ [Positional and named constructor parameters](#positional-and-named-constructor-parameters)
  * ✅ [Mapping to target](#mapping-to-target)
  * ✅ [Mapping from source](#mapping-from-source)
  * ✅ [Nullability handling](#nullability-handling)
  * ✅ [Works with `equatable`](#works-with-equatable)
  * ✅ [Works with `json_serializable`](#works-with-jsonserializable)
* [Customizing the build](#customizing-the-build)
* [Contributing](#contributing)

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

### Install

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
First method is a method with non-nullable return type `TARGET`.
Second method is a method with nullable return type `TARGET?`
that is being generated only when other methods use it.
If the object mapping has `whenSourceIsNull` parameter set,
the nullable method is not generated.

Note that `convert` cannot return `null`.
The value `null` can only be returned for nested object mappings.

### Works with `equatable`

Mapping works with the Equatable package.
Some mapping tools tries to map the `props` getter,
but since AutoMappr maps only to public explicit or implicit setters,
Equatable and other packages with similar conditions implicitly works.

### Works with `json_serializable`

AutoMappr uses a `SharedPartBuilder`.
That means it can share the `.g.dart` file with packages like JSON Serializable
to generate other code to the generated super class.

## Customizing the build

By default, AutoMappr uses the `auto_mappr:auto_mappr` builder
that works with `SharedPartBuilder`, which generates combined `.g.dart` files.
If you need to use `PartBuilder` to generate not-shared `.auto_mappr.dart` part files,
you can use the `auto_mappr:not_shared` builder.

Modify your `build.yaml` file:

```yaml
targets:
  $default:
    # You can disable all default builders.
    auto_apply_builders: false
    builders:
      # Or disable specific ones.
      auto_mappr:
        enabled: false
      # And enable the not_shared builder.
      auto_mappr:not_shared:
        enabled: true
```

If you are using packages like `Drift`
which generates classes you need to use as a source or a target in your mappings,
use their not-shared builder, if they have any.
With that, the builder can generate files like `.drift.dart`
which you can add a input dependency to.
Specify the `required_inputs` dependency on your local AutoMappr builder
and disable the builders provided by AutoMappr.

Shared builder:

```yaml
targets:
  $default:
    # Disable the default generators (or disable the default builders you don't want to use).
    auto_apply_builders: false
    builders:
      # Enable their generators according to their documentation.
      drift_dev:not_shared:
        enabled: true
      drift_dev:preparing_builder:
        enabled: true
      # Enable local shared AutoMappr builder defined below.
      :auto_mappr:
        enabled: true

# Local builders.
builders:
  auto_mappr:
    required_inputs: [".drift.dart"] # <-- here are your dependencies
    import: "package:auto_mappr/builder.dart"
    builder_factories: ["autoMapprBuilder"]
    build_extensions: { ".dart": [".auto_mappr.g.part"] }
    auto_apply: none
    build_to: cache
    applies_builders: ["source_gen:combining_builder"]
```

Not shared builder:

```yaml
targets:
  $default:
    # Disable the default generators (or disable the default builders you don't want to use).
    auto_apply_builders: false
    builders:
      # Enable their generators according to their documentation.
      drift_dev:not_shared:
        enabled: true
      drift_dev:preparing_builder:
        enabled: true
      # Enable local not-shared AutoMappr builder defined below.
      :auto_mappr:not_shared:
        enabled: true

# Local builders.
builders:
  not_shared:
    required_inputs: [".drift.dart"] # <-- here are your dependencies
    import: "package:auto_mappr/builder.dart"
    builder_factories: ["autoMapprBuilderNotShared"]
    build_extensions: { ".dart": ["auto_mappr.dart"] }
    auto_apply: none
    build_to: source
```

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
