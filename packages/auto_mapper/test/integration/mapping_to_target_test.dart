import 'package:test/test.dart';

import 'fixture/mapping_to_target.dart' as fixture;

void main() {
  late final fixture.Mapper mapper;

  setUpAll(() {
    mapper = fixture.Mapper();
  });

  test('Target fields are correctly assigned using constructor arguments or setters', () {
    final dto = fixture.OneDto(
      usingConstructor1: 42,
      usingConstructor2: 'Heya',
      withoutConstructor1: true,
      withoutConstructor2: 9.42,
      withoutConstructor3: 666,
    );
    final converted = mapper.convert<fixture.OneDto, fixture.One>(dto);

    expect(
      converted,
      fixture.One(
        usingConstructor1: 42,
        usingConstructor2: 'Heya',
      )
        ..withoutConstructor1 = true
        ..withoutConstructor2 = 9.42
        ..withoutConstructor3 = 666,
    );
  });
}
