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
            final converted = mapper.convert<fixture.ComplexPositionalValueDto, fixture.ComplexPositionalValue>(
              fixture.ComplexPositionalValueDto(18, null),
            );

            expect(converted.age, 18);
            expect(converted.name, fixture.Nested(id: 963, name: 'tag test'));
          });

          test('default value not used when not null', () {
            final converted = mapper.convert<fixture.ComplexPositionalValueDto, fixture.ComplexPositionalValue>(
              fixture.ComplexPositionalValueDto(74, fixture.NestedDto(123, name: 'Test')),
            );

            expect(converted.age, 74);
            expect(converted.name, fixture.Nested(id: 123, name: 'Test'));
          });
        },
      );

      group(
        'complex-type default with named parameters',
        () {
          test('default value used when null', () {
            final converted = mapper.convert<fixture.ComplexNamedValueDto, fixture.ComplexNamedValue>(
              fixture.ComplexNamedValueDto(age: 47, name: null),
            );

            expect(converted.age, 47);
            expect(converted.name, fixture.Nested(id: 492, name: 'tag test 2'));
          });

          test('default value not used when not null', () {
            final converted = mapper.convert<fixture.ComplexNamedValueDto, fixture.ComplexNamedValue>(
              fixture.ComplexNamedValueDto(age: 92, name: fixture.NestedDto(123, name: 'Test')),
            );

            expect(converted.age, 92);
            expect(converted.name, fixture.Nested(id: 123, name: 'Test'));
          });
        },
      );

      group(
        'primitive-type default with positional parameters',
        () {
          test('default value used when null', () {
            final converted = mapper.convert<fixture.PrimitivePositionalValueDto, fixture.PrimitivePositionalValue>(
              fixture.PrimitivePositionalValueDto(116, null),
            );

            expect(converted.age, 116);
            expect(converted.name, 'test abc');
          });

          test('default value not used when not null', () {
            final converted = mapper.convert<fixture.PrimitivePositionalValueDto, fixture.PrimitivePositionalValue>(
              fixture.PrimitivePositionalValueDto(7474, 'Hello there!'),
            );

            expect(converted.age, 7474);
            expect(converted.name, 'Hello there!');
          });
        },
      );

      group(
        'primitive-type default with named parameters',
        () {
          test('default value used when null', () {
            final converted = mapper.convert<fixture.PrimitiveNamedValueDto, fixture.PrimitiveNamedValue>(
              fixture.PrimitiveNamedValueDto(age: 333999, name: null),
            );

            expect(converted.age, 333999);
            expect(converted.name, 'test def');
          });

          test('default value not used when not null', () {
            final converted = mapper.convert<fixture.PrimitiveNamedValueDto, fixture.PrimitiveNamedValue>(
              fixture.PrimitiveNamedValueDto(age: 999333, name: 'Abracadabra'),
            );

            expect(converted.age, 999333);
            expect(converted.name, 'Abracadabra');
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
            final converted = mapper.convert<fixture.ComplexPositionalFunctionDto, fixture.ComplexPositionalFunction>(
              fixture.ComplexPositionalFunctionDto(12, null),
            );

            expect(converted.age, 12);
            expect(converted.name, fixture.Mapper.defaultNested());
          });

          test('default value not used when not null', () {
            final converted = mapper.convert<fixture.ComplexPositionalFunctionDto, fixture.ComplexPositionalFunction>(
              fixture.ComplexPositionalFunctionDto(12, fixture.NestedDto(123, name: 'Test')),
            );

            expect(converted.age, 12);
            expect(converted.name, fixture.Nested(id: 123, name: 'Test'));
          });
        },
      );

      group(
        'complex-type default with named parameters',
        () {
          test('default value used when null', () {
            final converted = mapper.convert<fixture.ComplexNamedFunctionDto, fixture.ComplexNamedFunction>(
              fixture.ComplexNamedFunctionDto(age: 12, name: null),
            );

            expect(converted.age, 12);
            expect(converted.name, fixture.Mapper.defaultNested());
          });

          test('default value not used when not null', () {
            final converted = mapper.convert<fixture.ComplexNamedFunctionDto, fixture.ComplexNamedFunction>(
              fixture.ComplexNamedFunctionDto(age: 12, name: fixture.NestedDto(123, name: 'Test')),
            );

            expect(converted.age, 12);
            expect(converted.name, fixture.Nested(id: 123, name: 'Test'));
          });
        },
      );

      group(
        'primitive-type default with positional parameters',
        () {
          test('default value used when null', () {
            final converted =
                mapper.convert<fixture.PrimitivePositionalFunctionDto, fixture.PrimitivePositionalFunction>(
              fixture.PrimitivePositionalFunctionDto(89, null),
            );

            expect(converted.age, 89);
            expect(converted.name, fixture.Mapper.defaultString());
          });

          test('default value not used when not null', () {
            final converted =
                mapper.convert<fixture.PrimitivePositionalFunctionDto, fixture.PrimitivePositionalFunction>(
              fixture.PrimitivePositionalFunctionDto(77, 'Hello there!'),
            );

            expect(converted.age, 77);
            expect(converted.name, 'Hello there!');
          });
        },
      );

      group(
        'primitive-type default with named parameters',
        () {
          test('default value used when null', () {
            final converted = mapper.convert<fixture.PrimitiveNamedFunctionDto, fixture.PrimitiveNamedFunction>(
              fixture.PrimitiveNamedFunctionDto(age: 11, name: null),
            );

            expect(converted.age, 11);
            expect(converted.name, fixture.Mapper.defaultString());
          });

          test('default value not used when not null', () {
            final converted = mapper.convert<fixture.PrimitiveNamedFunctionDto, fixture.PrimitiveNamedFunction>(
              fixture.PrimitiveNamedFunctionDto(age: 111, name: 'Abracadabra'),
            );

            expect(converted.age, 111);
            expect(converted.name, 'Abracadabra');
          });
        },
      );
    },
  );
}
