import 'package:test/test.dart';

import 'fixture/multiple_annotations.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  test('Generates and converts when multiple annotations on Mappr used', () {
    // arrange
    const dto = fixture.UserDto(age: 42, name: 'Obi-wan Kenobi');

    // act
    final converted = mappr.convert<fixture.UserDto, fixture.User>(dto);

    // assert
    expect(converted, equals(const fixture.User(age: 42, name: 'Obi-wan Kenobi')));
  });
}
