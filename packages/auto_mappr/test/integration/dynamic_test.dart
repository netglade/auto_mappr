import 'package:test/test.dart';

import 'fixture/dynamic.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  group('using converter', () {
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

    test('from iterable dynamic', () {
      const source = [fixture.DynamicDto(value: 5), fixture.DynamicDto(value: 1)];
      final converted = mappr.convertIterable<fixture.DynamicDto, fixture.Int>(source);

      expect(converted, isA<Iterable<fixture.Int>>());
      expect(converted.length, equals(2));
    });
  });

  group('without converter', () {
    test('from dynamic to int', () {
      const source = fixture.DynamicNoConverter(value: 5);
      final converted = mappr.convert<fixture.DynamicNoConverter, fixture.IntNoConverter>(source);

      expect(converted, isA<fixture.IntNoConverter>());
      expect(converted.value, isA<int>());
      expect(converted.value, equals(5));
    });

    test('from int to dynamic', () {
      const source = fixture.IntNoConverter(value: 5);
      final converted = mappr.convert<fixture.IntNoConverter, fixture.DynamicNoConverter>(source);

      expect(converted, isA<fixture.DynamicNoConverter>());
      expect(converted.value, isA<int>());
      expect(converted.value, equals(5));
    });

    test('from iterable dynamic', () {
      const source = [fixture.DynamicNoConverter(value: 5), fixture.DynamicNoConverter(value: 1)];
      final converted = mappr.convertIterable<fixture.DynamicNoConverter, fixture.IntNoConverter>(source);

      expect(converted, isA<Iterable<fixture.IntNoConverter>>());
      expect(converted.length, equals(2));
    });
  });
}
