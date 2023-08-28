[//]: # (## Unreleased)

## Unreleased
- Adhere to netglade_analysis 4.0.0
- Add `reverse` option to `MapType`.

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
