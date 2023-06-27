import 'package:test/test.dart';

import 'fixture/complex_types.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  test('converting nested objects', () {
    const dto = fixture.UserDto(
      id: 123,
      tag: fixture.NestedTagDto(),
      name: fixture.NestedDto(78, name: 'Test', tag: fixture.NestedTagDto()),
    );
    final converted = mappr.convert<fixture.UserDto, fixture.User>(dto);

    expect(
      converted,
      equals(
        const fixture.User(
          id: 123,
          name: fixture.Nested(id: 78, name: 'Test', tag: fixture.NestedTag()),
          tag: fixture.NestedTag(),
        ),
      ),
    );
  });

  test("converting nested objects doesn't omit optional parameters", () {
    const dto = fixture.UserDto(
      id: 123,
      tag: fixture.NestedTagDto(),
      name: fixture.NestedDto(78, name: 'Test', tag: fixture.NestedTagDto()),
    );
    final converted = mappr.convert<fixture.UserDto, fixture.User>(dto);

    expect(
      converted,
      isNot(
        const fixture.User(
          id: 123,
          name: fixture.Nested(
            id: 78,
            name: 'Test',
            tag: fixture.NestedTag(),
          ),
        ),
      ),
    );
  });
}
