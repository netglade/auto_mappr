import 'package:test/test.dart';

import 'fixture/constructor_parameters.dart' as fixture;

void main() {
  late final fixture.MapprX mappr;

  setUpAll(() {
    mappr = const fixture.MapprX();
  });

  group('Positional to positional', () {
    test('with note', () {
      const dto = fixture.Positional(18, 'John', 'test note');
      final converted = mappr.convert<fixture.Positional, fixture.Positional>(dto);

      expect(converted, equals(const fixture.Positional(18, 'John', 'test note')));
    });

    test('without note', () {
      const dto = fixture.Positional(28, 'Steven');
      final converted = mappr.convert<fixture.Positional, fixture.Positional>(dto);

      expect(converted, equals(const fixture.Positional(28, 'Steven')));
    });
  });

  group('Positional to named', () {
    test('with note', () {
      const dto = fixture.Positional(9421, 'Thomas', 'note note');
      final converted = mappr.convert<fixture.Positional, fixture.Named>(dto);

      expect(
        converted,
        equals(const fixture.Named(age: 9421, name: 'Thomas', note: 'note note')),
      );
    });

    test('without note', () {
      const dto = fixture.Positional(78438, 'Carol');
      final converted = mappr.convert<fixture.Positional, fixture.Named>(dto);

      expect(converted, equals(const fixture.Named(age: 78438, name: 'Carol')));
    });
  });

  group('Named to positional', () {
    test('with note', () {
      const dto = fixture.Named(age: 753000, name: 'Daniel', note: 'alpha note');
      final converted = mappr.convert<fixture.Named, fixture.Positional>(dto);

      expect(
        converted,
        equals(const fixture.Positional(753000, 'Daniel', 'alpha note')),
      );
    });

    test('without note', () {
      const dto = fixture.Named(age: 1001, name: 'Jake');
      final converted = mappr.convert<fixture.Named, fixture.Positional>(dto);

      expect(converted, equals(const fixture.Positional(1001, 'Jake')));
    });
  });

  group('Named to named', () {
    test('with note', () {
      const dto = fixture.Named(age: 741852963, name: 'Peter', note: 'xyz note');
      final converted = mappr.convert<fixture.Named, fixture.Named>(dto);

      expect(
        converted,
        equals(const fixture.Named(age: 741852963, name: 'Peter', note: 'xyz note')),
      );
    });

    test('without note', () {
      const dto = fixture.Named(age: 987321465, name: 'Mike');
      final converted = mappr.convert<fixture.Named, fixture.Named>(dto);

      expect(converted, equals(const fixture.Named(age: 987321465, name: 'Mike')));
    });
  });
}
