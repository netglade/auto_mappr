import 'package:test/test.dart';

import 'fixture/special_characters.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  group('in class', () {
    test('dollar to dollar', () {
      // arrange
      const dto = fixture.Dollar$Class(value: 1);

      // act
      final converted = mappr.convert<fixture.Dollar$Class, fixture.Dollar$Class>(dto);

      // assert
      expect(converted, equals(const fixture.Dollar$Class(value: 1)));
    });

    test('dollar to underscore', () {
      // arrange
      const dto = fixture.Dollar$Class(value: 2);

      // act
      final converted = mappr.convert<fixture.Dollar$Class, fixture.Underscore_Class>(dto);

      // assert
      expect(converted, equals(const fixture.Underscore_Class(value: 2)));
    });

    test('dollar to number', () {
      // arrange
      const dto = fixture.Dollar$Class(value: 3);

      // act
      final converted = mappr.convert<fixture.Dollar$Class, fixture.Number123Class>(dto);

      // assert
      expect(converted, equals(const fixture.Number123Class(value: 3)));
    });

    test('underscore to dollar', () {
      // arrange
      const dto = fixture.Underscore_Class(value: 4);

      // act
      final converted = mappr.convert<fixture.Underscore_Class, fixture.Dollar$Class>(dto);

      // assert
      expect(converted, equals(const fixture.Dollar$Class(value: 4)));
    });

    test('underscore to underscore', () {
      // arrange
      const dto = fixture.Underscore_Class(value: 5);

      // act
      final converted = mappr.convert<fixture.Underscore_Class, fixture.Underscore_Class>(dto);

      // assert
      expect(converted, equals(const fixture.Underscore_Class(value: 5)));
    });

    test('underscore to number', () {
      // arrange
      const dto = fixture.Underscore_Class(value: 6);

      // act
      final converted = mappr.convert<fixture.Underscore_Class, fixture.Number123Class>(dto);

      // assert
      expect(converted, equals(const fixture.Number123Class(value: 6)));
    });

    test('number to dollar', () {
      // arrange
      const dto = fixture.Number123Class(value: 7);

      // act
      final converted = mappr.convert<fixture.Number123Class, fixture.Dollar$Class>(dto);

      // assert
      expect(converted, equals(const fixture.Dollar$Class(value: 7)));
    });

    test('number to underscore', () {
      // arrange
      const dto = fixture.Number123Class(value: 8);

      // act
      final converted = mappr.convert<fixture.Number123Class, fixture.Underscore_Class>(dto);

      // assert
      expect(converted, equals(const fixture.Underscore_Class(value: 8)));
    });

    test('number to number', () {
      // arrange
      const dto = fixture.Number123Class(value: 9);

      // act
      final converted = mappr.convert<fixture.Number123Class, fixture.Number123Class>(dto);

      // assert
      expect(converted, equals(const fixture.Number123Class(value: 9)));
    });
  });

  group('in field', () {
    test('dollar to dollar', () {
      // arrange
      const dto = fixture.DollarField(val$ue: 1);

      // act
      final converted = mappr.convert<fixture.DollarField, fixture.DollarField>(dto);

      // assert
      expect(converted, equals(const fixture.DollarField(val$ue: 1)));
    });

    test('dollar to underscore', () {
      // arrange
      const dto = fixture.DollarField(val$ue: 2);

      // act
      final converted = mappr.convert<fixture.DollarField, fixture.UnderscoreField>(dto);

      // assert
      expect(converted, equals(const fixture.UnderscoreField(val_ue: 2)));
    });

    test('dollar to number', () {
      // arrange
      const dto = fixture.DollarField(val$ue: 3);

      // act
      final converted = mappr.convert<fixture.DollarField, fixture.NumberField>(dto);

      // assert
      expect(converted, equals(const fixture.NumberField(val123ue: 3)));
    });

    test('underscore to dollar', () {
      // arrange
      const dto = fixture.UnderscoreField(val_ue: 4);

      // act
      final converted = mappr.convert<fixture.UnderscoreField, fixture.DollarField>(dto);

      // assert
      expect(converted, equals(const fixture.DollarField(val$ue: 4)));
    });

    test('underscore to underscore', () {
      // arrange
      const dto = fixture.UnderscoreField(val_ue: 5);

      // act
      final converted = mappr.convert<fixture.UnderscoreField, fixture.UnderscoreField>(dto);

      // assert
      expect(converted, equals(const fixture.UnderscoreField(val_ue: 5)));
    });

    test('underscore to number', () {
      // arrange
      const dto = fixture.UnderscoreField(val_ue: 6);

      // act
      final converted = mappr.convert<fixture.UnderscoreField, fixture.NumberField>(dto);

      // assert
      expect(converted, equals(const fixture.NumberField(val123ue: 6)));
    });

    test('number to dollar', () {
      // arrange
      const dto = fixture.NumberField(val123ue: 7);

      // act
      final converted = mappr.convert<fixture.NumberField, fixture.DollarField>(dto);

      // assert
      expect(converted, equals(const fixture.DollarField(val$ue: 7)));
    });

    test('number to underscore', () {
      // arrange
      const dto = fixture.NumberField(val123ue: 8);

      // act
      final converted = mappr.convert<fixture.NumberField, fixture.UnderscoreField>(dto);

      // assert
      expect(converted, equals(const fixture.UnderscoreField(val_ue: 8)));
    });

    test('number to number', () {
      // arrange
      const dto = fixture.NumberField(val123ue: 9);

      // act
      final converted = mappr.convert<fixture.NumberField, fixture.NumberField>(dto);

      // assert
      expect(converted, equals(const fixture.NumberField(val123ue: 9)));
    });
  });
}
