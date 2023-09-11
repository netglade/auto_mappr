import 'package:test/test.dart';

import 'fixture/type_converters.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
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
}
