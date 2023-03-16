import 'package:test/test.dart';

import 'fixture/default_target.dart' as fixture;

void main() {
  late final fixture.Mapper mapper;

  setUpAll(() {
    mapper = fixture.Mapper();
  });

  group(
    'target as value default',
    () {
      group(
        'complex-type default with positional parameters',
        () {
          test('default value used when null', () {
            final converted = mapper.convert<fixture.ComplexPositionalValueDto, fixture.ComplexPositionalValue>(null);

            expect(
              converted,
              fixture.ComplexPositionalValue(99, fixture.Nested(id: 123, name: 'test qwerty')),
            );
          });

          test('default value not used when not null', () {
            final converted = mapper.convert<fixture.ComplexPositionalValueDto, fixture.ComplexPositionalValue>(
              fixture.ComplexPositionalValueDto(18, fixture.NestedDto(12, name: 'Alpha test')),
            );

            expect(
              converted,
              fixture.ComplexPositionalValue(18, fixture.Nested(id: 12, name: 'Alpha test')),
            );
          });
        },
      );

      group(
        'complex-type default with named parameters',
        () {
          test('default value used when null', () {
            final converted = mapper.convert<fixture.ComplexNamedValueDto, fixture.ComplexNamedValue>(null);

            expect(converted, fixture.ComplexNamedValue(age: 4567, name: fixture.Nested(id: 12, name: 'mko')));
          });

          test('default value not used when not null', () {
            final converted = mapper.convert<fixture.ComplexNamedValueDto, fixture.ComplexNamedValue>(
              fixture.ComplexNamedValueDto(age: 23, name: fixture.NestedDto(24, name: 'Beta test')),
            );

            expect(
              converted,
              fixture.ComplexNamedValue(age: 23, name: fixture.Nested(id: 24, name: 'Beta test')),
            );
          });
        },
      );

      group(
        'primitive-type default with positional parameters',
        () {
          test('default value used when null', () {
            final converted =
                mapper.convert<fixture.PrimitivePositionalValueDto, fixture.PrimitivePositionalValue>(null);

            expect(converted, fixture.PrimitivePositionalValue(99, 'xyx'));
          });

          test('default value not used when not null', () {
            final converted = mapper.convert<fixture.PrimitivePositionalValueDto, fixture.PrimitivePositionalValue>(
              fixture.PrimitivePositionalValueDto(25, 'Gama test'),
            );

            expect(
              converted,
              fixture.PrimitivePositionalValue(25, 'Gama test'),
            );
          });
        },
      );

      group(
        'primitive-type default with named parameters',
        () {
          test('default value used when null', () {
            final converted = mapper.convert<fixture.PrimitiveNamedValueDto, fixture.PrimitiveNamedValue>(null);

            expect(converted, fixture.PrimitiveNamedValue(age: 99, name: 'xyx'));
          });

          test('default value not used when not null', () {
            final converted = mapper.convert<fixture.PrimitiveNamedValueDto, fixture.PrimitiveNamedValue>(
              fixture.PrimitiveNamedValueDto(age: 26, name: 'Delta test'),
            );

            expect(
              converted,
              fixture.PrimitiveNamedValue(age: 26, name: 'Delta test'),
            );
          });
        },
      );
    },
  );

  group(
    'target as function default',
    () {
      group(
        'complex-type default with positional parameters',
        () {
          test('default value used when null', () {
            final converted =
                mapper.convert<fixture.ComplexPositionalFunctionDto, fixture.ComplexPositionalFunction>(null);

            expect(converted, fixture.ComplexPositionalFunction(99, fixture.Nested(id: 123, name: 'test qwerty')));
          });

          test('default value not used when not null', () {
            final converted = mapper.convert<fixture.ComplexPositionalFunctionDto, fixture.ComplexPositionalFunction>(
              fixture.ComplexPositionalFunctionDto(31, fixture.NestedDto(32, name: 'test alpha')),
            );

            expect(
              converted,
              fixture.ComplexPositionalFunction(31, fixture.Nested(id: 32, name: 'test alpha')),
            );
          });
        },
      );

      group(
        'complex-type default with named parameters',
        () {
          test('default value used when null', () {
            final converted = mapper.convert<fixture.ComplexNamedFunctionDto, fixture.ComplexNamedFunction>(null);

            expect(
              converted,
              fixture.ComplexNamedFunction(age: 99, name: fixture.Nested(id: 123, name: 'test qwerty')),
            );
          });

          test('default value not used when not null', () {
            final converted = mapper.convert<fixture.ComplexNamedFunctionDto, fixture.ComplexNamedFunction>(
              fixture.ComplexNamedFunctionDto(age: 32, name: fixture.NestedDto(33, name: 'test beta')),
            );

            expect(
              converted,
              fixture.ComplexNamedFunction(age: 32, name: fixture.Nested(id: 33, name: 'test beta')),
            );
          });
        },
      );

      group(
        'primitive-type default with positional parameters',
        () {
          test('default value used when null', () {
            final converted =
                mapper.convert<fixture.PrimitivePositionalFunctionDto, fixture.PrimitivePositionalFunction>(null);

            expect(
              converted,
              fixture.PrimitivePositionalFunction(99, 'bbb'),
            );
          });

          test('default value not used when not null', () {
            final converted =
                mapper.convert<fixture.PrimitivePositionalFunctionDto, fixture.PrimitivePositionalFunction>(
              fixture.PrimitivePositionalFunctionDto(34, 'test gama'),
            );

            expect(
              converted,
              fixture.PrimitivePositionalFunction(34, 'test gama'),
            );
          });
        },
      );

      group(
        'primitive-type default with named parameters',
        () {
          test('default value used when null', () {
            final converted = mapper.convert<fixture.PrimitiveNamedFunctionDto, fixture.PrimitiveNamedFunction>(null);

            expect(converted, fixture.PrimitiveNamedFunction(age: 99, name: 'aaa'));
          });

          test('default value not used when not null', () {
            final converted = mapper.convert<fixture.PrimitiveNamedFunctionDto, fixture.PrimitiveNamedFunction>(
              fixture.PrimitiveNamedFunctionDto(age: 35, name: 'test delta'),
            );

            expect(
              converted,
              fixture.PrimitiveNamedFunction(age: 35, name: 'test delta'),
            );
          });
        },
      );
    },
  );
}
