<a href="https://github.com/netglade">
  <picture >
    <source media="(prefers-color-scheme: dark)" height='120px' srcset="https://raw.githubusercontent.com/netglade/auto_mappr/main/packages/auto_mappr/doc/badge_light.png">
    <source media="(prefers-color-scheme: light)" height='120px' srcset="https://raw.githubusercontent.com/netglade/auto_mappr/main/packages/auto_mappr/doc/badge_dark.png">
    <img alt="netglade" height='120px' src="https://raw.githubusercontent.com/netglade/auto_mappr/main/packages/auto_mappr/doc/badge_dark.png">
  </picture>
</a>

Developed with 💚 by [netglade][netglade_link]

[![ci][ci_badge]][ci_badge_link]
[![auto_mappr][auto_mappr_pub_badge]][auto_mappr_pub_badge_link]
[![license: MIT][license_badge]][license_badge_link]
[![style: netglade analysis][style_badge]][style_badge_link]
[![Discord][discord_badge]][discord_badge_link]

---

A mapper that maps between different objects with ease.
Heavily inspired by [C# AutoMapper][auto_mapper_net_link].

* [👀 What is this?](#-what-is-this)
* [🚀 Getting started](#-getting-started)
    * [How to use](#how-to-use)
    * [Install](#install)
    * [Run the generator](#run-the-generator)
* [✨ Features](#-features)
    * ✅ [Primitive objects mapping](#primitive-objects-mapping)
    * ✅ [Complex objects mapping](#complex-objects-mapping)
    * ✅ [Field mapping](#field-mapping)
    * ✅ [Custom mapping](#custom-mapping)
    * ✅ [Ignore mapping](#ignore-mapping)
    * ✅ [Iterable objects mapping](#iterable-objects-mapping)
    * ✅ [Map objects mapping](#map-objects-mapping)
    * ✅ [Default field value](#default-field-value)
    * ✅ [Default object value](#default-object-value)
    * ✅ [Constructor selection](#constructor-selection)
    * ✅ [Enum mapping](#enum-mapping)
    * ✅ [Positional and named constructor parameters](#positional-and-named-constructor-parameters)
    * ✅ [Mapping to target](#mapping-to-target)
    * ✅ [Mapping from source](#mapping-from-source)
    * ✅ [Nullability handling](#nullability-handling)
    * ✅ [Generics](#generics)
    * ✅ [Modules](#modules)
    * ✅ [Works with `equatable`](#works-with-equatable)
    * ✅ [Works with `json_serializable`](#works-with-jsonserializable)
    * ✅ [Works with generated source and target classes](#works-with-generated-source-and-target-classes)
* [⚙️ Customizing the build](#-customizing-the-build)
* [👏 Contributing](#-contributing)

## 👀 What is this?

AutoMappr is a code-generation package that helps
with writing object-to-object mappings,
so you don't have to write code by hand.

These mappings work by analyzing source and target objects
and creating mapping to selected constructor and setter fields.
That is done by code generation,
which moves mapping overload from runtime to pre-compile time,
so your code is as fast, predictable, and debuggable
as if you write it yourself.

The only thing you have to do to make it work is
create a mappr class and annotate it with a `@AutoMappr` annotation.
Then for each object mapping,
set up a mapping between a source and a target type of those objects
like this: `MapType<Source, Target>()`.
This set up the automatic mapping of matching fields.
Check the [getting started](#-getting-started) section to learn more about
the technical details.
While AutoMappr has a lot of customizations,
it should work in most cases automatically for you.
Despite that, you can still configure
default values and custom mappings for both objects and fields,
ignoring unwanted fields, setting a rename,
forcing a selected constructor etc.

### Why should you use it?

Mapping objects to other objects can be for sure done by hand.
While it works, it's incredibly boring.
Most of the time, object mapping can occur in places like mapping
network DTOs from/to domain layer's models,
domain layer's models from/to UI models,
etc.
In other words: if you care about code segregation and single responsibility,
you do a lot of mappings.
Tools like AutoMappr can help you with reducing boilerplate code
and reduce the time you would spend on mapping objects
or updating the mappings.

## 🚀 Getting started

### How to use

Create a mapping class with `@AutoMappr` annotation.
You will also need to import the annotation.
Then use `MapType<Source, Target>()` for each mapping.

```dart
import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

part 'my_file.g.dart';

@AutoMappr([
  MapType<UserDto, User>(),
])
class Mappr extends $Mappr {}
```

Depending on your needs, it can also be heavily customized.
Below you can see just some of its options.
See [features](#-features) for a complete list.

```dart
import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

part 'my_file.g.dart';

@AutoMappr([
  MapType<UserDto, User>(
    fields: [
      Field('address', from: 'userAddress'),
      Field('fullName', custom: Mappr.mapFullName),
      Field('age', custom: 42),
      Field('tag', ignore: true)
    ],
  ),
])
class Mappr extends $Mappr {
  static String mapFullName(UserDto dto) => '${dto.firstName} ${dto.lastName}';
}
```

To actually use the mappr in your code,
call the `convert` method on it's instance.
Note that the convert function has two generic parameters — source and target.
AutoMappr uses type inference to determine which mapping to use,
therefore you should care about a strict type inference.
Either assign the result of converting to an explicitly typed variable
or explicitly state generics.
The function cannot infer the generic parameters just from the source parameter.

It should look like this:

```dart
void main() {
  final mappr = Mappr();

  // convert like this
  User user = mappr.convert(UserDto(...));

  // or like this
  final user2 = mappr.convert<UserDto, User>(UserDto(...));
}
```

To make the Dart analyzer help you with inference failures,
you can set up the analyzer in the `analysis_options.yaml` file.
I would also suggest to use some predefined list of lints and analysis settings such as
[very_good_analysis](https://pub.dev/packages/very_good_analysis)
or our [netglade_analysis](https://pub.dev/packages/netglade_analysis).

```yaml
analyzer:
  language:
    strict-casts: true
    strict-inference: true
    strict-raw-types: true
```

#### `convert` vs `tryConvert`

The `convert` and `tryConvert` works the same.
The only difference is that if a `null` value is passed inside as the argument,
and `whenSourceIsNull` is not set for the mapping,
`convert` will throw an exception while `tryConvert` will return `null`.
Therefore, `convert` has a return type `TARGET` and `tryConvert` has a return type `TARGET?`.
It is an analogy with `parse` and `tryParse` methods on `int`.

#### `try/convert{Iterable, List, Set}`

If you have an iterable of source objects
and need to transfer them into an iterable of target objects,
use either `convertIterable`, `convertList`, or `convertSet`.
What to choose depends on what iterable type you need as an output:

- If you need the output as `Iterable<Target>`, use `convertIterable`.
- If you need the output as `List<Target>`, use `convertList`.
- If you need the output as `Set<Target>`, use `convertSet`.

All of these function also have generics as `<SOURCE, TARGET>`,
where the source and the target are the types of those inner objects.

If you need output of nullable objects in an iterable,
use `tryConvert{Iterable, List, Set}` versions.

### Install

To use AutoMappr, install these three packages:

- [`build_runner`](https://pub.dev/packages/build_runner) -- the tool to run code-generators
- [`auto_mappr`](https://pub.dev/packages/auto_mappr) -- the AutoMappr code generator
- [`auto_mappr_annotation`](https://pub.dev/packages/auto_mappr_annotation) -- the AutoMappr
  annotation

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

## ✨ Features

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

### Iterable objects mapping

Values in iterables like `List`, `Set`, or `Iterable`
are mapped using the `.map()` method when the values are complex types.
When needed, mostly after mapping, `.toList()` or `.toSet()` methods are called
to cast an `Iterable` into a `List`/`Set`.

#### Specialized variants of `List<int>`

AutoMappr will automatically convert between `List<int>` and its specialized variants `Uint8List`, `Uint16List`, `Uint32List` and `Uint64List`.  

Convesion between these specialized variants are not handled and its developer responsibility to configure mapping. 

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

When you want to specifically select a certain constructor,
set the `constructor` property on `MapType`.
Otherwise the mapping automatically selects a constructor with the most parameters.
It prioritizes non factory constructors over factory ones
and never selects `fromJson` factory constructor.

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

### Enum mapping

AutoMappr also supports mapping of enums.
You register them as usual with `MapType<SourceEnum, TargetEnum`>
and AutoMappr will convert enum options based on name.

The target enum can either be a superset of the source
or has to define `whenSourceIsNull` which will be used for unknown enum values.
If the target is not a superset of the source enum the generator will throw.

E.g. in the example below, `RemotePerson.alien` will be mapped
to `LocalPerson.unknown`.

```dart
enum RemotePerson { student, employee, alien }
enum LocalPerson { student, employee, unknown }

@AutoMappr([
  MapType<RemotePerson, LocalPerson>(
    whenSourceIsNull: LocalPerson.unknown,
  ),
])
class Mappr extends $Mappr {}
```

Mapping works for both simple and enhanced enums.

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

### Generics

AutoMappr can handle generics, so you can map objects with type arguments with ease.

```dart
@AutoMappr([
  MapType<SomeObjectDto<num>, SomeObject<num>>(),
  MapType<SomeObjectDto<int>, SomeObject<int>>(),
  MapType<SomeObjectDto<String>, SomeObject<String>>(),
])
class Mappr extends $Mappr {}
```

Type parameters are not limited.
You can use them as a direct type,
in a nested object types,
in collections, ...
AutoMappr will automatically handles them for you.

```dart
class Something<A, B, C> {
  final A first;
  final Nested<A, B> second;
  final List<C> third;
  final List<Nested<A, C>> fourth;
// ...
}

class Nested<X, Y> {
  final X alpha;
  final Y beta;
// ...
}
```

### Modules

Each AutoMappr class can be used as a **module**.
That means a mappr used inside of another mappr.
Each AutoMappr class can include a list of modules
that can be used to nest modules
and use all of its underlying mappings.

Applications are often split into independent parts (we will call them **features**).
Each feature should probably have its own independent mappr,
that is used as a module.

Imagine that in a feature you have a local mappr `UserMappr`.

```dart
// file: user_mappr.dart
@AutoMappr([
  MapType<UserDto, User>(),
])
class UserMappr extends $UserMappr {
  const UserMappr(); // must implement const constructor
}
```

And in some global place,
you can have a main mappr that unifies all smaller mapprs
(`UserMappr` in this case).
As usual, it can also set it's own mappings
(`MapType<GroupDto, Group>()`).

```dart
// file: main_mappr.dart
@AutoMappr(
  [
    MapType<GroupDto, Group>(),
  ],
  modules: [
    UserMappr(), // use module
  ],
)
class MainMappr extends $MainMappr {}
```

Then you can use this main mappr to map between objects specified from every included mappr.

```dart
final mappr = MainMappr();

final Group user = mappr.convert(GroupDto(...)); // from this mappr
final User user = mappr.convert(UserDto(...)); // from included mappr
```

That can be handy for example with dependency injection,
so you can only provide one grouping/main mappr that can handle everything.
Each feature in your app can return an instance of const `AutoMapprInterface`,
that each mappr internally implements.

### Works with `equatable`

Mapping works with the Equatable package.
Some mapping tools tries to map the `props` getter,
but since AutoMappr maps only to public explicit or implicit setters,
Equatable and other packages with similar conditions implicitly works.

### Works with `json_serializable`

AutoMappr uses a `SharedPartBuilder`.
That means it can share the `.g.dart` file with packages like JSON Serializable
to generate other code to the generated super class.

### Works with generated source and target classes

Mapping can be set up for source or target classes
which are generated by another package,
like Drift.
For that, you have to [customize a builder](#-customizing-the-build)
to set custom dependencies on the other package's outputs.

You can also use this package as an output for another package's builder.
Disable the default `auto_mappr` builder
and enable the `auto_mappr:not_shared` builder.
Check the [customizing the build](#-customizing-the-build) chapter to learn more.

## ⚙ Customizing the build

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

### Default dependencies

By default both `auto_mappr` builders has defined required inputs for freezed
and drift classes.

```yaml
 required_inputs: [".freezed.dart", ".drift.dart"]
```

This allows to depend on generated classes from these packages without need to modify project's build.yaml.

#### Drift integration

If you are using packages like `Drift` which generates classes you need to use as a source or a target in your mappings,
use their not-shared builder, if they have any.
With that, the builder can generate files like `.drift.dart`
which you can add a input dependency to.
Specify the `required_inputs` dependency on your local AutoMappr builder
and disable the builders provided by AutoMappr.

Shared builder:

```yaml
targets:
  $default:
    auto_apply_builders: true
    builders:
      # Enable their generators according to their documentation.
      drift_dev:not_shared:
        enabled: true
      drift_dev:preparing_builder:
        enabled: true
      # Disable Drift's shared builder
      drift_dev:drift_dev:
        enabled: false
```

Not shared builder:

```yaml
targets:
  $default:
    auto_apply_builders: true
    builders:
      # Enable their generators according to their documentation.
      drift_dev:not_shared:
        enabled: true
      drift_dev:preparing_builder:
        enabled: true
      # Disable Drift's shared builder
      drift_dev:drift_dev:
        enabled: false

      auto_mappr:
        enabled: false
      # Enable the not_shared builder.
      auto_mappr:not_shared:
        enabled: true
```

## 👏 Contributing

Your contributions are always welcome! Feel free to open pull request.

[netglade_link]: https://netglade.com/en
[ci_badge]: https://github.com/netglade/auto_mappr/actions/workflows/ci.yaml/badge.svg
[ci_badge_link]: https://github.com/netglade/auto_mappr/actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_badge_link]: https://opensource.org/licenses/MIT
[style_badge]: https://img.shields.io/badge/style-netglade_analysis-26D07C.svg
[style_badge_link]: https://pub.dev/packages/netglade_analysis
[auto_mappr_pub_badge]: https://img.shields.io/pub/v/auto_mappr.svg
[auto_mappr_pub_badge_link]: https://pub.dartlang.org/packages/auto_mappr
[discord_badge]: https://img.shields.io/discord/1091460081054400532.svg?logo=discord&color=blue
[discord_badge_link]: https://discord.gg/sJfBBuDZy4

[auto_mapper_net_link]: https://automapper.org
