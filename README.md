# AutoMappr

<a href="https://netglade.cz/en">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/netglade/.github/main/assets/netglade_logo_light.png">
    <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/netglade/.github/main/assets/netglade_logo_dark.png">
    <img alt="netglade" src="https://raw.githubusercontent.com/netglade/.github/main/assets/netglade_logo_dark.png">
  </picture>
</a>

Developed with 💚 by [netglade][netglade_link]

[![ci][ci_badge]][ci_badge_link]
[![license: MIT][license_badge]][license_badge_link]
[![style: netglade analysis][style_badge]][style_badge_link]

---

Mapper for mapping between different objects with ease.
Heavily inspired by [C# AutoMapper][auto_mapper_net_link].

Thanks to code-generation you can generate class, called mapper,
which will allow to map between different objects automatically
without need to write these mapping by hand.

| Package                                                 | Pub                                                                                                 |
|---------------------------------------------------------|-----------------------------------------------------------------------------------------------------|
| [auto_mappr](packages/auto_mappr)                       | [![auto_mappr package][auto_mappr_pub_badge]][auto_mappr_pub_link]                                  |
| [auto_mappr_annotation](packages/auto_mappr_annotation) | [![auto_mappr_annotation package][auto_mappr_annotation_pub_badge]][auto_mappr_annotation_pub_link] |

## Features

todos:

- [ ] log.warning when mapping to unknown target field
- [ ] what should `canReturnNull` do, how to handle `as TARGET` etc.
  - add _convertXxxToYyy__Nullable - nested values can use this when nullable

critical:

- [x] primitive types (num, int, double, string, bool) + enum
- [x] iterable types 
  - [x] iterable
  - [x] list
  - [x] set
  - [x] map
- [x] complex/nested types
- [x] renaming
- [x] custom mapping - functions or const values
- [x] when null default - field
- [x] when null default - target
- [x] constructor parameters (positional, named)
- [x] mapping to target (1. to constructor parameters, 2. to public fields and setters that have not been set)
- [x] mapping from source (public fields or getters of either instance or static)
- [x] selecting constructor
- [x] works with Equatable
- [x] works with JSON serializable

nice to have:

- [ ] if no 1:1 mapping found, try to find some case insensitive or different letter type names,
  - for example: 'auto' would be matched from 'Auto', 'AUTO', 'áuto', 'aútó', ...    
- [ ] implicit mappings of nested
- [ ] consider generics (we can access it, but we do not use it)
- [ ] improved better-fitted constructor selector (factory constructors etc.)
- [ ] flattening
- [ ] enum type
- [ ] reverse mapping
- [ ] member name doesn't match constructor argument name

## Get started

Add `builder_runner` and `auto_mappr` as dev dependency

```yaml
dev_dependencies:
  auto_mappr: ^0.0.1
  build_runner: 
```

and `auto_mappr_annotation` as dependency for annotations

```yaml
dependencies:
  auto_mappr_annotation: ^0.1.0
```

Define you mapper

```dart
@AutoMappr([
  AutoMap<UserDto, User>(),
  AutoMap<CompanyDto, CompanyAddress>(),
])
class ExampleMapper extends $ExampleMapper {}
```

run build_runner

```
dart run build_runner build
```

use your mapper

```dart

final userDto = await

getUserDto();

final mapper = ExampleMapper();
final user = mapper.convert(userDto);

```

## Configuration

Each mapping between two objects, from SOURCE to TARGET is done with `AutoMap<SOURCE, TARGET>`
class.

You can set these properties on each AutoMap:

- `whenNullDefault` - callback which returns default value for TARGET if SOURCE is null. Used only
  if SOURCE is marked as nullable, e.g. `AutoMap<SOURCE?, TARGET>`.

### Custom member mapping

For each mapped member you can specify how it should be mapped. For example:

```dart
@AutoMappr([
  MapType<UserDto, User>(
    mappings: [
      Field('name', target: Mapper.mapName),
      Field('age', target: mapAge),
      Field('tag', ignore: true)
    ],
  ),
])
class Mapper extends $Mapper {
  static String mapName(UserDto from) => from.name.toUpperCase();
}

// ignore: prefer-static-class, for test
int mapAge(UserDto _) => 55;
```

Note that `member` parameter should match either TARGET's member name OR constructor parameter
name (In most cases they are same).

`target` property is optional mapping function which can define custom mapping logic from SOURCE.

`ignore` - if `true` member will be ignored. Note that nullability cases are handled as well. (e.g.
Target is nullable but required parameter, mapper will assing null automatically).

### Null handling

TODO

## Contributing

Your contributions are always welcome! Feel free to open pull request.

[netglade_link]: https://netglade.cz/en

[ci_badge]: https://github.com/netglade/sliver_app_bar_builder/workflows/ci/badge.svg

[ci_badge_link]: https://github.com/netglade/sliver_app_bar_builder/actions

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg

[license_badge_link]: https://opensource.org/licenses/MIT

[style_badge]: https://img.shields.io/badge/style-netglade_analysis-26D07C.svg

[style_badge_link]: https://pub.dev/packages/netglade_analysis

[auto_mappr_pub_badge]: https://img.shields.io/pub/v/auto_mappr.svg

[auto_mappr_pub_link]: https://pub.dartlang.org/packages/auto_mappr

[auto_mappr_annotation_pub_badge]: https://img.shields.io/pub/v/auto_mappr_annotation.svg

[auto_mappr_annotation_pub_link]: https://pub.dartlang.org/packages/auto_mappr_annotation

[auto_mapper_net_link]: https://automapper.org
