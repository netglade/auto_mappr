import 'package:test/test.dart';

import 'fixture/default_target.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = fixture.Mappr();
  });

  group('target as value default', () {
    group('complex-type default with positional parameters', () {
      test('default value used when null', () {
        const fixture.ComplexPositionalValueDto? dto = null;
        final converted = mappr.convert<fixture.ComplexPositionalValueDto, fixture.ComplexPositionalValue>(dto);

        expect(
          converted,
          equals(const fixture.ComplexPositionalValue(99, fixture.Nested(id: 123, name: 'test qwerty'))),
        );
      });

      test('default value not used when not null', () {
        const dto = fixture.ComplexPositionalValueDto(18, fixture.NestedDto(12, name: 'Alpha test'));
        final converted = mappr.convert<fixture.ComplexPositionalValueDto, fixture.ComplexPositionalValue>(dto);

        expect(
          converted,
          equals(const fixture.ComplexPositionalValue(18, fixture.Nested(id: 12, name: 'Alpha test'))),
        );
      });
    });

    group('complex-type default with named parameters', () {
      test('default value used when null', () {
        const fixture.ComplexNamedValueDto? dto = null;
        final converted = mappr.convert<fixture.ComplexNamedValueDto, fixture.ComplexNamedValue>(dto);

        expect(
          converted,
          equals(const fixture.ComplexNamedValue(age: 4567, name: fixture.Nested(id: 12, name: 'mko'))),
        );
      });

      test('default value not used when not null', () {
        const dto = fixture.ComplexNamedValueDto(age: 23, name: fixture.NestedDto(24, name: 'Beta test'));
        final converted = mappr.convert<fixture.ComplexNamedValueDto, fixture.ComplexNamedValue>(dto);

        expect(
          converted,
          equals(const fixture.ComplexNamedValue(age: 23, name: fixture.Nested(id: 24, name: 'Beta test'))),
        );
      });
    });

    group('primitive-type default with positional parameters', () {
      test('default value used when null', () {
        const fixture.PrimitivePositionalValueDto? dto = null;
        final converted = mappr.convert<fixture.PrimitivePositionalValueDto, fixture.PrimitivePositionalValue>(dto);

        expect(converted, equals(const fixture.PrimitivePositionalValue(99, 'xyx')));
      });

      test('default value not used when not null', () {
        const dto = fixture.PrimitivePositionalValueDto(25, 'Gama test');
        final converted = mappr.convert<fixture.PrimitivePositionalValueDto, fixture.PrimitivePositionalValue>(dto);

        expect(
          converted,
          equals(const fixture.PrimitivePositionalValue(25, 'Gama test')),
        );
      });
    });

    group('primitive-type default with named parameters', () {
      test('default value used when null', () {
        const fixture.PrimitiveNamedValueDto? dto = null;
        final converted = mappr.convert<fixture.PrimitiveNamedValueDto, fixture.PrimitiveNamedValue>(dto);

        expect(converted, equals(const fixture.PrimitiveNamedValue(age: 99, name: 'xyx')));
      });

      test('default value not used when not null', () {
        const dto = fixture.PrimitiveNamedValueDto(age: 26, name: 'Delta test');
        final converted = mappr.convert<fixture.PrimitiveNamedValueDto, fixture.PrimitiveNamedValue>(dto);

        expect(
          converted,
          equals(const fixture.PrimitiveNamedValue(age: 26, name: 'Delta test')),
        );
      });
    });
  });

  group('target as function default', () {
    group('complex-type default with positional parameters', () {
      test('default value used when null', () {
        const fixture.ComplexPositionalFunctionDto? dto = null;
        final converted = mappr.convert<fixture.ComplexPositionalFunctionDto, fixture.ComplexPositionalFunction>(dto);

        expect(
          converted,
          equals(const fixture.ComplexPositionalFunction(99, fixture.Nested(id: 123, name: 'test qwerty'))),
        );
      });

      test('default value not used when not null', () {
        const dto = fixture.ComplexPositionalFunctionDto(31, fixture.NestedDto(32, name: 'test alpha'));
        final converted = mappr.convert<fixture.ComplexPositionalFunctionDto, fixture.ComplexPositionalFunction>(dto);

        expect(
          converted,
          equals(const fixture.ComplexPositionalFunction(31, fixture.Nested(id: 32, name: 'test alpha'))),
        );
      });
    });

    group('complex-type default with named parameters', () {
      test('default value used when null', () {
        const fixture.ComplexNamedFunctionDto? dto = null;
        final converted = mappr.convert<fixture.ComplexNamedFunctionDto, fixture.ComplexNamedFunction>(dto);

        expect(
          converted,
          equals(const fixture.ComplexNamedFunction(age: 99, name: fixture.Nested(id: 123, name: 'test qwerty'))),
        );
      });

      test('default value not used when not null', () {
        const dto = fixture.ComplexNamedFunctionDto(age: 32, name: fixture.NestedDto(33, name: 'test beta'));
        final converted = mappr.convert<fixture.ComplexNamedFunctionDto, fixture.ComplexNamedFunction>(dto);

        expect(
          converted,
          equals(const fixture.ComplexNamedFunction(age: 32, name: fixture.Nested(id: 33, name: 'test beta'))),
        );
      });
    });

    group('primitive-type default with positional parameters', () {
      test('default value used when null', () {
        const fixture.PrimitivePositionalFunctionDto? dto = null;
        final converted =
            mappr.convert<fixture.PrimitivePositionalFunctionDto, fixture.PrimitivePositionalFunction>(dto);

        expect(
          converted,
          equals(const fixture.PrimitivePositionalFunction(99, 'bbb')),
        );
      });

      test('default value not used when not null', () {
        const dto = fixture.PrimitivePositionalFunctionDto(34, 'test gama');
        final converted =
            mappr.convert<fixture.PrimitivePositionalFunctionDto, fixture.PrimitivePositionalFunction>(dto);

        expect(
          converted,
          equals(const fixture.PrimitivePositionalFunction(34, 'test gama')),
        );
      });
    });

    group('primitive-type default with named parameters', () {
      test('default value used when null', () {
        const fixture.PrimitiveNamedFunctionDto? dto = null;
        final converted = mappr.convert<fixture.PrimitiveNamedFunctionDto, fixture.PrimitiveNamedFunction>(dto);

        expect(converted, equals(const fixture.PrimitiveNamedFunction(age: 99, name: 'aaa')));
      });

      test('default value not used when not null', () {
        const dto = fixture.PrimitiveNamedFunctionDto(age: 35, name: 'test delta');
        final converted = mappr.convert<fixture.PrimitiveNamedFunctionDto, fixture.PrimitiveNamedFunction>(dto);

        expect(
          converted,
          equals(const fixture.PrimitiveNamedFunction(age: 35, name: 'test delta')),
        );
      });
    });
  });
}
