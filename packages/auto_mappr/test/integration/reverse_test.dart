import 'package:test/test.dart';

import 'fixture/reverse.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  group('converting primitives', () {
    test('PrimitiveDto to Primitive', () {
      // arrange
      const dto = fixture.PrimitiveDto(
        number: 111,
        string: 'Uzumaki Naruto',
      );

      // act
      final converted = mappr.convert<fixture.PrimitiveDto, fixture.Primitive>(dto);

      // assert
      expect(
        converted,
        equals(
          const fixture.Primitive(number: 111, string: 'Uzumaki Naruto'),
        ),
      );
    });

    test('Primitive to PrimitiveDto', () {
      // arrange
      const dto = fixture.Primitive(number: 111, string: 'Uzumaki Naruto');

      // act
      final converted = mappr.convert<fixture.Primitive, fixture.PrimitiveDto>(dto);

      // assert
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
      // arrange
      const dto = fixture.AddressDto(street: 'Alpha', city: 'Beta');

      // act
      final converted = mappr.convert<fixture.AddressDto, fixture.Address>(dto);

      // assert
      expect(
        converted,
        equals(const fixture.Address(street: 'Alpha', city: 'Beta')),
      );
    });

    test('Address to AddressDto', () {
      // arrange
      const dto = fixture.Address(street: 'Gama', city: 'Delta');

      // act
      final converted = mappr.convert<fixture.Address, fixture.AddressDto>(dto);

      // assert
      expect(
        converted,
        equals(const fixture.AddressDto(street: 'Gama', city: 'Delta')),
      );
    });

    test('UserDto to User', () {
      // arrange
      const dto = fixture.UserDto(
        1,
        name: 'Xxx 1',
        address: fixture.AddressDto(street: 'test street 1', city: 'test city 1'),
      );

      // act
      final converted = mappr.convert<fixture.UserDto, fixture.User>(dto);

      // assert
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
      // arrange
      const dto = fixture.User(
        id: 2,
        name: 'Xxx 2',
        address: fixture.Address(street: 'test street 2', city: 'test city 2'),
      );

      // act
      final converted = mappr.convert<fixture.User, fixture.UserDto>(dto);

      // assert
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
      // arrange
      const dto = fixture.AddressDto(street: 'Street 14', city: 'Wakanda');

      // act
      final converted = mappr.convert<fixture.AddressDto, fixture.SpecialAddress>(dto);

      // assert
      expect(converted, equals(const fixture.SpecialAddress(specialStreet: 'Street 14', specialCity: 'Wakanda')));
    });

    test('SpecialAddress to AddressDto', () {
      // arrange
      const dto = fixture.SpecialAddress(specialStreet: 'Street 14', specialCity: 'Wakanda');

      // act
      final converted = mappr.convert<fixture.SpecialAddress, fixture.AddressDto>(dto);

      // assert
      expect(converted, equals(const fixture.AddressDto(street: 'Street 14', city: 'Wakanda')));
    });
  });
}
