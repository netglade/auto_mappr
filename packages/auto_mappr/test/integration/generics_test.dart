import 'package:test/test.dart';

import 'fixture/generics.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  group('simple', () {
    test('With<num, num> -> With<num, num>', () {
      // arrange
      const dto = fixture.With<num, num>(first: 18, second: 789);

      // act
      final converted = mappr.convert<fixture.With<num, num>, fixture.With<num, num>>(dto);

      // assert
      expect(converted, equals(const fixture.With<num, num>(first: 18, second: 789)));
    });

    test('With<Object, Object> -> With<Object, Object>', () {
      // arrange
      const dto = fixture.With<Object, Object>(first: 'Some string', second: 123_123);

      // act
      final converted = mappr.convert<fixture.With<Object, Object>, fixture.With<Object, Object>>(dto);

      // assert
      expect(converted, equals(const fixture.With<Object, Object>(first: 'Some string', second: 123_123)));
    });

    test('With<int, AlphaDto<num>> -> With<int, Alpha<num>>', () {
      // arrange
      const dto = fixture.With<int, fixture.AlphaDto<num>>(
        first: 69,
        second: fixture.AlphaDto(fixture.With<num, num>(first: 741, second: 852.666), 123),
      );

      // act
      final converted = mappr.convert<fixture.With<int, fixture.AlphaDto<num>>, fixture.With<int, fixture.Alpha<num>>>(
        dto,
      );

      // assert
      expect(
        converted,
        equals(
          const fixture.With<int, fixture.Alpha<num>>(
            first: 69,
            second: fixture.Alpha(fixture.With(first: 741, second: 852.666), 123),
          ),
        ),
      );
    });

    test('With<String, int> -> Without', () {
      // arrange
      const dto = fixture.With(first: 'test abc', second: 111_222_333);

      // act
      final converted = mappr.convert<fixture.With<String, int>, fixture.Without>(dto);

      // assert
      expect(converted, equals(const fixture.Without(first: 'test abc', second: 111_222_333)));
    });

    test('With<String, int> -> With<String, int>', () {
      // arrange
      const dto = fixture.With(first: 'test abc 2', second: 741_852_963);

      // act
      final converted = mappr.convert<fixture.With<String, int>, fixture.With<String, int>>(dto);

      // assert
      expect(converted, equals(const fixture.With<String, int>(first: 'test abc 2', second: 741_852_963)));
    });

    test('Without -> With<String, int>', () {
      // arrange
      const dto = fixture.Without(first: 'alpha test', second: 111_000);

      // act
      final converted = mappr.convert<fixture.Without, fixture.With<String, int>>(dto);

      // assert
      expect(converted, equals(const fixture.With(first: 'alpha test', second: 111_000)));
    });
  });

  group('nested', () {
    test('AlphaDto<num> -> Alpha<num>', () {
      // arrange
      const dto = fixture.AlphaDto(fixture.With<num, num>(first: 1, second: 2), 420);

      // act
      final converted = mappr.convert<fixture.AlphaDto<num>, fixture.Alpha<num>>(dto);

      // assert
      expect(converted, equals(const fixture.Alpha<num>(fixture.With<num, num>(first: 1, second: 2), 420)));
    });

    test('AlphaDto<int> -> Alpha<int>', () {
      // arrange
      const dto = fixture.AlphaDto(fixture.With(first: 7771, second: 1472), 42);

      // act
      final converted = mappr.convert<fixture.AlphaDto<int>, fixture.Alpha<int>>(dto);

      // assert
      expect(converted, equals(const fixture.Alpha<int>(fixture.With(first: 7771, second: 1472), 42)));
    });

    test('AlphaDto<String> -> Alpha<String>', () {
      // arrange
      const dto = fixture.AlphaDto(fixture.With(first: 'test a', second: 'test b'), 42);

      // act
      final converted = mappr.convert<fixture.AlphaDto<String>, fixture.Alpha<String>>(dto);

      // assert
      expect(converted, equals(const fixture.Alpha<String>(fixture.With(first: 'test a', second: 'test b'), 42)));
    });
  });

  group('collections', () {
    test('ListHolder<int, AlphaDto<num>> -> ListHolder<int, Alpha<num>>', () {
      // arrange
      const dto = fixture.ListHolder<int, fixture.AlphaDto<num>>([
        fixture.With<int, fixture.AlphaDto<num>>(
          first: 13,
          second: fixture.AlphaDto(fixture.With(first: 11.7, second: 12.99), 130),
        ),
        fixture.With<int, fixture.AlphaDto<num>>(
          first: 28,
          second: fixture.AlphaDto(fixture.With(first: 77, second: 99.99), 20),
        ),
      ]);

      // act
      final converted = mappr
          .convert<fixture.ListHolder<int, fixture.AlphaDto<num>>, fixture.ListHolder<int, fixture.Alpha<num>>>(dto);

      // assert
      expect(
        converted,
        equals(
          const fixture.ListHolder<int, fixture.Alpha<num>>([
            fixture.With<int, fixture.Alpha<num>>(
              first: 13,
              second: fixture.Alpha(fixture.With(first: 11.7, second: 12.99), 130),
            ),
            fixture.With<int, fixture.Alpha<num>>(
              first: 28,
              second: fixture.Alpha(fixture.With(first: 77, second: 99.99), 20),
            ),
          ]),
        ),
      );
    });

    test('SetHolder<String> -> SetHolder<String>', () {
      // arrange
      final dto = fixture.SetHolder({
        const fixture.With(first: 'alpha x1', second: 'alpha x2'),
        const fixture.With(first: 'alpha x3', second: 'alpha x4'),
      });

      // act
      final converted = mappr.convert<fixture.SetHolder<String>, fixture.SetHolder<String>>(dto);

      // assert
      expect(
        converted,
        equals(
          fixture.SetHolder<String>({
            const fixture.With(first: 'alpha x1', second: 'alpha x2'),
            const fixture.With(first: 'alpha x3', second: 'alpha x4'),
          }),
        ),
      );
    });

    test('IterableHolder<String, int> -> IterableHolder<String, int>', () {
      // arrange
      final dto = fixture.IterableHolder({
        const fixture.With(first: 'beta y1', second: 4201),
        const fixture.With(first: 'beta y2', second: 4202),
      });
      
      // act
      final converted = mappr.convert<fixture.IterableHolder<String, int>, fixture.IterableHolder<String, int>>(dto);

      // assert
      expect(
        converted,
        equals(
          fixture.IterableHolder({
            const fixture.With(first: 'beta y1', second: 4201),
            const fixture.With(first: 'beta y2', second: 4202),
          }),
        ),
      );
    });

    test('MapHolder<String, int, bool> -> MapHolder<String, int, bool>', () {
      // arrange
      const dto = fixture.MapHolder({
        'hello test 1': fixture.With(first: 999, second: true),
        'hello test 2': fixture.With(first: 888, second: true),
        'hello test 3': fixture.With(first: 777, second: false),
      });

      // act
      final converted = mappr.convert<fixture.MapHolder<String, int, bool>, fixture.MapHolder<String, int, bool>>(dto);

      // assert
      expect(
        converted,
        equals(
          const fixture.MapHolder<String, int, bool>({
            'hello test 1': fixture.With(first: 999, second: true),
            'hello test 2': fixture.With(first: 888, second: true),
            'hello test 3': fixture.With(first: 777, second: false),
          }),
        ),
      );
    });
  });
}
