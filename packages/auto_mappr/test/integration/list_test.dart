// ignore_for_file: avoid-duplicate-collection-elements

import 'package:test/test.dart';

import 'fixture/list.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  group('primitive', () {
    test('non nullable to non nullable', () {
      // arrange
      const dto = fixture.PrimitiveDto([1, 2, 3, 4, 5]);

      // act
      final converted = mappr.convert<fixture.PrimitiveDto, fixture.Primitive>(dto);

      // assert
      expect(converted, equals(const fixture.Primitive([1, 2, 3, 4, 5])));
    });

    test('nullable to non nullable', () {
      // arrange
      const dto = fixture.PrimitiveNullableDto([1, 2, 3, null, 4, 5, null]);

      // act
      final converted = mappr.convert<fixture.PrimitiveNullableDto, fixture.Primitive>(dto);

      // assert
      expect(converted, equals(const fixture.Primitive([1, 2, 3, 4, 5])));
    });
  });

  group('complex', () {
    test('non nullable to non nullable', () {
      // arrange
      final dto = fixture.ComplexDto([
        fixture.NestedDto(111_789, name: 'first x', tag: fixture.NestedTagDto(flag: false)),
        fixture.NestedDto(111_456, name: 'second x', tag: fixture.NestedTagDto(flag: false)),
        fixture.NestedDto(111_123, name: 'third x', tag: fixture.NestedTagDto(flag: true)),
      ]);

      // act
      final converted = mappr.convert<fixture.ComplexDto, fixture.Complex>(dto);

      // assert
      expect(
        converted,
        equals(
          const fixture.Complex([
            fixture.Nested(id: 111_789, name: 'first x', tag: fixture.NestedTag(flag: false)),
            fixture.Nested(id: 111_456, name: 'second x', tag: fixture.NestedTag(flag: false)),
            fixture.Nested(id: 111_123, name: 'third x', tag: fixture.NestedTag(flag: true)),
          ]),
        ),
      );
    });

    test('nullable to non nullable', () {
      // arrange
      final dto = fixture.ComplexNullableDto([
        fixture.NestedDto(111_789, name: 'first x', tag: fixture.NestedTagDto(flag: false)),
        fixture.NestedDto(111_456, name: 'second x', tag: fixture.NestedTagDto(flag: false)),
        null,
        fixture.NestedDto(111_123, name: 'third x', tag: fixture.NestedTagDto(flag: true)),
        null,
      ]);

      // act
      final converted = mappr.convert<fixture.ComplexNullableDto, fixture.Complex>(dto);

      // assert
      expect(
        converted,
        equals(
          const fixture.Complex([
            fixture.Nested(id: 111_789, name: 'first x', tag: fixture.NestedTag(flag: false)),
            fixture.Nested(id: 111_456, name: 'second x', tag: fixture.NestedTag(flag: false)),
            fixture.Nested(id: 111_123, name: 'third x', tag: fixture.NestedTag(flag: true)),
          ]),
        ),
      );
    });

    test('nullable list to nullable list', () {
      // arrange
      final dto = fixture.ComplexDtoWithNullList([
        fixture.NestedDto(111_789, name: 'first x', tag: fixture.NestedTagDto(flag: false)),
        fixture.NestedDto(111_456, name: 'second x', tag: fixture.NestedTagDto(flag: false)),
        fixture.NestedDto(111_123, name: 'third x', tag: fixture.NestedTagDto(flag: true)),
      ]);

      // act
      final converted = mappr.convert<fixture.ComplexDtoWithNullList, fixture.ComplexWithNullList>(dto);

      // assert
      expect(
        converted,
        equals(
          const fixture.ComplexWithNullList([
            fixture.Nested(id: 111_789, name: 'first x', tag: fixture.NestedTag(flag: false)),
            fixture.Nested(id: 111_456, name: 'second x', tag: fixture.NestedTag(flag: false)),
            fixture.Nested(id: 111_123, name: 'third x', tag: fixture.NestedTag(flag: true)),
          ]),
        ),
      );
    });
  });
}
