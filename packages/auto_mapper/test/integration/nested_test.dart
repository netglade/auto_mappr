import 'package:test/test.dart';

import 'fixture/nested.dart' as fixture;

void main() {
  late final fixture.Mapper mapper;

  setUpAll(() {
    mapper = fixture.Mapper();
  });

  test(
    'converting nested objects works',
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
      final converted = mapper.convert<fixture.UserDto, fixture.User>(dto);

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
      final converted = mapper.convert<fixture.UserDto, fixture.User>(dto);

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
