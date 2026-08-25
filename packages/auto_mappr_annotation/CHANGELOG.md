[//]: # (## Unreleased)

## 3.0.0
- **BREAKING** `MapType.constructor` now takes a constructor tearoff of the target
  instead of a constructor name. Replace `constructor: 'fromDto'` with
  `constructor: User.fromDto`, and use `User.new` to force the unnamed constructor.
- Add `boxing` and `unboxing` options to `MapType`, and `boxing` to `Field`. [#240](https://github.com/netglade/auto_mappr/issues/240)

## 2.4.0
- Bump minimum Dart SDK version to `3.12.0`.

## 2.3.0
- Update dependencies

## 2.2.0
- Add `safeMapping` option to `MapType`. [#204](https://github.com/netglade/auto_mappr/pull/216)

## 2.1.0
- Allow `TypeConverter` to have `<Object?, Object?>`. [#130](https://github.com/netglade/auto_mappr/pull/130)

## 2.0.0
- Adhere to netglade_analysis 4.0.0. [#111](https://github.com/netglade/auto_mappr/pull/111)
- Add `reverse` option to `MapType`. [#115](https://github.com/netglade/auto_mappr/pull/115)
- Add type converters, use `converters` on `AutoMappr` or `MapType`. [#119](https://github.com/netglade/auto_mappr/pull/119)

## 2.0.0-beta2
- Add type converters, use `converters` on `AutoMappr` or `MapType`. [#119](https://github.com/netglade/auto_mappr/pull/119)

## 2.0.0-beta1
- Adhere to netglade_analysis 4.0.0. [#111](https://github.com/netglade/auto_mappr/pull/111)
- Add `reverse` option to `MapType`. [#115](https://github.com/netglade/auto_mappr/pull/115)

## 1.2.0
- Add `ignoreFieldNull` in `MapType` to force non-nullable field for when source's field is nullable
- Add `ignoreNull` in `Field`` to force non-nullable field for when source's field is nullable

## 1.1.1
- Adhere to netglade_analysis 2.0.0.

## 1.1.0
- Add `AutoMapprInterface` with methods:
  - `canConvert`
  - `convert`, `tryConvert`
  - `convertIterable`, `tryConvertIterable`
  - `convertList`, `tryConvertList`
  - `convertSet`, `tryConvertSet`
- Add `modules` to `AutoMappr` annotation.

## 1.0.3
- Update logo.

## 1.0.2
- Remove `auto_mappr` from annotation example.
- Add a Discord link to README.

## 1.0.1
- Fix pub.dev issues.

## 1.0.0
- Initial version.
- Add `@AutoMappr` annotation.
