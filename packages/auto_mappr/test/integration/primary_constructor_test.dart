import 'package:test/test.dart';

import 'fixture/primary_constructor.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  group('target with primary constructor', () {
    test('positional declaring parameters', () {
      // arrange
      const dto = fixture.PositionalDto(1, 2, 3);

      // act
      final converted = mappr.convert<fixture.PositionalDto, fixture.PositionalTarget>(dto);

      // assert
      expect(converted, equals(const fixture.PositionalTarget(1, 2, 3)));
    });

    test('named declaring parameters', () {
      // arrange
      const dto = fixture.NamedDto(name: 'Alice', age: 30, nickname: 'Ali');

      // act
      final converted = mappr.convert<fixture.NamedDto, fixture.NamedTarget>(dto);

      // assert
      expect(converted, equals(const fixture.NamedTarget(name: 'Alice', age: 30, nickname: 'Ali')));
    });

    test('named primary constructor', () {
      // arrange
      const dto = fixture.NamedDto(name: 'Bob', age: 41);

      // act
      final converted = mappr.convert<fixture.NamedDto, fixture.NamedConstructorTarget>(dto);

      // assert
      expect(converted, equals(const fixture.NamedConstructorTarget.create(name: 'Bob', age: 41)));
    });

    test('mutable declaring parameters and setter for the remaining field', () {
      // arrange
      const dto = fixture.PositionalDto(1, 2, 3);

      // act
      final converted = mappr.convert<fixture.PositionalDto, fixture.MutableTarget>(dto);

      // assert
      expect(converted.a, equals(1));
      expect(converted.b, equals(2));
      expect(converted.c, equals(3));
    });

    test('non-declaring parameter mapped with Field.from', () {
      // arrange
      const dto = fixture.PositionalDto(1, 2, 3);

      // act
      final converted = mappr.convert<fixture.PositionalDto, fixture.NonDeclaringParameterTarget>(dto);

      // assert
      expect(converted, equals(fixture.NonDeclaringParameterTarget(1, 2)));
      expect(converted.doubled, equals(4));
    });

    test('super parameters', () {
      // arrange
      const dto = fixture.EmployeeDto('Carol', 52, 'developer');

      // act
      final converted = mappr.convert<fixture.EmployeeDto, fixture.Employee>(dto);

      // assert
      expect(converted, equals(const fixture.Employee('Carol', 52, 'developer')));
    });

    test('selected secondary constructor', () {
      // arrange
      const dto = fixture.PositionalDto(1, 2, 3);

      // act
      final converted = mappr.convert<fixture.PositionalDto, fixture.SecondaryConstructorTarget>(dto);

      // assert
      expect(converted, equals(const fixture.SecondaryConstructorTarget(1, -1, -1)));
    });
  });

  group('source with primary constructor', () {
    test('maps to a target with a classic constructor', () {
      // arrange
      const dto = fixture.PositionalDto(1, 2, 3);

      // act
      final converted = mappr.convert<fixture.PositionalDto, fixture.ClassicTarget>(dto);

      // assert
      expect(converted, equals(const fixture.ClassicTarget(1, 2)));
    });
  });

  group('enum with primary constructor', () {
    test('maps by name', () {
      // arrange
      const source = fixture.RemoteStatus.inactive;

      // act
      final converted = mappr.convert<fixture.RemoteStatus, fixture.LocalStatus>(source);

      // assert
      expect(converted, equals(fixture.LocalStatus.inactive));
    });

    test('falls back to whenSourceIsNull for an unknown value', () {
      // arrange
      const source = fixture.RemoteStatus.archived;

      // act
      final converted = mappr.convert<fixture.RemoteStatus, fixture.LocalStatus>(source);

      // assert
      expect(converted, equals(fixture.LocalStatus.unknown));
    });
  });
}
