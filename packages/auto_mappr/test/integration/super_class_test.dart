import 'package:test/test.dart';

import 'fixture/super_class.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  test('converting from sub-class to flattened-class works', () {
    // arrange
    const dto = fixture.SubClass(first: 123, second: 456);

    // act
    final converted = mappr.convert<fixture.SubClass, fixture.FlattenedClass>(dto);

    // assert
    expect(converted, equals(const fixture.FlattenedClass(first: 123, second: 456)));
  });

  test('converting from flattened-class to sub-class works', () {
    // arrange
    const dto = fixture.FlattenedClass(first: 123, second: 456);

    // act
    final converted = mappr.convert<fixture.FlattenedClass, fixture.SubClass>(dto);

    // assert
    expect(converted, equals(const fixture.SubClass(first: 123, second: 456)));
  });
}
