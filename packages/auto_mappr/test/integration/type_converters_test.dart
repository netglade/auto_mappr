import 'package:test/test.dart';

import 'fixture/type_converters.dart' as fixture;
import 'fixture/type_converters/nullabe_to_nullable.dart';
import 'fixture/type_converters/nullable_to_required.dart';
import 'fixture/type_converters/required_to_nullable.dart';
import 'fixture/type_converters/required_to_required.dart';

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  test('nullable', () {
    const dto = fixture.NullableDto(alpha: 123456, beta: 123);
    final converted =
        mappr.convert<fixture.NullableDto, fixture.Nullable>(dto);

    expect(
      converted,
      equals(const fixture.Nullable(fixture.Value(123456), 123)),
    );
  });

  test('primitives', () {
    const dto = fixture.PrimitivesDto(alpha: 123456, beta: false);
    final converted = mappr.convert<fixture.PrimitivesDto, fixture.Primitives>(dto);

    expect(converted, equals(const fixture.Primitives('--- 123456 ---', '--- false ---')));
  });

  test('fields', () {
    const dto = fixture.NormalFieldDto(xInt: 5, xString: 'Command', normalBool: true);
    final converted = mappr.convert<fixture.NormalFieldDto, fixture.NormalField>(dto);

    expect(converted, equals(const fixture.NormalField(fixture.Value<int>(5), fixture.Value('Command'), true)));
  });

  test('list', () {
    const dto = fixture.InListDto(xInt: [789, 5, 1], xString: 'Dunno', normalBool: false);
    final converted = mappr.convert<fixture.InListDto, fixture.InList>(dto);

    expect(
      converted,
      equals(
        const fixture.InList(
          [fixture.Value<int>(789), fixture.Value<int>(5), fixture.Value<int>(1)],
          fixture.Value('Dunno'),
          false,
        ),
      ),
    );
  });

  test('map', () {
    const dto = fixture.InMapDto(
      alpha: {'aaa': 123, 'bbb': 456},
      beta: {'ccc': 789, 'ddd': 741},
      gama: {'eee': 852, 'fff': 963},
    );
    final converted = mappr.convert<fixture.InMapDto, fixture.InMap>(dto);

    expect(
      converted,
      equals(
        fixture.InMap(
          {const fixture.Value('aaa'): 123, const fixture.Value('bbb'): 456},
          {'ccc': const fixture.Value(789), 'ddd': const fixture.Value(741)},
          {const fixture.Value('eee'): const fixture.Value(852), const fixture.Value('fff'): const fixture.Value(963)},
        ),
      ),
    );
  });

  test('includes', () {
    const dto = fixture.IncludesDto(alpha: 1);
    final converted = mappr.convert<fixture.IncludesDto, fixture.Includes>(dto);

    expect(converted, equals(const fixture.Includes(true)));
  });

  test('includes 2', () {
    const dto = fixture.IncludesDto(alpha: 2);
    final converted = mappr.convert<fixture.IncludesDto, fixture.Includes>(dto);

    expect(converted, equals(const fixture.Includes(false)));
  });

  group('with reverse', () {
    test('Dto to entity', () {
      const dto = fixture.PostDto(user: fixture.UserDto(id: 'alpha123'));
      final converted = mappr.convert<fixture.PostDto, fixture.Post>(dto);

      expect(converted, equals(const fixture.Post(user: fixture.User(id: 'alpha123'))));
    });

    test('Entity to dto', () {
      const dto = fixture.Post(user: fixture.User(id: 'beta123'));
      final converted = mappr.convert<fixture.Post, fixture.PostDto>(dto);

      expect(converted, equals(const fixture.PostDto(user: fixture.UserDto(id: 'beta123'))));
    });
  });

  group('TypeConverter<Object, Object>', () {
    late final RequiredToRequiredConverterMappr mapprX;

    setUpAll(() {
      mapprX = const RequiredToRequiredConverterMappr();
    });

    test('Object -> Object', () {
      const input = fixture.RequiredInput('aaa');
      final converted = mapprX.convert<fixture.RequiredInput, fixture.RequiredOutput>(input);

      expect(converted, equals(const fixture.RequiredOutput(fixture.Value('aaa'))));
    });

    test('Object -> Object?', () {
      const input = fixture.RequiredInput('aaa');
      final converted = mapprX.convert<fixture.RequiredInput, fixture.NullableOutput>(input);

      expect(converted, equals(const fixture.NullableOutput(fixture.Value('aaa'))));
    });
  });

  group('TypeConverter<Object, Object?>', () {
    late final RequiredToNullableConverterMappr mapprX;

    setUpAll(() {
      mapprX = const RequiredToNullableConverterMappr();
    });

    test('Object -> Object?', () {
      const input = fixture.RequiredInput('aaa');
      final converted = mapprX.convert<fixture.RequiredInput, fixture.NullableOutput>(input);

      expect(converted, equals(const fixture.NullableOutput(fixture.Value('aaa'))));
    });
  });

  group('TypeConverter<Object?, Object>', () {
    late final NullableToRequiredConverterMappr mapprX;

    setUpAll(() {
      mapprX = const NullableToRequiredConverterMappr();
    });

    test('Object -> Object', () {
      const input = fixture.RequiredInput('aaa');
      final converted = mapprX.convert<fixture.RequiredInput, fixture.RequiredOutput>(input);

      expect(converted, equals(const fixture.RequiredOutput(fixture.Value('aaa'))));
    });

    test('Object? -> Object', () {
      const input = fixture.NullableInput('aaa');
      final converted = mapprX.convert<fixture.NullableInput, fixture.RequiredOutput>(input);

      expect(converted, equals(const fixture.RequiredOutput(fixture.Value('aaa'))));
    });

    test('Object? -> Object (null input)', () {
      const input = fixture.NullableInput(null);
      final converted = mapprX.convert<fixture.NullableInput, fixture.RequiredOutput>(input);

      expect(converted, equals(const fixture.RequiredOutput(fixture.Value(''))));
    });

    test('Object -> Object?', () {
      const input = fixture.RequiredInput('aaa');
      final converted = mapprX.convert<fixture.RequiredInput, fixture.NullableOutput>(input);

      expect(converted, equals(const fixture.NullableOutput(fixture.Value('aaa'))));
    });

    test('Object? -> Object?', () {
      const input = fixture.NullableInput('aaa');
      final converted = mapprX.convert<fixture.NullableInput, fixture.NullableOutput>(input);

      expect(converted, equals(const fixture.NullableOutput(fixture.Value('aaa'))));
    });

    test('Object? -> Object? (null input)', () {
      const input = fixture.NullableInput(null);
      final converted = mapprX.convert<fixture.NullableInput, fixture.NullableOutput>(input);

      expect(converted, equals(const fixture.NullableOutput(fixture.Value(''))));
    });
  });

  group('TypeConverter<Object?, Object?>', () {
    late final NullableToNullableConverterMappr mapprX;

    setUpAll(() {
      mapprX = const NullableToNullableConverterMappr();
    });

    test('Object -> Object?', () {
      const input = fixture.RequiredInput('aaa');
      final converted = mapprX.convert<fixture.RequiredInput, fixture.NullableOutput>(input);

      expect(converted, equals(const fixture.NullableOutput(fixture.Value('aaa'))));
    });

    test('Object? -> Object?', () {
      const input = fixture.NullableInput('aaa');
      final converted = mapprX.convert<fixture.NullableInput, fixture.NullableOutput>(input);

      expect(converted, equals(const fixture.NullableOutput(fixture.Value('aaa'))));
    });

    test('Object? -> Object? (null input)', () {
      const input = fixture.NullableInput(null);
      final converted = mapprX.convert<fixture.NullableInput, fixture.NullableOutput>(input);

      expect(converted, equals(const fixture.NullableOutput(null)));
    });
  });
}
