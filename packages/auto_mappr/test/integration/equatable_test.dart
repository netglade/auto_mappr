import 'package:test/test.dart';

import 'fixture/equatable.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  test('Equatable.props and only-setter fields are not mapped', () {
    const dto = fixture.Source(123);
    final converted = mappr.convert<fixture.Source, fixture.Target>(dto);

    expect(converted, equals(const fixture.Target(123)));
  });
}
