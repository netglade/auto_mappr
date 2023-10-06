[//]: # (## Unreleased)

## 2.1.0
- Add support for nullable type converters. [#130](https://github.com/netglade/auto_mappr/pull/130)

## 2.0.2
- Fix null value when nullable source and target resulting in `{}` and not `null`. [#129](https://github.com/netglade/auto_mappr/pull/129)

## 2.0.1
- Fix type converters when used with reverse mappings. [#127](https://github.com/netglade/auto_mappr/pull/127)

## 2.0.0
- **Breaking**: Allow "absorbing" modules using `includes` on `@AutoMappr`. Previous `modules` is now `delegates`. [#117](https://github.com/netglade/auto_mappr/pull/117)
- **Breaking**: Remove shared AutoMappr builder that used PartBuilder, now `.auto_mappr.dart` is generated using LibraryBuilder. [#117](https://github.com/netglade/auto_mappr/pull/117)
- Add type converters, use `converters` on `AutoMappr` or `MapType`. [#119](https://github.com/netglade/auto_mappr/pull/119)
- Add a `reverse` option on `MapType`, which includes the reverse mapping. [#115](https://github.com/netglade/auto_mappr/pull/115)
- Add a support for Dart 3 and Records feature. [#116](https://github.com/netglade/auto_mappr/pull/116)

## 2.0.0-beta2
- Add type converters, use `converters` on `AutoMappr` or `MapType`. [#119](https://github.com/netglade/auto_mappr/pull/119)

## 2.0.0-beta1
- **Breaking**: Allow "absorbing" modules using `includes` on `@AutoMappr`. Previous `modules` is now `delegates`. [#117](https://github.com/netglade/auto_mappr/pull/117)
- **Breaking**: Remove shared AutoMappr builder that used PartBuilder, now `.auto_mappr.dart` is generated using LibraryBuilder. [#117](https://github.com/netglade/auto_mappr/pull/117)
- Add a `reverse` option on `MapType`, which includes the reverse mapping. [#115](https://github.com/netglade/auto_mappr/pull/115)
- Add a support for Dart 3 and Records feature. [#116](https://github.com/netglade/auto_mappr/pull/116)

## 1.7.0
- Adhere to netglade_analysis. [#94](https://github.com/netglade/auto_mappr/pull/94)
- Update analyzer and mocktail packages. [#111](https://github.com/netglade/auto_mappr/pull/111)

## 1.6.0
- Add support for Forced non-nullable field for nullable source. [#105](https://github.com/netglade/auto_mappr/pull/105)

## 1.5.0
- Add support for library aliases, so mapping now supports types from different libraries with the same name.
It also work in cases when library alias's exports. [#62](https://github.com/netglade/auto_mappr/pull/62)
- Adhere to netglade_analysis 2.0.0.

## 1.4.0
- Add modules. [#67](https://github.com/netglade/auto_mappr/pull/67)
- Split method builder into separate files. [#67](https://github.com/netglade/auto_mappr/pull/67)
- Add when `whenSourceIsNull` support to enum mapping. [#59](https://github.com/netglade/auto_mappr/pull/59)
- Add enum mapping fallback support for missing fields in the Target using `whenSourceIsNull`. [#59](https://github.com/netglade/auto_mappr/pull/59)
- Fix top-level functions now work with `whenSourceIsNull`. [#59](https://github.com/netglade/auto_mappr/pull/59)

## 1.3.1
- Add documentation for enums and converting iterables. [#52](https://github.com/netglade/auto_mappr/pull/52)
- Fix generator when multiple annotations are used. [#51](https://github.com/netglade/auto_mappr/pull/51)
- Add Injectable example. [#51](https://github.com/netglade/auto_mappr/pull/51)

## 1.3.0
- Fix mapping from/to subclasses. [#37](https://github.com/netglade/auto_mappr/pull/37/)
- Add `tryConvert` method. [#34](https://github.com/netglade/auto_mappr/pull/34)
- Fix selecting private constructors. [#37](https://github.com/netglade/auto_mappr/pull/37)
- Add non factory over factory constructor selection preference. [#37](https://github.com/netglade/auto_mappr/pull/37)
- Add `required_inputs` with `.freezed.dart` and `.drift.dart` by default. [#31](https://github.com/netglade/auto_mappr/pull/31)
- Add enum mapping support. [#36](https://github.com/netglade/auto_mappr/pull/36)
- Add `try/convert{Iterable,List,Set}` methods. [#35](https://github.com/netglade/auto_mappr/pull/35)

## 1.2.1
- Document how to use the `convert` method. [#23](https://github.com/netglade/auto_mappr/pull/23)
- Update package's icon. [#24](https://github.com/netglade/auto_mappr/pull/24)

## 1.2.0
- Adhere lints to `netglade_analysis` 1.2.0. [#20](https://github.com/netglade/auto_mappr/pull/20)
- Use tear-offs when possible.
- Omit map when possible.
- Omit null check of non-nullable when possible.

## 1.1.2
- Update exception messages to include suggestions for troubleshooting.
- Add a Discord link to README.

## 1.1.1
- Add about section to README.
- Add a note about using generated source and target classes.

## 1.1.0
- Add support for generics.

## 1.0.1
- Fix pub.dev issues.

## 1.0.0
- Initial version.
- Add primitive objects mapping
- Add complex objects mapping
- Add field mapping
- Add custom mapping
- Add ignoring mapping
- Add iterable objects mapping
- Add maps objects mapping
- Add default field value
- Add default object value
- Add constructor selection
- Add positional and named constructor parameters
- Add mapping to target (constructor parameters or public setters)
- Add mapping from source (public instance or static getters)
- Add nullability handling
- Add works with `equatable`
- Add works with `json_serializable`
