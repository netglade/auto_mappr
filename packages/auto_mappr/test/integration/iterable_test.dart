import 'package:test/test.dart';

import 'fixture/iterable.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = fixture.Mappr();
  });

  group(
    'primitive',
    () {
      test(
        'non nullable to non nullable',
        () {
          const dto = fixture.PrimitiveDto([1, 2, 3, 4, 5]);
          final converted = mappr.convert<fixture.PrimitiveDto, fixture.Primitive>(dto);

          expect(
            converted,
            fixture.Primitive([1, 2, 3, 4, 5].where((_) => true)),
          );
        },
      );

      test(
        'nullable to non nullable',
        () {
          const dto = fixture.PrimitiveNullableDto([1, 2, 3, null, 4, 5, null]);
          final converted = mappr.convert<fixture.PrimitiveNullableDto, fixture.Primitive>(dto);

          expect(
            converted,
            fixture.Primitive([1, 2, 3, 4, 5].where((_) => true)),
          );
        },
      );
    },
  );

  group(
    'complex',
    () {
      test(
        'non nullable to non nullable',
        () {
          final dto = fixture.ComplexDto([
            fixture.NestedDto(111789, name: 'first x', tag: fixture.NestedTagDto(flag: false)),
            fixture.NestedDto(111456, name: 'second x', tag: fixture.NestedTagDto(flag: false)),
            fixture.NestedDto(111123, name: 'third x', tag: fixture.NestedTagDto(flag: true)),
          ]);
          final converted = mappr.convert<fixture.ComplexDto, fixture.Complex>(dto);

          expect(
            converted,
            fixture.Complex(
              [
                const fixture.Nested(id: 111789, name: 'first x', tag: fixture.NestedTag(flag: false)),
                const fixture.Nested(id: 111456, name: 'second x', tag: fixture.NestedTag(flag: false)),
                const fixture.Nested(id: 111123, name: 'third x', tag: fixture.NestedTag(flag: true)),
              ].where((_) => true),
            ),
          );
        },
      );

      test(
        'nullable to non nullable',
        () {
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
            fixture.Complex(
              [
                const fixture.Nested(id: 111789, name: 'first x', tag: fixture.NestedTag(flag: false)),
                const fixture.Nested(id: 111456, name: 'second x', tag: fixture.NestedTag(flag: false)),
                const fixture.Nested(id: 111123, name: 'third x', tag: fixture.NestedTag(flag: true)),
              ].where((_) => true),
            ),
          );
        },
      );
    },
  );

  group(
    'from list',
        () {
      test(
        'to list',
            () {
          const dto = fixture.ListHolder([1, 2, 3, 4, 5]);
          final converted = mappr.convert<fixture.ListHolder, fixture.ListHolder>(dto);

          expect(
            converted,
            const fixture.ListHolder([1, 2, 3, 4, 5]),
          );
        },
      );

      test(
        'to set',
            () {
          const dto = fixture.ListHolder([1, 2, 3, 4, 5]);
          final converted = mappr.convert<fixture.ListHolder, fixture.SetHolder>(dto);

          expect(
            converted,
            const fixture.SetHolder({1, 2, 3, 4, 5}),
          );
        },
      );

      test(
        'to iterable',
            () {
          const dto = fixture.ListHolder([1, 2, 3, 4, 5]);
          final converted = mappr.convert<fixture.ListHolder, fixture.IterableHolder>(dto);

          expect(
            converted,
            fixture.IterableHolder([1, 2, 3, 4, 5].where((_) => true)),
          );
        },
      );
    },
  );

  group(
    'from set',
        () {
      test(
        'to list',
            () {
          const dto = fixture.SetHolder({1, 2, 3, 4, 5});
          final converted = mappr.convert<fixture.SetHolder, fixture.ListHolder>(dto);

          expect(
            converted,
            const fixture.ListHolder([1, 2, 3, 4, 5]),
          );
        },
      );

      test(
        'to set',
            () {
          const dto = fixture.SetHolder({1, 2, 3, 4, 5});
          final converted = mappr.convert<fixture.SetHolder, fixture.SetHolder>(dto);

          expect(
            converted,
            const fixture.SetHolder({1, 2, 3, 4, 5}),
          );
        },
      );

      test(
        'to iterable',
            () {
          const dto = fixture.SetHolder({1, 2, 3, 4, 5});
          final converted = mappr.convert<fixture.SetHolder, fixture.IterableHolder>(dto);

          expect(
            converted,
            fixture.IterableHolder([1, 2, 3, 4, 5].where((_) => true)),
          );
        },
      );
    },
  );

  group(
    'from iterable',
        () {
      test(
        'to list',
            () {
          final dto = fixture.IterableHolder([1, 2, 3, 4, 5].where((_) => true));
          final converted = mappr.convert<fixture.IterableHolder, fixture.ListHolder>(dto);

          expect(
            converted,
            const fixture.ListHolder([1, 2, 3, 4, 5]),
          );
        },
      );

      test(
        'to set',
            () {
          final dto = fixture.IterableHolder([1, 2, 3, 4, 5].where((_) => true));
          final converted = mappr.convert<fixture.IterableHolder, fixture.SetHolder>(dto);

          expect(
            converted,
            const fixture.SetHolder({1, 2, 3, 4, 5}),
          );
        },
      );

      test(
        'to iterable',
            () {
          final dto = fixture.IterableHolder([1, 2, 3, 4, 5].where((_) => true));
          final converted = mappr.convert<fixture.IterableHolder, fixture.IterableHolder>(dto);

          expect(
            converted,
            fixture.IterableHolder([1, 2, 3, 4, 5].where((_) => true)),
          );
        },
      );
    },
  );
}
