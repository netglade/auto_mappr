import 'package:test/test.dart';

import 'fixture/import_alias.dart' as fixture;
import 'fixture/import_alias/import_alias_1.dart' as fixture_a1;
import 'fixture/import_alias/import_alias_2.dart' as fixture_a2;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  group(
    'Mapping between objects with the same name from different libraries',
    () {
      test('UserDto to User works', () {
        const dto = fixture.UserDto(name: 'John Wick', age: 42);
        final converted = mappr.convert<fixture.UserDto, fixture.User>(dto);

        expect(converted, equals(const fixture.User(name: 'John Wick', age: 42)));
      });

      test('UserDto to a1.User works', () {
        const dto = fixture.UserDto(name: 'John Wick', age: 42);
        final converted = mappr.convert<fixture.UserDto, fixture_a1.User>(dto);

        expect(converted, equals(const fixture_a1.User(name: 'John Wick', age: 42)));
      });

      test('UserDto to a2.User works', () {
        const dto = fixture.UserDto(name: 'John Wick', age: 42);
        final converted = mappr.convert<fixture.UserDto, fixture_a2.User>(dto);

        expect(converted, equals(const fixture_a2.User(name: 'John Wick', age: 42)));
      });

      test('a1.UserDto to User works', () {
        const dto = fixture_a1.UserDto(name: 'John Wick', age: 42);
        final converted = mappr.convert<fixture_a1.UserDto, fixture.User>(dto);

        expect(converted, equals(const fixture.User(name: 'John Wick', age: 42)));
      });

      test('a1.UserDto to a1.User works', () {
        const dto = fixture_a1.UserDto(name: 'John Wick', age: 42);
        final converted = mappr.convert<fixture_a1.UserDto, fixture_a1.User>(dto);

        expect(converted, equals(const fixture_a1.User(name: 'John Wick', age: 42)));
      });

      test('a1.UserDto to a2.User works', () {
        const dto = fixture_a1.UserDto(name: 'John Wick', age: 42);
        final converted = mappr.convert<fixture_a1.UserDto, fixture_a2.User>(dto);

        expect(converted, equals(const fixture_a2.User(name: 'John Wick', age: 42)));
      });

      test('a2.UserDto to User works', () {
        const dto = fixture_a2.UserDto(name: 'John Wick', age: 42);
        final converted = mappr.convert<fixture_a2.UserDto, fixture.User>(dto);

        expect(converted, equals(const fixture.User(name: 'John Wick', age: 42)));
      });

      test('a2.UserDto to a1.User works', () {
        const dto = fixture_a2.UserDto(name: 'John Wick', age: 42);
        final converted = mappr.convert<fixture_a2.UserDto, fixture_a1.User>(dto);

        expect(converted, equals(const fixture_a1.User(name: 'John Wick', age: 42)));
      });

      test('a2.UserDto to a2.User works', () {
        const dto = fixture_a2.UserDto(name: 'John Wick', age: 42);
        final converted = mappr.convert<fixture_a2.UserDto, fixture_a2.User>(dto);

        expect(converted, equals(const fixture_a2.User(name: 'John Wick', age: 42)));
      });
    },
  );

  group('Aliasing import with exports inside works correctly', () {
    test('XxxDto to Xxx works', () {
      const dto = fixture_a1.XxxDto(name: 'Neo', age: 69);
      final converted = mappr.convert<fixture_a1.XxxDto, fixture_a1.Xxx>(dto);

      expect(converted, equals(const fixture_a1.Xxx(name: 'Neo', age: 69)));
    });

    test('YyyDto to Yyy works', () {
      const dto = fixture_a1.YyyDto(name: 'Trinity', age: 70);
      final converted = mappr.convert<fixture_a1.YyyDto, fixture_a1.Yyy>(dto);

      expect(converted, equals(const fixture_a1.Yyy(name: 'Trinity', age: 70)));
    });
  });

  group('generics', () {
    test('Holder<a1.UserDto, a2.UserDto> to a2.Holder<a1.User, a2.User> works', () {
      const dto = fixture.Holder<fixture_a1.UserDto, fixture_a2.UserDto>(
        first: fixture_a1.UserDto(name: 'John Wick', age: 42),
        second: fixture_a2.UserDto(name: 'Obi-wan Kenobi', age: 69),
      );
      final converted = mappr.convert<fixture.Holder<fixture_a1.UserDto, fixture_a2.UserDto>,
          fixture_a2.Holder<fixture_a1.User, fixture_a2.User>>(dto);

      expect(
        converted,
        equals(
          const fixture_a2.Holder<fixture_a1.User, fixture_a2.User>(
            first: fixture_a1.User(name: 'John Wick', age: 42),
            second: fixture_a2.User(name: 'Obi-wan Kenobi', age: 69),
          ),
        ),
      );
    });
  });

  group('iterables', () {
    test('list works', () {
      const dto = fixture.ListHolder<fixture.UserDto>([
        fixture.UserDto(name: 'John Wick', age: 42),
        fixture.UserDto(name: 'Obi-wan Kenobi', age: 69),
      ]);
      final converted = mappr.convert<fixture.ListHolder<fixture.UserDto>, fixture.ListHolder<fixture_a1.User>>(dto);

      expect(
        converted,
        equals(
          const fixture.ListHolder<fixture_a1.User>([
            fixture_a1.User(name: 'John Wick', age: 42),
            fixture_a1.User(name: 'Obi-wan Kenobi', age: 69),
          ]),
        ),
      );
    });

    test('map works', () {
      const dto = fixture.MapHolder<fixture.UserDto>({
        'alpha': fixture.UserDto(name: 'John Wick', age: 42),
        'beta': fixture.UserDto(name: 'Obi-wan Kenobi', age: 69),
      });
      final converted = mappr.convert<fixture.MapHolder<fixture.UserDto>, fixture.MapHolder<fixture_a2.User>>(dto);

      expect(
        converted,
        equals(
          const fixture.MapHolder<fixture_a2.User>({
            'alpha': fixture_a2.User(name: 'John Wick', age: 42),
            'beta': fixture_a2.User(name: 'Obi-wan Kenobi', age: 69),
          }),
        ),
      );
    });
  });
}
