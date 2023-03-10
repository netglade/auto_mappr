# AutoMapper

<a href="https://netglade.cz/en">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/netglade/.github/main/assets/netglade_logo_light.png">
    <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/netglade/.github/main/assets/netglade_logo_dark.png">
    <img alt="netglade" src="https://raw.githubusercontent.com/netglade/.github/main/assets/netglade_logo_dark.png">
  </picture>
</a>

Developed with 💚 by [netglade][netglade_link]

[![ci][ci_badge]][ci_badge_link]
[![pub package][pub_badge]][pub_badge_link]
[![license: MIT][license_badge]][license_badge_link]
[![style: netglade analysis][style_badge]][style_badge_link]

---

Mapper for mapping between different objects with ease. Heavily inspired by [C# AutoMapper][auto_mapper_net_link].

Thanks to code-generation you can generate class, called mapper, which will allow to map between different objects automatically without need to write these mapping by hand. 


## Get started
Install `builder_runner` and `auto_mapper_generator` 

```yaml
dev_dependencies:
  auto_mapper_generator: ^0.0.1
  build_runner: 
```
and `auto_mapper` as dependecy for annotations

```yaml
dependencies:
  auto_mapper: ^0.1.0
```

Define you mapper

```dart
@AutoMapper(mappers: [
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

final userDto = await getUserDto();

final mapper = ExampleMapper();
final user = mapper.convert(userDto);

```

## Configuration

Each mapping between two objects, from SOURCE to TARGET is done with `AutoMap<SOURCE, TARGET>` class. 

You can set these properties on each AutoMap: 

 - `reverse`: If `true` reverse mapping from TARGET -> SOURCE will be generated as well. Note that, if explicit mappinng is configured, this flag is ignored.
 - `whenNullDefault` - callback which returns default value for TARGET if SOURCE is null. Used only if SOURCE is marked as nullable, e.g. `AutoMap<SOURCE?, TARGET>`. 


### Custom member mapping

For each mapped member you can specify how it should be mapped. For example: 

```dart
@AutoMapper(
  mappers: [
    AutoMap<UserDto, User>(
      mappings: [
        MapMember(member: 'name', target: Mapper.mapName),
        MapMember(member: 'age', target: mapAge),
        MapMember(member: 'tag', ignore: true)
      ],
    ),
  ],
)
class Mapper extends $Mapper {
  static String mapName(UserDto from) => from.name.toUpperCase();
}

// ignore: prefer-static-class, for test
int mapAge(UserDto _) => 55;

```

Note that `member` parameter should match either TARGET's  member name OR constructor parameter name (In most cases they are same).

`target` property is optional mapping function which can define custom mapping logic from SOURCE. 

`ignore` - if `true` member will be ignored. Note that nullability cases are handled as well. (e.g. Target is nullable but required parameter, mapper will assing null automatically).


### Null handling

TODO



## Contributing

Your contributions are always welcome! Feel free to open pull request. 

[storybook_image_link]: https://github.com/netglade/sliver_app_bar_builder/raw/main/screenshots/storybook.png
[storybook_demo_link]: https://netglade.github.io/sliver_app_bar_builder

[netglade_link]: https://netglade.cz/en

[ci_badge]: https://github.com/netglade/sliver_app_bar_builder/workflows/ci/badge.svg
[ci_badge_link]: https://github.com/netglade/sliver_app_bar_builder/actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_badge_link]: https://opensource.org/licenses/MIT
[pub_badge]: https://img.shields.io/pub/v/sliver_app_bar_builder.svg
[pub_badge_link]: https://pub.dartlang.org/packages/sliver_app_bar_builder
[style_badge]: https://img.shields.io/badge/style-netglade_analysis-26D07C.svg
[style_badge_link]: https://pub.dev/packages/netglade_analysis
[auto_mapper_net_link]: https://automapper.org/