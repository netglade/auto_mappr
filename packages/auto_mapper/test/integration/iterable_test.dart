import 'package:test/test.dart';

import 'fixture/iterable.dart' as fixture;

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
            fixture.Primitive([1, 2, 3, 4, 5].where((_) => true)),
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
            fixture.Primitive([1, 2, 3, 4, 5].where((_) => true)),
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
            fixture.Complex(
              [
                const fixture.Nested(id: 111789, name: 'first x', tag: fixture.NestedTag(flag: false)),
                const fixture.Nested(id: 111456, name: 'second x', tag: fixture.NestedTag(flag: false)),
                const fixture.Nested(id: 111123, name: 'third x', tag: fixture.NestedTag(flag: true)),
              ].where((_) => true),
            ),
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
            fixture.Complex(
              [
                const fixture.Nested(id: 111789, name: 'first x', tag: fixture.NestedTag(flag: false)),
                const fixture.Nested(id: 111456, name: 'second x', tag: fixture.NestedTag(flag: false)),
                const fixture.Nested(id: 111123, name: 'third x', tag: fixture.NestedTag(flag: true)),
              ].where((_) => true),
            ),
          );
        },
      );
    },
  );
}
