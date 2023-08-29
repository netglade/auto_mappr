import 'package:test/test.dart';

import 'fixture/record.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  group('primitive', () {
    test('positional', () {
      const dto = fixture.PositionalDto((1, true, 'Brasil'));
      final converted = mappr.convert<fixture.PositionalDto, fixture.Positional>(dto);

      expect(converted, equals(const fixture.Positional((1, true, 'yolo'))));
    });

    test('positional nullable', () {
      const dto = fixture.PositionalNullableDto((2, false, 'New York'));
      final converted = mappr.convert<fixture.PositionalNullableDto, fixture.PositionalNullable>(dto);

      expect(converted, equals(const fixture.PositionalNullable((2, false, 'New York'))));
    });

    test('positional to positional nullable', () {
      const dto = fixture.PositionalDto((3, false, 'Prague'));
      final converted = mappr.convert<fixture.PositionalDto, fixture.PositionalNullable>(dto);

      expect(converted, equals(const fixture.PositionalNullable((3, false, 'Prague'))));
    });

    test('positional nullable to positional', () {
      const dto = fixture.PositionalNullableDto((4, true, 'Rome'));
      final converted = mappr.convert<fixture.PositionalNullableDto, fixture.Positional>(dto);

      expect(converted, equals(const fixture.PositionalNullable((4, true, 'Rome'))));
    });

    test('named', () {
      const dto = fixture.NamedDto((alpha: 5, beta: true, gama: 'Paris'));
      final converted = mappr.convert<fixture.NamedDto, fixture.Named>(dto);

      expect(converted, equals(const fixture.Named((alpha: 5, beta: true, gama: 'Paris'))));
    });
  });
}
