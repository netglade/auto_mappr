import 'package:test/test.dart';

import 'fixture/equatable.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  test('Equatable.props and only-setter fields are not mapped', () {
    // arrange
    const dto = fixture.Source(123);

    // act
    final converted = mappr.convert<fixture.Source, fixture.Target>(dto);

    // assert
    expect(converted, equals(const fixture.Target(123)));
  });
}
