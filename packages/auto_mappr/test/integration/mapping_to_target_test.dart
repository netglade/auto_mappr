import 'package:test/test.dart';

import 'fixture/mapping_to_target.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  test('Target fields are correctly assigned using constructor arguments or setters', () {
    // arrange
    const dto = fixture.OneDto(
      usingConstructor1: 42,
      usingConstructor2: 'Heya',
      withoutConstructor1: true,
      withoutConstructor2: 9.42,
      withoutConstructor3: 666,
    );

    // act
    final converted = mappr.convert<fixture.OneDto, fixture.One>(dto);

    // assert
    expect(
      converted,
      equals(
        fixture.One(usingConstructor1: 42, usingConstructor2: 'Heya')
          ..withoutConstructor1 = true
          ..withoutConstructor2 = 9.42
          ..withoutConstructor3 = 666,
      ),
    );
  });
}
