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

      expect(converted, equals(const fixture.Positional((1, true, 'Brasil'))));
    });

    test('positional nullable', () {
      const dto = fixture.PositionalNullableDto((2, false, 'New York'));
      final converted = mappr.convert<fixture.PositionalNullableDto, fixture.PositionalNullable>(dto);

      expect(converted, equals(const fixture.PositionalNullable((2, false, 'New York', null, null))));
    });

    test('positional to positional nullable', () {
      const dto = fixture.PositionalDto((3, false, 'Prague'));
      final converted = mappr.convert<fixture.PositionalDto, fixture.PositionalNullable>(dto);

      expect(converted, equals(const fixture.PositionalNullable((3, false, 'Prague', null, null))));
    });

    test('named', () {
      const dto = fixture.NamedDto((alpha: 5, beta: true, gama: 'Paris'));
      final converted = mappr.convert<fixture.NamedDto, fixture.Named>(dto);

      expect(converted, equals(const fixture.Named((alpha: 5, beta: true, gama: 'Paris'))));
    });
  });

  group('complex', () {
    test('positional', () {
      const dto = fixture.ComplexPositionalDto([
        fixture.PositionalDto((33, true, 'qwerty')),
        fixture.PositionalDto((123, true, 'qwertz')),
        fixture.PositionalDto((999, true, 'dvorak')),
      ]);
      final converted = mappr.convert<fixture.ComplexPositionalDto, fixture.ComplexPositional>(dto);

      expect(
        converted,
        equals(
          const fixture.ComplexPositional([
            fixture.Positional((33, true, 'qwerty')),
            fixture.Positional((123, true, 'qwertz')),
            fixture.Positional((999, true, 'dvorak')),
          ]),
        ),
      );
    });

    test('named', () {
      const dto = fixture.ComplexNamedDto([
        fixture.NamedDto((alpha: 12333, beta: true, gama: 'qwerty')),
        fixture.NamedDto((alpha: 123123, beta: true, gama: 'qwertz')),
        fixture.NamedDto((alpha: 123999, beta: true, gama: 'dvorak')),
      ]);
      final converted = mappr.convert<fixture.ComplexNamedDto, fixture.ComplexNamed>(dto);

      expect(
        converted,
        equals(
          const fixture.ComplexNamed([
            fixture.Named((alpha: 12333, beta: true, gama: 'qwerty')),
            fixture.Named((alpha: 123123, beta: true, gama: 'qwertz')),
            fixture.Named((alpha: 123999, beta: true, gama: 'dvorak')),
          ]),
        ),
      );
    });
  });
}
