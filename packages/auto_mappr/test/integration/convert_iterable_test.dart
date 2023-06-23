import 'package:test/test.dart';

import 'fixture/convert_iterable.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  fixture.UserDto getUserDto(int number) {
    return fixture.UserDto(
      userName: 'testUser$number',
      age: number,
      address: fixture.AddressDto(
        street: 'testStreet$number',
        city: 'testCity$number',
        country: 'testCountry$number',
      ),
    );
  }

  fixture.UserWithDefaultDto getUserWithDefaultDto(int number) {
    return fixture.UserWithDefaultDto(
      userName: 'testUser$number',
      age: number,
      address: fixture.AddressDto(
        street: 'testStreet$number',
        city: 'testCity$number',
        country: 'testCountry$number',
      ),
    );
  }

  fixture.User getUser(int number) {
    return fixture.User(
      userName: 'testUser$number',
      age: number,
      address: fixture.Address(
        street: 'testStreet$number',
        city: 'testCity$number',
        country: 'testCountry$number',
      ),
    );
  }

  group('Iterable', () {
    test('convertIterable w/o null', () {
      final converted = mappr.convertIterable<fixture.UserDto, fixture.User>(
        [getUserDto(1), getUserDto(2), getUserDto(3)].where((_) => true),
      );

      expect(converted, equals([getUser(1), getUser(2), getUser(3)]));
    });

    test('convertIterable with null throws', () {
      expect(
        () => mappr.convertIterable<fixture.UserDto, fixture.User>(
          [getUserDto(1), getUserDto(2), getUserDto(3), null].where((_) => true),
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('convertIterable with null and default value does not throw', () {
      final converted = mappr.convertIterable<fixture.UserWithDefaultDto, fixture.User>(
        [
          getUserWithDefaultDto(1),
          getUserWithDefaultDto(2),
          getUserWithDefaultDto(3),
          null,
        ].where((_) => true),
      );

      expect(
        converted,
        equals([
          getUser(1),
          getUser(2),
          getUser(3),
          const fixture.User(
            userName: 'defaultUserName',
            age: 666,
            address: fixture.Address(street: 'defaultStreet', city: 'defaultCity', country: 'defaultCountry'),
          ),
        ]),
      );
    });

    test('tryConvertIterable w/o null', () {
      final converted = mappr.tryConvertIterable<fixture.UserDto, fixture.User>(
        [getUserDto(1), getUserDto(2), getUserDto(3)].where((_) => true),
      );

      expect(converted, equals([getUser(1), getUser(2), getUser(3)]));
    });

    test('tryConvertIterable with null', () {
      final converted = mappr.tryConvertIterable<fixture.UserDto, fixture.User>(
        [getUserDto(1), getUserDto(2), getUserDto(3), null].where((_) => true),
      );

      expect(converted, equals([getUser(1), getUser(2), getUser(3), null]));
    });

    test('tryConvertIterable with null and default value', () {
      final converted = mappr.tryConvertIterable<fixture.UserWithDefaultDto, fixture.User>(
        [
          getUserWithDefaultDto(1),
          getUserWithDefaultDto(2),
          getUserWithDefaultDto(3),
          null,
        ].where((_) => true),
      );

      expect(
        converted,
        equals([
          getUser(1),
          getUser(2),
          getUser(3),
          const fixture.User(
            userName: 'defaultUserName',
            age: 666,
            address: fixture.Address(street: 'defaultStreet', city: 'defaultCity', country: 'defaultCountry'),
          ),
        ]),
      );
    });
  });

  group('List', () {
    test('convertList w/o null', () {
      final converted = mappr.convertList<fixture.UserDto, fixture.User>(
        [getUserDto(1), getUserDto(2), getUserDto(3)],
      );

      expect(converted, equals([getUser(1), getUser(2), getUser(3)]));
    });

    test('convertList with null throws', () {
      expect(
        () => mappr.convertList<fixture.UserDto, fixture.User>(
          [getUserDto(1), getUserDto(2), getUserDto(3), null],
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('convertList with null and default value does not throw', () {
      final converted = mappr.convertList<fixture.UserWithDefaultDto, fixture.User>(
        [
          getUserWithDefaultDto(1),
          getUserWithDefaultDto(2),
          getUserWithDefaultDto(3),
          null,
        ],
      );

      expect(
        converted,
        equals([
          getUser(1),
          getUser(2),
          getUser(3),
          const fixture.User(
            userName: 'defaultUserName',
            age: 666,
            address: fixture.Address(street: 'defaultStreet', city: 'defaultCity', country: 'defaultCountry'),
          ),
        ]),
      );
    });

    test('tryConvertList w/o null', () {
      final converted = mappr.tryConvertList<fixture.UserDto, fixture.User>(
        [getUserDto(1), getUserDto(2), getUserDto(3)],
      );

      expect(converted, equals([getUser(1), getUser(2), getUser(3)]));
    });

    test('tryConvertList with null', () {
      final converted = mappr.tryConvertList<fixture.UserDto, fixture.User>(
        [getUserDto(1), getUserDto(2), getUserDto(3), null],
      );

      expect(converted, equals([getUser(1), getUser(2), getUser(3), null]));
    });

    test('tryConvertList with null and default value', () {
      final converted = mappr.tryConvertList<fixture.UserWithDefaultDto, fixture.User>(
        [
          getUserWithDefaultDto(1),
          getUserWithDefaultDto(2),
          getUserWithDefaultDto(3),
          null,
        ],
      );

      expect(
        converted,
        equals([
          getUser(1),
          getUser(2),
          getUser(3),
          const fixture.User(
            userName: 'defaultUserName',
            age: 666,
            address: fixture.Address(street: 'defaultStreet', city: 'defaultCity', country: 'defaultCountry'),
          ),
        ]),
      );
    });
  });

  group('Set', () {
    test('convertSet w/o null', () {
      final converted = mappr.convertSet<fixture.UserDto, fixture.User>(
        {getUserDto(1), getUserDto(2), getUserDto(3)},
      );

      expect(converted, equals({getUser(1), getUser(2), getUser(3)}));
    });

    test('convertSet with null throws', () {
      expect(
        () => mappr.convertSet<fixture.UserDto, fixture.User>(
          {getUserDto(1), getUserDto(2), getUserDto(3), null},
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('convertSet with null and default value does not throw', () {
      final converted = mappr.convertSet<fixture.UserWithDefaultDto, fixture.User>(
        {
          getUserWithDefaultDto(1),
          getUserWithDefaultDto(2),
          getUserWithDefaultDto(3),
          null,
        }.where((_) => true),
      );

      expect(
        converted,
        equals({
          getUser(1),
          getUser(2),
          getUser(3),
          const fixture.User(
            userName: 'defaultUserName',
            age: 666,
            address: fixture.Address(street: 'defaultStreet', city: 'defaultCity', country: 'defaultCountry'),
          ),
        }),
      );
    });

    test('tryConvertList w/o null', () {
      final converted = mappr.tryConvertList<fixture.UserDto, fixture.User>(
        {getUserDto(1), getUserDto(2), getUserDto(3)},
      );

      expect(converted, equals({getUser(1), getUser(2), getUser(3)}));
    });

    test('tryConvertList with null', () {
      final converted = mappr.tryConvertList<fixture.UserDto, fixture.User>(
        {getUserDto(1), getUserDto(2), getUserDto(3), null},
      );

      expect(converted, equals({getUser(1), getUser(2), getUser(3), null}));
    });

    test('tryConvertSet with null and default value', () {
      final converted = mappr.tryConvertSet<fixture.UserWithDefaultDto, fixture.User>(
        {
          getUserWithDefaultDto(1),
          getUserWithDefaultDto(2),
          getUserWithDefaultDto(3),
          null,
        }.where((_) => true),
      );

      expect(
        converted,
        equals({
          getUser(1),
          getUser(2),
          getUser(3),
          const fixture.User(
            userName: 'defaultUserName',
            age: 666,
            address: fixture.Address(street: 'defaultStreet', city: 'defaultCity', country: 'defaultCountry'),
          ),
        }),
      );
    });
  });
}
