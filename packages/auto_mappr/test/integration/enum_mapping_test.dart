import 'package:auto_mappr/auto_mappr.dart';
import 'package:generator_test/generator_test.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

import 'fixture/enum_mapping.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = fixture.Mappr();
  });

  test('Simple enum', () {
    const source = fixture.Person.parent;

    final target = mappr.convert<fixture.Person, fixture.User>(source);

    expect(target, fixture.User.parent);
  });

  test('Enhanced enum', () {
    const source = fixture.EnhancedSource.parent;

    final target = mappr.convert<fixture.EnhancedSource, fixture.EnhancedTarget>(source);

    expect(target, fixture.EnhancedTarget.parent);
  });

  group('Error handling', () {
    test("Can't map source enum to target when target is not enum", () {
      final generator = SuccessGenerator.fromBuilder(
        'enum_mapping_not_enum',
        autoMapprBuilder,
        inputDir: 'test/integration/error_fixture',
        compareWithFixture: false,
      );

      expect(
        generator.test,
        throwsA(
          isA<InvalidGenerationSourceError>().having(
            (x) => x.message,
            'Match message',
            // ignore: avoid-non-ascii-symbols, it is ok
            'Failed to map Source → Target because target Target is not an enum.',
          ),
        ),
      );
    });

    test("Can't map source enum to target when target is not superset of source", () {
      final generator = SuccessGenerator.fromBuilder(
        'enum_mapping_subset',
        autoMapprBuilder,
        inputDir: 'test/integration/error_fixture',
        compareWithFixture: false,
      );

      expect(
        generator.test,
        throwsA(
          isA<InvalidGenerationSourceError>().having(
            (x) => x.message,
            'Match message',
            "Can't map enum Source into Target. Target enum is not superset of source enum.",
          ),
        ),
      );
    });
  });
}
