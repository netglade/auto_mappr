import 'package:test/test.dart';

import 'fixture/reverse.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  group('converting primitives', () {
    test('PrimitiveDto to Primitive', () {
      const dto = fixture.PrimitiveDto(
        number: 111,
        string: 'Uzumaki Naruto',
      );
      final converted = mappr.convert<fixture.PrimitiveDto, fixture.Primitive>(dto);

      expect(
        converted,
        equals(
          const fixture.Primitive(number: 111, string: 'Uzumaki Naruto'),
        ),
      );
    });

    test('Primitive to PrimitiveDto', () {
      const dto = fixture.Primitive(number: 111, string: 'Uzumaki Naruto');
      final converted = mappr.convert<fixture.Primitive, fixture.PrimitiveDto>(dto);

      expect(
        converted,
        equals(
          const fixture.PrimitiveDto(number: 111, string: 'Uzumaki Naruto'),
        ),
      );
    });
  });

  group('converting nested objects', () {
    test('AddressDto to Address', () {
      const dto = fixture.AddressDto(street: 'Alpha', city: 'Beta');
      final converted = mappr.convert<fixture.AddressDto, fixture.Address>(dto);

      expect(
        converted,
        equals(const fixture.Address(street: 'Alpha', city: 'Beta')),
      );
    });

    test('Address to AddressDto', () {
      const dto = fixture.Address(street: 'Gama', city: 'Delta');
      final converted = mappr.convert<fixture.Address, fixture.AddressDto>(dto);

      expect(
        converted,
        equals(const fixture.AddressDto(street: 'Gama', city: 'Delta')),
      );
    });

    test('UserDto to User', () {
      const dto =
          fixture.UserDto(1, name: 'Xxx 1', address: fixture.AddressDto(street: 'test street 1', city: 'test city 1'));
      final converted = mappr.convert<fixture.UserDto, fixture.User>(dto);

      expect(
        converted,
        equals(
          const fixture.User(
            id: 1,
            name: 'Xxx 1',
            address: fixture.Address(street: 'test street 1', city: 'test city 1'),
          ),
        ),
      );
    });

    test('User to UserDto', () {
      const dto =
          fixture.User(id: 2, name: 'Xxx 2', address: fixture.Address(street: 'test street 2', city: 'test city 2'));
      final converted = mappr.convert<fixture.User, fixture.UserDto>(dto);

      expect(
        converted,
        equals(
          const fixture.UserDto(
            2,
            name: 'Xxx 2',
            address: fixture.AddressDto(street: 'test street 2', city: 'test city 2'),
          ),
        ),
      );
    });
  });

  group('Reverse mapping with custom fields', () {
    test('AddressDto to SpecialAddress', () {
      const dto = fixture.AddressDto(street: 'Street 14', city: 'Wakanda');

      final converted = mappr.convert<fixture.AddressDto, fixture.SpecialAddress>(dto);

      expect(converted, equals(const fixture.SpecialAddress(specialStreet: 'Street 14', specialCity: 'Wakanda')));
    });

    test('SpecialAddress to AddressDto', () {
      const dto = fixture.SpecialAddress(specialStreet: 'Street 14', specialCity: 'Wakanda');

      final converted = mappr.convert<fixture.SpecialAddress, fixture.AddressDto>(dto);

      expect(converted, equals(const fixture.AddressDto(street: 'Street 14', city: 'Wakanda')));
    });
  });
}
