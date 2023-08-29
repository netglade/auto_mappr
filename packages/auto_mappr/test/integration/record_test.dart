import 'package:test/test.dart';

import 'fixture/record.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  group('primitive', () {
    test('non nullable to non nullable', () {
      // const dto = fixture.PositionalDto([1, 2, 3, 4, 5]);
      // final converted = mappr.convert<fixture.PositionalDto, fixture.Positional>(dto);

      // expect(
      //   converted,
      //   equals(fixture.Positional([1, 2, 3, 4, 5].where((_) => true))),
      // );
    });

    test('nullable to non nullable', () {
      // const dto = fixture.PrimitiveNullableDto([1, 2, 3, null, 4, 5, null]);
      // final converted = mappr.convert<fixture.PrimitiveNullableDto, fixture.Positional>(dto);

      // expect(
      //   converted,
      //   equals(fixture.Positional([1, 2, 3, 4, 5].where((_) => true))),
      // );
    });
  });
}
