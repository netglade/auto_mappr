import 'package:test/test.dart';

import 'fixture/list_like.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = fixture.Mappr();
  });

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
