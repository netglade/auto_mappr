import 'package:test/test.dart';

import 'fixture/when_null_default.dart' as fixture;

void main() {
  late final fixture.Mapper mapper;

  setUpAll(() {
    mapper = fixture.Mapper();
  });

  group(
    'AutoMap',
    () {
      // TODO
    },
  );

  group(
    'MapMember',
    () {
      group(
        'complex-type default with positional parameters',
        () {
          test('default value used when null', () {
            final converted = mapper.convert<fixture.ComplexPositionalDto, fixture.ComplexPositional>(
              fixture.ComplexPositionalDto(12, null),
            );

            expect(converted.age, 12);
            expect(converted.name, fixture.Mapper.defaultNested());
          });

          test('default value not used when not null', () {
            final converted = mapper.convert<fixture.ComplexPositionalDto, fixture.ComplexPositional>(
              fixture.ComplexPositionalDto(12, fixture.NestedDto(123, name: 'Test')),
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
            final converted = mapper.convert<fixture.ComplexNamedDto, fixture.ComplexNamed>(
              fixture.ComplexNamedDto(age: 12, name: null),
            );

            expect(converted.age, 12);
            expect(converted.name, fixture.Mapper.defaultNested());
          });

          test('default value not used when not null', () {
            final converted = mapper.convert<fixture.ComplexNamedDto, fixture.ComplexNamed>(
              fixture.ComplexNamedDto(age: 12, name: fixture.NestedDto(123, name: 'Test')),
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
            final converted = mapper.convert<fixture.PrimitivePositionalDto, fixture.PrimitivePositional>(
              fixture.PrimitivePositionalDto(89, null),
            );

            expect(converted.age, 89);
            expect(converted.name, fixture.Mapper.defaultString());
          });

          test('default value not used when not null', () {
            final converted = mapper.convert<fixture.PrimitivePositionalDto, fixture.PrimitivePositional>(
              fixture.PrimitivePositionalDto(77, 'Hello there!'),
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
            final converted = mapper.convert<fixture.PrimitiveNamedDto, fixture.PrimitiveNamed>(
              fixture.PrimitiveNamedDto(age: 11, name: null),
            );

            expect(converted.age, 11);
            expect(converted.name, fixture.Mapper.defaultString());
          });

          test('default value not used when not null', () {
            final converted = mapper.convert<fixture.PrimitiveNamedDto, fixture.PrimitiveNamed>(
              fixture.PrimitiveNamedDto(age: 111, name: 'Abracadabra'),
            );

            expect(converted.age, 111);
            expect(converted.name, 'Abracadabra');
          });
        },
      );
    },
  );
}
