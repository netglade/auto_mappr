import 'package:auto_mappr/auto_mappr.dart';
import 'package:auto_mappr/src/helpers/run_zoned_auto_mappr.dart';
import 'package:generator_test/generator_test.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

import 'fixture/enum_mapping.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  test('Simple enum', () {
    const source = fixture.Person.parent;

    final target = mappr.convert<fixture.Person, fixture.User>(source);

    expect(target, equals(fixture.User.parent));
  });

  test('Simple enum with unknown case', () {
    const source = fixture.RemotePerson.vp;
    final target = mappr.convert<fixture.RemotePerson, fixture.LocalPerson>(source);

    expect(target, equals(fixture.LocalPerson.unknown));
  });

  test('Enhanced enum', () {
    const source = fixture.EnhancedSource.parent;

    final target = mappr.convert<fixture.EnhancedSource, fixture.EnhancedTarget>(source);

    expect(target, equals(fixture.EnhancedTarget.parent));
  });

  test('Enhanced enum with unknown case', () {
    const source = fixture.EnhancedSourceWithUnknown.alien;

    final target = mappr.convert<fixture.EnhancedSourceWithUnknown, fixture.EnhancedTarget>(source);

    expect(target, equals(fixture.EnhancedTarget.unknown));
  });

  group('Error handling', () {
    test("Can't map source enum to target when target is not enum", () {
      runZonedAutoMappr(() {
        final generator = SuccessGenerator.fromBuilder(
          ['enum_mapping_not_enum.dart'],
          [],
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
              'Failed to map Source → Target because target Target is not an enum.',
            ),
          ),
        );
      });
    });

    test("Can't map source enum to target when target is not superset of source", () {
      runZonedAutoMappr(() {
        final generator = SuccessGenerator.fromBuilder(
          ['enum_mapping_subset.dart'],
          [],
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
              "Can't map enum Source into Target. Target enum is not superset of source enum. (Source → Target)",
            ),
          ),
        );
      });
    });
  });
}
