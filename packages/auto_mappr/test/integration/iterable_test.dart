// ignore_for_file: avoid-duplicate-collection-elements

import 'package:test/test.dart';

import 'fixture/iterable.dart' as fixture;

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
      expect(
        converted,
        equals(fixture.Primitive([1, 2, 3, 4, 5].where((_) => true))),
      );
    });

    test('nullable to non nullable', () {
      // arrange
      const dto = fixture.PrimitiveNullableDto([1, 2, 3, null, 4, 5, null]);

      // act
      final converted = mappr.convert<fixture.PrimitiveNullableDto, fixture.Primitive>(dto);

      // assert
      expect(
        converted,
        equals(fixture.Primitive([1, 2, 3, 4, 5].where((_) => true))),
      );
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
          fixture.Complex(
            [
              const fixture.Nested(id: 111_789, name: 'first x', tag: fixture.NestedTag(flag: false)),
              const fixture.Nested(id: 111_456, name: 'second x', tag: fixture.NestedTag(flag: false)),
              const fixture.Nested(id: 111_123, name: 'third x', tag: fixture.NestedTag(flag: true)),
            ].where((_) => true),
          ),
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
          fixture.Complex(
            [
              const fixture.Nested(id: 111_789, name: 'first x', tag: fixture.NestedTag(flag: false)),
              const fixture.Nested(id: 111_456, name: 'second x', tag: fixture.NestedTag(flag: false)),
              const fixture.Nested(id: 111_123, name: 'third x', tag: fixture.NestedTag(flag: true)),
            ].where((_) => true),
          ),
        ),
      );
    });
  });

  group('from list', () {
    test('to list', () {
      // arrange
      const dto = fixture.ListHolder([1, 2, 3, 4, 5]);

      // act
      final converted = mappr.convert<fixture.ListHolder, fixture.ListHolder>(dto);

      // assert
      expect(converted, equals(const fixture.ListHolder([1, 2, 3, 4, 5])));
    });

    test('to set', () {
      // arrange
      const dto = fixture.ListHolder([1, 2, 3, 4, 5]);

      // act
      final converted = mappr.convert<fixture.ListHolder, fixture.SetHolder>(dto);

      // assert
      expect(converted, equals(const fixture.SetHolder({1, 2, 3, 4, 5})));
    });

    test('to iterable', () {
      // arrange
      const dto = fixture.ListHolder([1, 2, 3, 4, 5]);

      // act
      final converted = mappr.convert<fixture.ListHolder, fixture.IterableHolder>(dto);

      // assert
      expect(
        converted,
        equals(fixture.IterableHolder([1, 2, 3, 4, 5].where((_) => true))),
      );
    });
  });

  group('from set', () {
    test('to list', () {
      // arrange
      const dto = fixture.SetHolder({1, 2, 3, 4, 5});

      // act
      final converted = mappr.convert<fixture.SetHolder, fixture.ListHolder>(dto);

      // assert
      expect(converted, equals(const fixture.ListHolder([1, 2, 3, 4, 5])));
    });

    test('to set', () {
      // arrange
      const dto = fixture.SetHolder({1, 2, 3, 4, 5});

      // act
      final converted = mappr.convert<fixture.SetHolder, fixture.SetHolder>(dto);

      // assert
      expect(converted, equals(const fixture.SetHolder({1, 2, 3, 4, 5})));
    });

    test('to iterable', () {
      // arrange
      const dto = fixture.SetHolder({1, 2, 3, 4, 5});

      // act
      final converted = mappr.convert<fixture.SetHolder, fixture.IterableHolder>(dto);

      // assert
      expect(
        converted,
        equals(const fixture.IterableHolder({1, 2, 3, 4, 5})),
      );
    });
  });

  group('from iterable', () {
    test('to list', () {
      // arrange
      final dto = fixture.IterableHolder([1, 2, 3, 4, 5].where((_) => true));

      // act
      final converted = mappr.convert<fixture.IterableHolder, fixture.ListHolder>(dto);

      // assert
      expect(converted, equals(const fixture.ListHolder([1, 2, 3, 4, 5])));
    });

    test('to set', () {
      // arrange
      final dto = fixture.IterableHolder([1, 2, 3, 4, 5].where((_) => true));

      // act
      final converted = mappr.convert<fixture.IterableHolder, fixture.SetHolder>(dto);

      // assert
      expect(converted, equals(const fixture.SetHolder({1, 2, 3, 4, 5})));
    });

    test('to iterable', () {
      // arrange
      final dto = fixture.IterableHolder([1, 2, 3, 4, 5].where((_) => true));

      // act
      final converted = mappr.convert<fixture.IterableHolder, fixture.IterableHolder>(dto);

      // assert
      expect(
        converted,
        equals(const fixture.IterableHolder([1, 2, 3, 4, 5])),
      );
    });
  });
}
