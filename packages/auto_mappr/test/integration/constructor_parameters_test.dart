import 'package:test/test.dart';

import 'fixture/constructor_parameters.dart' as fixture;

void main() {
  late final fixture.MapprX mappr;

  setUpAll(() {
    mappr = const fixture.MapprX();
  });

  group('Positional to positional', () {
    test('with note', () {
      // arrange
      const dto = fixture.Positional(18, 'John', 'test note');

      // act
      final converted = mappr.convert<fixture.Positional, fixture.Positional>(dto);

      // assert
      expect(converted, equals(const fixture.Positional(18, 'John', 'test note')));
    });

    test('without note', () {
      // arrange
      const dto = fixture.Positional(28, 'Steven');

      // act
      final converted = mappr.convert<fixture.Positional, fixture.Positional>(dto);

      // assert
      expect(converted, equals(const fixture.Positional(28, 'Steven')));
    });
  });

  group('Positional to named', () {
    test('with note', () {
      // arrange
      const dto = fixture.Positional(9421, 'Thomas', 'note note');

      // act
      final converted = mappr.convert<fixture.Positional, fixture.Named>(dto);

      // assert
      expect(
        converted,
        equals(const fixture.Named(age: 9421, name: 'Thomas', note: 'note note')),
      );
    });

    test('without note', () {
      // arrange
      const dto = fixture.Positional(78438, 'Carol');

      // act
      final converted = mappr.convert<fixture.Positional, fixture.Named>(dto);

      // assert
      expect(converted, equals(const fixture.Named(age: 78438, name: 'Carol')));
    });
  });

  group('Named to positional', () {
    test('with note', () {
      // arrange
      const dto = fixture.Named(age: 753_000, name: 'Daniel', note: 'alpha note');

      // act
      final converted = mappr.convert<fixture.Named, fixture.Positional>(dto);

      // assert
      expect(
        converted,
        equals(const fixture.Positional(753_000, 'Daniel', 'alpha note')),
      );
    });

    test('without note', () {
      // arrange
      const dto = fixture.Named(age: 1001, name: 'Jake');

      // act
      final converted = mappr.convert<fixture.Named, fixture.Positional>(dto);

      // assert
      expect(converted, equals(const fixture.Positional(1001, 'Jake')));
    });
  });

  group('Named to named', () {
    test('with note', () {
      // arrange
      const dto = fixture.Named(age: 741_852_963, name: 'Peter', note: 'xyz note');

      // act
      final converted = mappr.convert<fixture.Named, fixture.Named>(dto);

      // assert
      expect(
        converted,
        equals(const fixture.Named(age: 741_852_963, name: 'Peter', note: 'xyz note')),
      );
    });

    test('without note', () {
      // arrange
      const dto = fixture.Named(age: 987_321_465, name: 'Mike');

      // act
      final converted = mappr.convert<fixture.Named, fixture.Named>(dto);

      // assert
      expect(converted, equals(const fixture.Named(age: 987_321_465, name: 'Mike')));
    });
  });
}
