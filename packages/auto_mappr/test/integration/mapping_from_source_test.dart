import 'dart:math';

import 'package:test/test.dart';

import 'fixture/mapping_from_source.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;
  final random = Random();

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  group('Instance field', () {
    for (final item in List.generate(5, (index) => random.nextInt(1000))) {
      test('with value of $item can mapped from', () {
        final dto = fixture.InstanceField(item);
        final converted = mappr.convert<fixture.InstanceField, fixture.ValueHolder>(dto);

        expect(converted, equals(fixture.ValueHolder(item)..secondValue = 'test 1'));
      });
    }
  });

  group('Instance getter', () {
    for (final item in List.generate(5, (index) => random.nextInt(1000))) {
      test('with value of $item can mapped from', () {
        final dto = fixture.InstanceGetter()..value = item;
        final converted = mappr.convert<fixture.InstanceGetter, fixture.ValueHolder>(dto);

        expect(converted, equals(fixture.ValueHolder(item)..secondValue = 'test 2'));
      });
    }
  });

  group('Static field', () {
    for (final item in List.generate(5, (index) => random.nextInt(1000))) {
      test('with value of $item can mapped from', () {
        fixture.StaticField.value = item;
        final dto = fixture.StaticField();
        final converted = mappr.convert<fixture.StaticField, fixture.ValueHolder>(dto);

        expect(converted, equals(fixture.ValueHolder(item)..secondValue = 'test 3'));
      });
    }
  });

  group('Static getter', () {
    for (final item in List.generate(5, (index) => random.nextInt(1000))) {
      test('with value of $item can mapped from', () {
        fixture.StaticGetter.value = item;
        final dto = fixture.StaticGetter();
        final converted = mappr.convert<fixture.StaticGetter, fixture.ValueHolder>(dto);

        expect(converted, equals(fixture.ValueHolder(item)..secondValue = 'test 4'));
      });
    }
  });
}
