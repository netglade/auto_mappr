import 'package:test/test.dart';

import 'fixture/custom_mapping.dart' as fixture;

void main() {
  late final fixture.Mapper mapper;

  setUpAll(() {
    mapper = fixture.Mapper();
  });

  group(
    'Empty DTO - complex objects',
    () {
      test('Default constructor', () {
        final converted = mapper.convert<fixture.CustomValueFromEmptyDto, fixture.CustomValueHolder>(
          fixture.CustomValueFromEmptyDto(),
        );

        expect(
          converted,
          fixture.CustomValueHolder(fixture.CustomValue(42)),
        );
      });

      test('Named constructor', () {
        final converted = mapper.convert<fixture.CustomValueFromEmptyDto, fixture.CustomValueHolderNamed>(
          fixture.CustomValueFromEmptyDto(),
        );

        expect(
          converted,
          fixture.CustomValueHolderNamed(fixture.CustomValue.named(420, xxx: 421)),
        );
      });

      test('Deeply nested', () {
        final converted = mapper.convert<fixture.CustomValueFromEmptyDto, fixture.CustomListValue>(
          fixture.CustomValueFromEmptyDto(),
        );

        expect(
          converted,
          fixture.CustomListValue([
            fixture.CustomListValue([
              fixture.CustomListValue([fixture.CustomValue(1)]),
              fixture.CustomValue.named(2, xxx: 3)
            ])
          ]),
        );
      });
    },
  );

  group(
    'Empty DTO - literal objects',
    () {
      test('From values', () {
        final converted = mapper.convert<fixture.CustomValueFromEmptyDto, fixture.CustomValueFromEmpty>(
          fixture.CustomValueFromEmptyDto(),
        );

        expect(
          converted,
          fixture.CustomValueFromEmpty(
            5,
            123,
            12.45,
            'test text',
            false,
            ['alpha', 3, true, null],
            [
              ['alpha', 3],
              [true, null]
            ],
            {3, -1, 123, -888},
            {'alpha': 1, 'beta': 2, 'gama': 3},
          ),
        );
      });

      test('From functions', () {
        final converted = mapper.convert<fixture.CustomFunctionFromEmptyDto, fixture.CustomFunctionFromEmpty>(
          fixture.CustomFunctionFromEmptyDto(),
        );

        expect(
          converted,
          fixture.CustomFunctionFromEmpty(
            1.2,
            2,
            74.58,
            'some test',
            true,
            [null, true, 3, 8.6],
            [
              [null, 'xx'],
              [true, 3, 8.6],
            ],
            {1, 2, 3, 4, 5},
            {'one': 11, 'two': 22, 'three': 33},
          ),
        );
      });
    },
  );

  group('value', () {
    test(
      'in positional parameters',
      () {
        final converted = mapper.convert<fixture.CustomValuePositionalDto, fixture.CustomValuePositional>(
          fixture.CustomValuePositionalDto(123456, 'test name'),
        );

        expect(converted, fixture.CustomValuePositional(r"hello there, obi 'ben' wan"));
      },
    );

    test(
      'in named parameters',
      () {
        final converted = mapper.convert<fixture.CustomValueNamedDto, fixture.CustomValueNamed>(
          fixture.CustomValueNamedDto(id: 123456, name: 'test name'),
        );

        expect(converted, fixture.CustomValueNamed(nameAndId: 'hello "there" kenobi'));
      },
    );
  });

  group('function', () {
    test(
      'in positional parameters',
      () {
        final converted = mapper.convert<fixture.CustomFunctionPositionalDto, fixture.CustomFunctionPositional>(
          fixture.CustomFunctionPositionalDto(963852, 'test xxx'),
        );

        expect(converted, fixture.CustomFunctionPositional('test xxx #963852'));
      },
    );

    test(
      'in named parameters',
      () {
        final converted = mapper.convert<fixture.CustomFunctionNamedDto, fixture.CustomFunctionNamed>(
          fixture.CustomFunctionNamedDto(id: 123456, name: 'test name'),
        );

        expect(converted, fixture.CustomFunctionNamed(nameAndId: 'test name #123456'));
      },
    );
  });
}
