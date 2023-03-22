import 'package:test/test.dart';

import 'fixture/default_field.dart' as fixture;

void main() {
  late final fixture.Mapper mapper;

  setUpAll(() {
    mapper = fixture.Mapper();
  });

  group(
    'value as default',
    () {
      group(
        'complex-type default with positional parameters',
        () {
          test('default value used when null', () {
            final dto = fixture.ComplexPositionalValueDto(18, null);
            final converted = mapper.convert<fixture.ComplexPositionalValueDto, fixture.ComplexPositionalValue>(dto);

            expect(
              converted,
              const fixture.ComplexPositionalValue(18, fixture.Nested(id: 963, name: 'tag test')),
            );
          });

          test('default value not used when not null', () {
            final dto = fixture.ComplexPositionalValueDto(74, fixture.NestedDto(123, name: 'Test'));
            final converted = mapper.convert<fixture.ComplexPositionalValueDto, fixture.ComplexPositionalValue>(dto);

            expect(
              converted,
              const fixture.ComplexPositionalValue(74, fixture.Nested(id: 123, name: 'Test')),
            );
          });
        },
      );

      group(
        'complex-type default with named parameters',
        () {
          test('default value used when null', () {
            final dto = fixture.ComplexNamedValueDto(age: 47, name: null);
            final converted = mapper.convert<fixture.ComplexNamedValueDto, fixture.ComplexNamedValue>(dto);

            expect(
              converted,
              const fixture.ComplexNamedValue(age: 47, name: fixture.Nested(id: 492, name: 'tag test 2')),
            );
          });

          test('default value not used when not null', () {
            final dto = fixture.ComplexNamedValueDto(age: 92, name: fixture.NestedDto(123, name: 'Test'));
            final converted = mapper.convert<fixture.ComplexNamedValueDto, fixture.ComplexNamedValue>(dto);

            expect(
              converted,
              const fixture.ComplexNamedValue(age: 92, name: fixture.Nested(id: 123, name: 'Test')),
            );
          });
        },
      );

      group(
        'primitive-type default with positional parameters',
        () {
          test('default value used when null', () {
            final dto = fixture.PrimitivePositionalValueDto(116, null);
            final converted =
                mapper.convert<fixture.PrimitivePositionalValueDto, fixture.PrimitivePositionalValue>(dto);

            expect(
              converted,
              const fixture.PrimitivePositionalValue(116, 'test abc'),
            );
          });

          test('default value not used when not null', () {
            final dto = fixture.PrimitivePositionalValueDto(7474, 'Hello there!');
            final converted =
                mapper.convert<fixture.PrimitivePositionalValueDto, fixture.PrimitivePositionalValue>(dto);

            expect(
              converted,
              const fixture.PrimitivePositionalValue(7474, 'Hello there!'),
            );
          });
        },
      );

      group(
        'primitive-type default with named parameters',
        () {
          test('default value used when null', () {
            final dto = fixture.PrimitiveNamedValueDto(age: 333999, name: null);
            final converted = mapper.convert<fixture.PrimitiveNamedValueDto, fixture.PrimitiveNamedValue>(dto);

            expect(
              converted,
              const fixture.PrimitiveNamedValue(age: 333999, name: 'test def'),
            );
          });

          test('default value not used when not null', () {
            final dto = fixture.PrimitiveNamedValueDto(age: 999333, name: 'Abracadabra');
            final converted = mapper.convert<fixture.PrimitiveNamedValueDto, fixture.PrimitiveNamedValue>(dto);

            expect(
              converted,
              const fixture.PrimitiveNamedValue(age: 999333, name: 'Abracadabra'),
            );
          });
        },
      );
    },
  );

  group(
    'function as default',
    () {
      group(
        'complex-type default with positional parameters',
        () {
          test('default value used when null', () {
            final dto = fixture.ComplexPositionalFunctionDto(12, null);
            final converted =
                mapper.convert<fixture.ComplexPositionalFunctionDto, fixture.ComplexPositionalFunction>(dto);

            expect(
              converted,
              fixture.ComplexPositionalFunction(12, fixture.Mapper.defaultNested()),
            );
          });

          test('default value not used when not null', () {
            final dto = fixture.ComplexPositionalFunctionDto(12, fixture.NestedDto(123, name: 'Test'));
            final converted =
                mapper.convert<fixture.ComplexPositionalFunctionDto, fixture.ComplexPositionalFunction>(dto);

            expect(
              converted,
              const fixture.ComplexPositionalFunction(12, fixture.Nested(id: 123, name: 'Test')),
            );
          });
        },
      );

      group(
        'complex-type default with named parameters',
        () {
          test('default value used when null', () {
            final dto = fixture.ComplexNamedFunctionDto(age: 12, name: null);
            final converted = mapper.convert<fixture.ComplexNamedFunctionDto, fixture.ComplexNamedFunction>(dto);

            expect(
              converted,
              fixture.ComplexNamedFunction(age: 12, name: fixture.Mapper.defaultNested()),
            );
          });

          test('default value not used when not null', () {
            final dto = fixture.ComplexNamedFunctionDto(age: 12, name: fixture.NestedDto(123, name: 'Test'));
            final converted = mapper.convert<fixture.ComplexNamedFunctionDto, fixture.ComplexNamedFunction>(dto);

            expect(
              converted,
              const fixture.ComplexNamedFunction(age: 12, name: fixture.Nested(id: 123, name: 'Test')),
            );
          });
        },
      );

      group(
        'primitive-type default with positional parameters',
        () {
          test('default value used when null', () {
            final dto = fixture.PrimitivePositionalFunctionDto(89, null);
            final converted =
                mapper.convert<fixture.PrimitivePositionalFunctionDto, fixture.PrimitivePositionalFunction>(dto);

            expect(
              converted,
              const fixture.PrimitivePositionalFunction(89, 'Test123'),
            );
          });

          test('default value not used when not null', () {
            final dto = fixture.PrimitivePositionalFunctionDto(77, 'Hello there!');
            final converted =
                mapper.convert<fixture.PrimitivePositionalFunctionDto, fixture.PrimitivePositionalFunction>(dto);

            expect(
              converted,
              const fixture.PrimitivePositionalFunction(77, 'Hello there!'),
            );
          });
        },
      );

      group(
        'primitive-type default with named parameters',
        () {
          test('default value used when null', () {
            final dto = fixture.PrimitiveNamedFunctionDto(age: 11, name: null);
            final converted = mapper.convert<fixture.PrimitiveNamedFunctionDto, fixture.PrimitiveNamedFunction>(dto);

            expect(
              converted,
              const fixture.PrimitiveNamedFunction(age: 11, name: 'Test123'),
            );
          });

          test('default value not used when not null', () {
            final dto = fixture.PrimitiveNamedFunctionDto(age: 111, name: 'Abracadabra');
            final converted = mapper.convert<fixture.PrimitiveNamedFunctionDto, fixture.PrimitiveNamedFunction>(dto);

            expect(
              converted,
              const fixture.PrimitiveNamedFunction(age: 111, name: 'Abracadabra'),
            );
          });
        },
      );
    },
  );
}
