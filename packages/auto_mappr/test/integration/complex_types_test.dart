import 'package:test/test.dart';

import 'fixture/complex_types.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = fixture.Mappr();
  });

  test(
    'converting nested objects',
        () {
      final converted = mappr.convert<int, String>(2);

    },
  );

  test(
    'converting nested objects',
    () {
      final dto = fixture.UserDto(
        id: 123,
        tag: fixture.NestedTagDto(),
        name: fixture.NestedDto(
          78,
          name: 'Test',
          tag: fixture.NestedTagDto(),
        ),
      );
      final converted = mappr.convert<fixture.UserDto, fixture.User>(dto);

      expect(
        converted,
        fixture.User(
          id: 123,
          name: fixture.Nested(
            id: 78,
            name: 'Test',
            tag: fixture.NestedTag(),
          ),
          tag: fixture.NestedTag(),
        ),
      );
    },
  );

  test(
    "converting nested objects doesn't omit optional parameters",
    () {
      final dto = fixture.UserDto(
        id: 123,
        tag: fixture.NestedTagDto(),
        name: fixture.NestedDto(
          78,
          name: 'Test',
          tag: fixture.NestedTagDto(),
        ),
      );
      final converted = mappr.convert<fixture.UserDto, fixture.User>(dto);

      expect(
        converted,
        isNot(
          fixture.User(
            id: 123,
            name: fixture.Nested(
              id: 78,
              name: 'Test',
              tag: fixture.NestedTag(),
            ),
          ),
        ),
      );
    },
  );
}
