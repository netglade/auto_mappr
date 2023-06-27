import 'package:test/test.dart';

import 'fixture/list.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  group('primitive', () {
    test('non nullable to non nullable', () {
      const dto = fixture.PrimitiveDto([1, 2, 3, 4, 5]);
      final converted = mappr.convert<fixture.PrimitiveDto, fixture.Primitive>(dto);

      expect(converted, equals(const fixture.Primitive([1, 2, 3, 4, 5])));
    });

    test('nullable to non nullable', () {
      const dto = fixture.PrimitiveNullableDto([1, 2, 3, null, 4, 5, null]);
      final converted = mappr.convert<fixture.PrimitiveNullableDto, fixture.Primitive>(dto);

      expect(converted, equals(const fixture.Primitive([1, 2, 3, 4, 5])));
    });
  });

  group('complex', () {
    test('non nullable to non nullable', () {
      final dto = fixture.ComplexDto([
        fixture.NestedDto(111789, name: 'first x', tag: fixture.NestedTagDto(flag: false)),
        fixture.NestedDto(111456, name: 'second x', tag: fixture.NestedTagDto(flag: false)),
        fixture.NestedDto(111123, name: 'third x', tag: fixture.NestedTagDto(flag: true)),
      ]);
      final converted = mappr.convert<fixture.ComplexDto, fixture.Complex>(dto);

      expect(
        converted,
        equals(
          const fixture.Complex([
            fixture.Nested(id: 111789, name: 'first x', tag: fixture.NestedTag(flag: false)),
            fixture.Nested(id: 111456, name: 'second x', tag: fixture.NestedTag(flag: false)),
            fixture.Nested(id: 111123, name: 'third x', tag: fixture.NestedTag(flag: true)),
          ]),
        ),
      );
    });

    test('nullable to non nullable', () {
      final dto = fixture.ComplexNullableDto([
        fixture.NestedDto(111789, name: 'first x', tag: fixture.NestedTagDto(flag: false)),
        fixture.NestedDto(111456, name: 'second x', tag: fixture.NestedTagDto(flag: false)),
        null,
        fixture.NestedDto(111123, name: 'third x', tag: fixture.NestedTagDto(flag: true)),
        null,
      ]);
      final converted = mappr.convert<fixture.ComplexNullableDto, fixture.Complex>(dto);

      expect(
        converted,
        equals(
          const fixture.Complex([
            fixture.Nested(id: 111789, name: 'first x', tag: fixture.NestedTag(flag: false)),
            fixture.Nested(id: 111456, name: 'second x', tag: fixture.NestedTag(flag: false)),
            fixture.Nested(id: 111123, name: 'third x', tag: fixture.NestedTag(flag: true)),
          ]),
        ),
      );
    });

    test('nullable list to nullable list', () {
      final dto = fixture.ComplexDtoWithNullList([
        fixture.NestedDto(111789, name: 'first x', tag: fixture.NestedTagDto(flag: false)),
        fixture.NestedDto(111456, name: 'second x', tag: fixture.NestedTagDto(flag: false)),
        fixture.NestedDto(111123, name: 'third x', tag: fixture.NestedTagDto(flag: true)),
      ]);
      final converted = mappr.convert<fixture.ComplexDtoWithNullList, fixture.ComplexWithNullList>(dto);

      expect(
        converted,
        equals(
          const fixture.ComplexWithNullList([
            fixture.Nested(id: 111789, name: 'first x', tag: fixture.NestedTag(flag: false)),
            fixture.Nested(id: 111456, name: 'second x', tag: fixture.NestedTag(flag: false)),
            fixture.Nested(id: 111123, name: 'third x', tag: fixture.NestedTag(flag: true)),
          ]),
        ),
      );
    });
  });
}
