import 'package:test/test.dart';

import 'fixture/try_convert.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = fixture.Mappr();
  });

  group('convert', () {
    test('Throws when no default is configured', () {
      expect(() => mappr.convert<fixture.NestedDto, fixture.Nested>(null), throwsA(predicate((e) => e is Exception)));
    });

    test('Returns default when configured', () {
      expect(
        mappr.convert<fixture.ComplexValueDto, fixture.ComplexValue>(null),
        const fixture.ComplexValue(99, fixture.Nested(id: 123, name: 'test qwerty')),
      );
    });
  });

  group('tryConvert', () {
    test('Return null when no default is configured', () {
      expect(mappr.tryConvert<fixture.NestedDto, fixture.Nested>(null), isNull);
    });

    test('Returns default when configured', () {
      expect(
        mappr.tryConvert<fixture.ComplexValueDto, fixture.ComplexValue>(null),
        const fixture.ComplexValue(99, fixture.Nested(id: 123, name: 'test qwerty')),
      );
    });
  });
}
