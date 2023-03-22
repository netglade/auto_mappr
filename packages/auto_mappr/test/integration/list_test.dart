import 'package:test/test.dart';

import 'fixture/list.dart' as fixture;

void main() {
  late final fixture.Mapper mapper;

  setUpAll(() {
    mapper = fixture.Mapper();
  });

  group(
    'primitive',
    () {
      test(
        'non nullable to non nullable',
        () {
          const dto = fixture.PrimitiveDto([1, 2, 3, 4, 5]);
          final converted = mapper.convert<fixture.PrimitiveDto, fixture.Primitive>(dto);

          expect(
            converted,
            const fixture.Primitive([1, 2, 3, 4, 5]),
          );
        },
      );

      test(
        'nullable to non nullable',
        () {
          const dto = fixture.PrimitiveNullableDto([1, 2, 3, null, 4, 5, null]);
          final converted = mapper.convert<fixture.PrimitiveNullableDto, fixture.Primitive>(dto);

          expect(
            converted,
            const fixture.Primitive([1, 2, 3, 4, 5]),
          );
        },
      );
    },
  );

  group(
    'complex',
    () {
      test(
        'non nullable to non nullable',
        () {
          final dto = fixture.ComplexDto([
            fixture.NestedDto(111789, name: 'first x', tag: fixture.NestedTagDto(flag: false)),
            fixture.NestedDto(111456, name: 'second x', tag: fixture.NestedTagDto(flag: false)),
            fixture.NestedDto(111123, name: 'third x', tag: fixture.NestedTagDto(flag: true)),
          ]);
          final converted = mapper.convert<fixture.ComplexDto, fixture.Complex>(dto);

          expect(
            converted,
            const fixture.Complex([
              fixture.Nested(id: 111789, name: 'first x', tag: fixture.NestedTag(flag: false)),
              fixture.Nested(id: 111456, name: 'second x', tag: fixture.NestedTag(flag: false)),
              fixture.Nested(id: 111123, name: 'third x', tag: fixture.NestedTag(flag: true)),
            ]),
          );
        },
      );

      test(
        'nullable to non nullable',
        () {
          final dto = fixture.ComplexNullableDto([
            fixture.NestedDto(111789, name: 'first x', tag: fixture.NestedTagDto(flag: false)),
            fixture.NestedDto(111456, name: 'second x', tag: fixture.NestedTagDto(flag: false)),
            null,
            fixture.NestedDto(111123, name: 'third x', tag: fixture.NestedTagDto(flag: true)),
            null,
          ]);
          final converted = mapper.convert<fixture.ComplexNullableDto, fixture.Complex>(dto);

          expect(
            converted,
            const fixture.Complex([
              fixture.Nested(id: 111789, name: 'first x', tag: fixture.NestedTag(flag: false)),
              fixture.Nested(id: 111456, name: 'second x', tag: fixture.NestedTag(flag: false)),
              fixture.Nested(id: 111123, name: 'third x', tag: fixture.NestedTag(flag: true)),
            ]),
          );
        },
      );
    },
  );
}
