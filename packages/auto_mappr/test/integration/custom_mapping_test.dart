import 'package:test/test.dart';

import 'fixture/custom_mapping.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = fixture.Mappr();
  });

  group('Empty DTO - complex objects', () {
    test('Default constructor', () {
      // arrange
      const dto = fixture.CustomValueFromEmptyDto();

      // act
      final converted = mappr.convert<fixture.CustomValueFromEmptyDto, fixture.CustomValueHolder>(dto);

      // assert
      expect(
        converted,
        equals(const fixture.CustomValueHolder(fixture.CustomValue(42))),
      );
    });

    test('Named constructor', () {
      // arrange
      const dto = fixture.CustomValueFromEmptyDto();

      // act
      final converted = mappr.convert<fixture.CustomValueFromEmptyDto, fixture.CustomValueHolderNamed>(dto);

      // assert
      expect(
        converted,
        equals(const fixture.CustomValueHolderNamed(fixture.CustomValue.named(420, xxx: 421))),
      );
    });

    test('Deeply nested', () {
      // arrange
      const dto = fixture.CustomValueFromEmptyDto();

      // act
      final converted = mappr.convert<fixture.CustomValueFromEmptyDto, fixture.CustomListValue>(dto);

      // assert
      expect(
        converted,
        equals(
          const fixture.CustomListValue([
            fixture.CustomListValue([
              fixture.CustomListValue([fixture.CustomValue(1)]),
              fixture.CustomValue.named(2, xxx: 3),
            ]),
          ]),
        ),
      );
    });
  });

  group('Empty DTO - literal objects', () {
    test('From values', () {
      // arrange
      const dto = fixture.CustomValueFromEmptyDto();

      // act
      final converted = mappr.convert<fixture.CustomValueFromEmptyDto, fixture.CustomValueFromEmpty>(dto);

      // assert
      expect(
        converted,
        equals(
          const fixture.CustomValueFromEmpty(
            5,
            123,
            12.45,
            'test text',
            false,
            ['alpha', 3, true, null],
            [
              ['alpha', 3],
              [true, null],
            ],
            {3, -1, 123, -888},
            {'alpha': 1, 'beta': 2, 'gama': 3},
          ),
        ),
      );
    });

    test('From functions', () {
      // arrange
      const dto = fixture.CustomFunctionFromEmptyDto();

      // act
      final converted = mappr.convert<fixture.CustomFunctionFromEmptyDto, fixture.CustomFunctionFromEmpty>(dto);

      // assert
      expect(
        converted,
        equals(
          fixture.CustomFunctionFromEmpty(
            1.2,
            2,
            74.58,
            'some test',
            true,
            const [null, true, 3, 8.6],
            const [
              [null, 'xx'],
              [true, 3, 8.6],
            ],
            const {1, 2, 3, 4, 5},
            const {'one': 11, 'two': 22, 'three': 33},
            DateTime(2023),
          ),
        ),
      );
    });
  });

  group('value', () {
    test('in positional parameters', () {
      // arrange
      const dto = fixture.CustomValuePositionalDto(123_456, 'test name');

      // act
      final converted = mappr.convert<fixture.CustomValuePositionalDto, fixture.CustomValuePositional>(dto);
      
      // assert
      expect(converted, equals(const fixture.CustomValuePositional(r'hello there, $obi "ben" wan')));
    });

    test('in named parameters', () {
      // arrange
      const dto = fixture.CustomValueNamedDto(id: 123_456, name: 'test name');

      // act
      final converted = mappr.convert<fixture.CustomValueNamedDto, fixture.CustomValueNamed>(dto);

      // assert
      expect(converted, equals(const fixture.CustomValueNamed(nameAndId: 'hello "there" kenobi')));
    });
  });

  group('function', () {
    test('in positional parameters', () {
      // arrange
      const dto = fixture.CustomFunctionPositionalDto(963_852, 'test xxx');

      // act
      final converted = mappr.convert<fixture.CustomFunctionPositionalDto, fixture.CustomFunctionPositional>(dto);

      // assert
      expect(converted, equals(const fixture.CustomFunctionPositional('test xxx #963852')));
    });

    test('in named parameters', () {
      // arrange
      const dto = fixture.CustomFunctionNamedDto(id: 123_456, name: 'test name');

      // act
      final converted = mappr.convert<fixture.CustomFunctionNamedDto, fixture.CustomFunctionNamed>(dto);

      // assert
      expect(converted, equals(const fixture.CustomFunctionNamed(nameAndId: 'test name #123456')));
    });
  });
}
