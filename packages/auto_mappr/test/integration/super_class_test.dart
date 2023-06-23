import 'package:test/test.dart';

import 'fixture/super_class.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  test('converting from sub-class to flattened-class works', () {
    const dto = fixture.SubClass(first: 123, second: 456);
    final converted = mappr.convert<fixture.SubClass, fixture.FlattenedClass>(dto);

    expect(converted, equals(const fixture.FlattenedClass(first: 123, second: 456)));
  });

  test('converting from flattened-class to sub-class works', () {
    const dto = fixture.FlattenedClass(first: 123, second: 456);
    final converted = mappr.convert<fixture.FlattenedClass, fixture.SubClass>(dto);

    expect(converted, equals(const fixture.SubClass(first: 123, second: 456)));
  });
}
