import 'package:test/test.dart';

import 'fixture/map.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  group('primitive key, primitive value', () {
    test('non nullable to non nullable', () {
      const dto = fixture.PrimitivePrimitiveDto({'alpha': 1, 'beta': 2, 'gama': 3});
      final converted = mappr.convert<fixture.PrimitivePrimitiveDto, fixture.PrimitivePrimitive>(dto);

      expect(
        converted,
        equals(const fixture.PrimitivePrimitive({'alpha': 1, 'beta': 2, 'gama': 3})),
      );
    });

    test('nullable source key', () {
      const dto = fixture.PrimitivePrimitiveNullableKeyDto({'alpha': 1, 'beta': 2, 'gama': 3, null: 42});
      final converted = mappr.convert<fixture.PrimitivePrimitiveNullableKeyDto, fixture.PrimitivePrimitive>(dto);

      expect(
        converted,
        equals(const fixture.PrimitivePrimitive({'alpha': 1, 'beta': 2, 'gama': 3})),
      );
    });

    test('nullable source value', () {
      const dto = fixture.PrimitivePrimitiveNullableValueDto({'alpha': 1, 'beta': 2, 'gama': 3, 'delta': null});
      final converted = mappr.convert<fixture.PrimitivePrimitiveNullableValueDto, fixture.PrimitivePrimitive>(dto);

      expect(
        converted,
        equals(const fixture.PrimitivePrimitive({'alpha': 1, 'beta': 2, 'gama': 3})),
      );
    });

    test('nullable source both', () {
      const dto = fixture.PrimitivePrimitiveNullableBothDto({'alpha': 1, 'beta': 2, 'gama': 3, 'delta': null, null: 5});
      final converted = mappr.convert<fixture.PrimitivePrimitiveNullableBothDto, fixture.PrimitivePrimitive>(dto);

      expect(
        converted,
        equals(const fixture.PrimitivePrimitive({'alpha': 1, 'beta': 2, 'gama': 3})),
      );
    });
  });

  group('primitive key, complex value', () {
    test('non nullable to non nullable', () {
      const dto = fixture.PrimitiveComplexDto({
        'alpha': fixture.NestedDto(1001, name: 'alpha', tag: fixture.NestedTagDto(flag: true)),
        'beta': fixture.NestedDto(1002, name: 'beta', tag: fixture.NestedTagDto(flag: true)),
        'gama': fixture.NestedDto(1003, name: 'gama', tag: fixture.NestedTagDto(flag: true)),
      });
      final converted = mappr.convert<fixture.PrimitiveComplexDto, fixture.PrimitiveComplex>(dto);

      expect(
        converted,
        equals(
          const fixture.PrimitiveComplex({
            'alpha': fixture.Nested(id: 1001, name: 'alpha', tag: fixture.NestedTag(flag: true)),
            'beta': fixture.Nested(id: 1002, name: 'beta', tag: fixture.NestedTag(flag: true)),
            'gama': fixture.Nested(id: 1003, name: 'gama', tag: fixture.NestedTag(flag: true)),
          }),
        ),
      );
    });
  });

  group('complex key, primitive value', () {
    test('non nullable to non nullable', () {
      const dto = fixture.ComplexPrimitiveDto({
        fixture.NestedDto(963, name: 'test alpha', tag: fixture.NestedTagDto(flag: true)): 789,
        fixture.NestedDto(852, name: 'test beta', tag: fixture.NestedTagDto(flag: true)): 456,
        fixture.NestedDto(741, name: 'test gama', tag: fixture.NestedTagDto(flag: true)): 123,
      });
      final converted = mappr.convert<fixture.ComplexPrimitiveDto, fixture.ComplexPrimitive>(dto);

      expect(
        converted,
        equals(
          fixture.ComplexPrimitive({
            const fixture.Nested(id: 963, name: 'test alpha', tag: fixture.NestedTag(flag: true)): 789,
            const fixture.Nested(id: 852, name: 'test beta', tag: fixture.NestedTag(flag: true)): 456,
            const fixture.Nested(id: 741, name: 'test gama', tag: fixture.NestedTag(flag: true)): 123,
          }),
        ),
      );
    });
  });

  group('complex key, complex value', () {
    test('non nullable to non nullable', () {
      const dto = fixture.ComplexComplexDto({
        fixture.NestedDto(1, name: 'first', tag: fixture.NestedTagDto(flag: true)):
            fixture.NestedDto(2, name: 'first test', tag: fixture.NestedTagDto(flag: false)),
        fixture.NestedDto(3, name: 'second', tag: fixture.NestedTagDto(flag: false)):
            fixture.NestedDto(4, name: 'second test', tag: fixture.NestedTagDto(flag: true)),
      });
      final converted = mappr.convert<fixture.ComplexComplexDto, fixture.ComplexComplex>(dto);

      expect(
        converted,
        equals(
          fixture.ComplexComplex({
            const fixture.Nested(id: 1, name: 'first', tag: fixture.NestedTag(flag: true)):
                const fixture.Nested(id: 2, name: 'first test', tag: fixture.NestedTag(flag: false)),
            const fixture.Nested(id: 3, name: 'second', tag: fixture.NestedTag(flag: false)):
                const fixture.Nested(id: 4, name: 'second test', tag: fixture.NestedTag(flag: true)),
          }),
        ),
      );
    });

    test('nullable source key', () {
      const dto = fixture.ComplexComplexNullableKeyDto({
        fixture.NestedDto(1, name: 'first', tag: fixture.NestedTagDto(flag: true)):
            fixture.NestedDto(2, name: 'first test', tag: fixture.NestedTagDto(flag: false)),
        fixture.NestedDto(3, name: 'second', tag: fixture.NestedTagDto(flag: false)):
            fixture.NestedDto(4, name: 'second test', tag: fixture.NestedTagDto(flag: true)),
        null: fixture.NestedDto(6, name: 'third test', tag: fixture.NestedTagDto(flag: false)),
      });
      final converted = mappr.convert<fixture.ComplexComplexNullableKeyDto, fixture.ComplexComplex>(dto);

      expect(
        converted,
        equals(
          fixture.ComplexComplex({
            const fixture.Nested(id: 1, name: 'first', tag: fixture.NestedTag(flag: true)):
                const fixture.Nested(id: 2, name: 'first test', tag: fixture.NestedTag(flag: false)),
            const fixture.Nested(id: 3, name: 'second', tag: fixture.NestedTag(flag: false)):
                const fixture.Nested(id: 4, name: 'second test', tag: fixture.NestedTag(flag: true)),
            const fixture.Nested(id: 666, name: 'default', tag: fixture.NestedTag(flag: true)):
                const fixture.Nested(id: 6, name: 'third test', tag: fixture.NestedTag(flag: false)),
          }),
        ),
      );
    });

    test('nullable source value', () {
      const dto = fixture.ComplexComplexNullableValueDto({
        fixture.NestedDto(1, name: 'first', tag: fixture.NestedTagDto(flag: true)):
            fixture.NestedDto(2, name: 'first test', tag: fixture.NestedTagDto(flag: false)),
        fixture.NestedDto(3, name: 'second', tag: fixture.NestedTagDto(flag: false)):
            fixture.NestedDto(4, name: 'second test', tag: fixture.NestedTagDto(flag: true)),
        fixture.NestedDto(5, name: 'third', tag: fixture.NestedTagDto(flag: true)): null,
      });
      final converted = mappr.convert<fixture.ComplexComplexNullableValueDto, fixture.ComplexComplex>(dto);

      expect(
        converted,
        equals(
          fixture.ComplexComplex({
            const fixture.Nested(id: 1, name: 'first', tag: fixture.NestedTag(flag: true)):
                const fixture.Nested(id: 2, name: 'first test', tag: fixture.NestedTag(flag: false)),
            const fixture.Nested(id: 3, name: 'second', tag: fixture.NestedTag(flag: false)):
                const fixture.Nested(id: 4, name: 'second test', tag: fixture.NestedTag(flag: true)),
            const fixture.Nested(id: 5, name: 'third', tag: fixture.NestedTag(flag: true)):
                const fixture.Nested(id: 666, name: 'default', tag: fixture.NestedTag(flag: true)),
          }),
        ),
      );
    });

    test('nullable source both', () {
      const dto = fixture.ComplexComplexNullableBothDto({
        fixture.NestedDto(1, name: 'first', tag: fixture.NestedTagDto(flag: true)):
            fixture.NestedDto(2, name: 'first test', tag: fixture.NestedTagDto(flag: false)),
        fixture.NestedDto(3, name: 'second', tag: fixture.NestedTagDto(flag: false)):
            fixture.NestedDto(4, name: 'second test', tag: fixture.NestedTagDto(flag: true)),
        null: fixture.NestedDto(6, name: 'third test', tag: fixture.NestedTagDto(flag: false)),
        fixture.NestedDto(7, name: 'fourth', tag: fixture.NestedTagDto(flag: false)): null,
      });
      final converted = mappr.convert<fixture.ComplexComplexNullableBothDto, fixture.ComplexComplex>(dto);

      expect(
        converted,
        equals(
          fixture.ComplexComplex({
            const fixture.Nested(id: 1, name: 'first', tag: fixture.NestedTag(flag: true)):
                const fixture.Nested(id: 2, name: 'first test', tag: fixture.NestedTag(flag: false)),
            const fixture.Nested(id: 3, name: 'second', tag: fixture.NestedTag(flag: false)):
                const fixture.Nested(id: 4, name: 'second test', tag: fixture.NestedTag(flag: true)),
            const fixture.Nested(id: 666, name: 'default', tag: fixture.NestedTag(flag: true)):
                const fixture.Nested(id: 6, name: 'third test', tag: fixture.NestedTag(flag: false)),
            const fixture.Nested(id: 7, name: 'fourth', tag: fixture.NestedTag(flag: false)):
                const fixture.Nested(id: 666, name: 'default', tag: fixture.NestedTag(flag: true)),
          }),
        ),
      );
    });
  });
}
