import 'package:test/test.dart';

import 'fixture/default_field.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = fixture.Mappr();
  });

  group('value as default', () {
    group('complex-type default with positional parameters', () {
      test('default value used when null', () {
        // arrange
        const dto = fixture.ComplexPositionalValueDto(18, null);

        // act
        final converted = mappr.convert<fixture.ComplexPositionalValueDto, fixture.ComplexPositionalValue>(dto);

        // assert
        expect(
          converted,
          equals(const fixture.ComplexPositionalValue(18, fixture.Nested(id: 963, name: 'tag test'))),
        );
      });

      test('default value not used when not null', () {
        // arrange
        const dto = fixture.ComplexPositionalValueDto(74, fixture.NestedDto(123, name: 'Test'));

        // act
        final converted = mappr.convert<fixture.ComplexPositionalValueDto, fixture.ComplexPositionalValue>(dto);

        // assert
        expect(
          converted,
          equals(const fixture.ComplexPositionalValue(74, fixture.Nested(id: 123, name: 'Test'))),
        );
      });
    });

    group('complex-type default with named parameters', () {
      test('default value used when null', () {
        // arrange
        const dto = fixture.ComplexNamedValueDto(age: 47, name: null);

        // act
        final converted = mappr.convert<fixture.ComplexNamedValueDto, fixture.ComplexNamedValue>(dto);

        // assert
        expect(
          converted,
          equals(const fixture.ComplexNamedValue(age: 47, name: fixture.Nested(id: 492, name: 'tag test 2'))),
        );
      });

      test('default value not used when not null', () {
        // arrange
        const dto = fixture.ComplexNamedValueDto(age: 92, name: fixture.NestedDto(123, name: 'Test'));

        // act
        final converted = mappr.convert<fixture.ComplexNamedValueDto, fixture.ComplexNamedValue>(dto);

        // assert
        expect(
          converted,
          equals(const fixture.ComplexNamedValue(age: 92, name: fixture.Nested(id: 123, name: 'Test'))),
        );
      });
    });

    group('primitive-type default with positional parameters', () {
      test('default value used when null', () {
        // arrange
        const dto = fixture.PrimitivePositionalValueDto(116, null);

        // act
        final converted = mappr.convert<fixture.PrimitivePositionalValueDto, fixture.PrimitivePositionalValue>(dto);

        // assert
        expect(
          converted,
          equals(const fixture.PrimitivePositionalValue(116, 'test abc')),
        );
      });

      test('default value not used when not null', () {
        // arrange
        const dto = fixture.PrimitivePositionalValueDto(7474, 'Hello there!');

        // act
        final converted = mappr.convert<fixture.PrimitivePositionalValueDto, fixture.PrimitivePositionalValue>(dto);

        // assert
        expect(
          converted,
          equals(const fixture.PrimitivePositionalValue(7474, 'Hello there!')),
        );
      });
    });

    group('primitive-type default with named parameters', () {
      test('default value used when null', () {
        // arrange
        const dto = fixture.PrimitiveNamedValueDto(age: 333_999, name: null);

        // act
        final converted = mappr.convert<fixture.PrimitiveNamedValueDto, fixture.PrimitiveNamedValue>(dto);

        // assert
        expect(
          converted,
          equals(const fixture.PrimitiveNamedValue(age: 333_999, name: 'test def')),
        );
      });

      test('default value not used when not null', () {
        // arrange
        const dto = fixture.PrimitiveNamedValueDto(age: 999_333, name: 'Abracadabra');

        // act
        final converted = mappr.convert<fixture.PrimitiveNamedValueDto, fixture.PrimitiveNamedValue>(dto);

        // assert
        expect(
          converted,
          equals(const fixture.PrimitiveNamedValue(age: 999_333, name: 'Abracadabra')),
        );
      });
    });
  });

  group('function as default', () {
    group('complex-type default with positional parameters', () {
      test('default value used when null', () {
        // arrange
        const dto = fixture.ComplexPositionalFunctionDto(12, null);

        // act
        final converted = mappr.convert<fixture.ComplexPositionalFunctionDto, fixture.ComplexPositionalFunction>(dto);

        // assert
        expect(
          converted,
          equals(fixture.ComplexPositionalFunction(12, fixture.Mappr.defaultNested())),
        );
      });

      test('default value not used when not null', () {
        // arrange
        const dto = fixture.ComplexPositionalFunctionDto(12, fixture.NestedDto(123, name: 'Test'));

        // act
        final converted = mappr.convert<fixture.ComplexPositionalFunctionDto, fixture.ComplexPositionalFunction>(dto);

        // assert
        expect(
          converted,
          equals(const fixture.ComplexPositionalFunction(12, fixture.Nested(id: 123, name: 'Test'))),
        );
      });
    });

    group('complex-type default with named parameters', () {
      test('default value used when null', () {
        // arrange
        const dto = fixture.ComplexNamedFunctionDto(age: 12, name: null);

        // act
        final converted = mappr.convert<fixture.ComplexNamedFunctionDto, fixture.ComplexNamedFunction>(dto);

        // assert
        expect(
          converted,
          equals(fixture.ComplexNamedFunction(age: 12, name: fixture.Mappr.defaultNested())),
        );
      });

      test('default value not used when not null', () {
        // arrange
        const dto = fixture.ComplexNamedFunctionDto(age: 12, name: fixture.NestedDto(123, name: 'Test'));

        // act
        final converted = mappr.convert<fixture.ComplexNamedFunctionDto, fixture.ComplexNamedFunction>(dto);

        // assert
        expect(
          converted,
          equals(const fixture.ComplexNamedFunction(age: 12, name: fixture.Nested(id: 123, name: 'Test'))),
        );
      });
    });

    group('primitive-type default with positional parameters', () {
      test('default value used when null', () {
        // arrange
        const dto = fixture.PrimitivePositionalFunctionDto(89, null);

        // act
        final converted = mappr.convert<fixture.PrimitivePositionalFunctionDto, fixture.PrimitivePositionalFunction>(
          dto,
        );

        // assert
        expect(
          converted,
          equals(const fixture.PrimitivePositionalFunction(89, 'Test123')),
        );
      });

      test('default value not used when not null', () {
        // arrange
        const dto = fixture.PrimitivePositionalFunctionDto(77, 'Hello there!');

        // act
        final converted = mappr.convert<fixture.PrimitivePositionalFunctionDto, fixture.PrimitivePositionalFunction>(
          dto,
        );

        // assert
        expect(
          converted,
          equals(const fixture.PrimitivePositionalFunction(77, 'Hello there!')),
        );
      });
    });

    group('primitive-type default with named parameters', () {
      test('default value used when null', () {
        // arrange
        const dto = fixture.PrimitiveNamedFunctionDto(age: 11, name: null);

        // act
        final converted = mappr.convert<fixture.PrimitiveNamedFunctionDto, fixture.PrimitiveNamedFunction>(dto);

        // assert
        expect(
          converted,
          equals(const fixture.PrimitiveNamedFunction(age: 11, name: 'Test123')),
        );
      });

      test('default value not used when not null', () {
        // arrange
        const dto = fixture.PrimitiveNamedFunctionDto(age: 111, name: 'Abracadabra');

        // act
        final converted = mappr.convert<fixture.PrimitiveNamedFunctionDto, fixture.PrimitiveNamedFunction>(dto);

        // assert
        expect(
          converted,
          equals(const fixture.PrimitiveNamedFunction(age: 111, name: 'Abracadabra')),
        );
      });
    });
  });
}
