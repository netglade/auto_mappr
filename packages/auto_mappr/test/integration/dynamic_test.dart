import 'package:test/test.dart';

import 'fixture/type_converters.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  group('convert', () {
    group('from dynamic to int', () {
      test('string to int', () {
        const source = fixture.DynamicDto(value: '5');
        final converted = mappr.convert<fixture.DynamicDto, fixture.Int>(source);

        expect(converted.value, equals(5));
      });

      test('int to int', () {
        const source = fixture.DynamicDto(value: 5);
        final converted = mappr.convert<fixture.DynamicDto, fixture.Int>(source);

        expect(converted.value, equals(5));
      });

      test('unknown type to 0', () {
        const source = fixture.DynamicDto();
        final converted = mappr.convert<fixture.DynamicDto, fixture.Int>(source);

        expect(converted.value, equals(0));
      });
    });

    group('from int to dynamic', () {
      test('to int', () {
        const source = fixture.Int(value: 20);
        final converted = mappr.convert<fixture.Int, fixture.Dynamic>(source);

        expect(converted, isA<fixture.Dynamic>());
        expect(converted.value, isA<int>());
        expect(converted.value, equals(20));
      });

      test('to string', () {
        const source = fixture.Int(value: 60);
        final converted = mappr.convert<fixture.Int, fixture.Dynamic>(source);

        expect(converted, isA<fixture.Dynamic>());
        expect(converted.value, isA<String>());
        expect(converted.value, equals('60'));
      });
    });

    test('from dynamic to dynamic', () {
      const source = fixture.DynamicDto(value: 'test');
      final converted = mappr.convert<fixture.DynamicDto, fixture.Dynamic>(source);

      expect(converted, isA<fixture.Dynamic>());
      expect(converted.value, equals('test'));
    });
  });
}
