import 'package:test/test.dart';

import 'fixture/field_override.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  test('converting from source to target with overridden field works', () {
    const dto = fixture.Source(value: 123);
    final converted = mappr.convert<fixture.Source, fixture.Target>(dto);

    expect(converted, equals(const fixture.Target(value: 123)));
  });

  test('converting from source to target with overridden nested field using interface works', () {
    const dto = fixture.NestedSource(value: fixture.SourceData(value: 123));
    final converted = mappr.convert<fixture.NestedSource, fixture.NestedTarget>(dto);

    expect(converted, equals(const fixture.NestedTarget(value: fixture.TargetData(value: 123))));
  });
}
