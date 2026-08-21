import 'package:test/test.dart';

import 'fixture/includes_deduplication.dart' as fixture;
import 'fixture/includes_deduplication/direct_and_transitive.dart' as fixture_direct;
import 'fixture/includes_deduplication/left.dart' as fixture_left;
import 'fixture/includes_deduplication/repeated_include.dart' as fixture_repeated;
import 'fixture/includes_deduplication/right.dart' as fixture_right;
import 'fixture/includes_deduplication/shared.dart' as fixture_shared;

// An included mappr may be reachable through more than one path of the includes hierarchy.
// Its mappings and converters must be absorbed only once,
// instead of being reported as duplicated mappings.
void main() {
  group('mappr reached through two sibling branches', () {
    late final fixture.DiamondMappr mappr;

    setUpAll(() {
      mappr = const fixture.DiamondMappr();
    });

    test('absorbs the shared mapping', () {
      // act
      // assert
      expect(mappr.canConvert<fixture_shared.SharedSource, fixture_shared.SharedTarget>(), isTrue);
    });

    test('uses the shared mapping directly', () {
      // arrange
      const dto = fixture_shared.SharedSource(1);

      // act
      final converted = mappr.convert<fixture_shared.SharedSource, fixture_shared.SharedTarget>(dto);

      // assert
      expect(converted, equals(const fixture_shared.SharedTarget('n1')));
    });

    test('uses the shared mapping from both branches', () {
      // arrange
      const dto = fixture.PairSource(
        fixture_left.LeftSource(fixture_shared.SharedSource(2)),
        fixture_right.RightSource(fixture_shared.SharedSource(3)),
      );

      // act
      final converted = mappr.convert<fixture.PairSource, fixture.PairTarget>(dto);

      // assert
      expect(
        converted,
        equals(
          const fixture.PairTarget(
            fixture_left.LeftTarget(fixture_shared.SharedTarget('n2')),
            fixture_right.RightTarget(fixture_shared.SharedTarget('n3')),
          ),
        ),
      );
    });

    test('absorbs the mappings of both branches', () {
      // arrange
      const leftDto = fixture_left.LeftSource(fixture_shared.SharedSource(4));
      const rightDto = fixture_right.RightSource(fixture_shared.SharedSource(5));

      // act
      final convertedLeft = mappr.convert<fixture_left.LeftSource, fixture_left.LeftTarget>(leftDto);
      final convertedRight = mappr.convert<fixture_right.RightSource, fixture_right.RightTarget>(rightDto);

      // assert
      expect(convertedLeft, equals(const fixture_left.LeftTarget(fixture_shared.SharedTarget('n4'))));
      expect(convertedRight, equals(const fixture_right.RightTarget(fixture_shared.SharedTarget('n5'))));
    });
  });

  group('mappr reached both directly and through an include', () {
    late final fixture_direct.DirectAndTransitiveMappr mappr;

    setUpAll(() {
      mappr = const fixture_direct.DirectAndTransitiveMappr();
    });

    test('absorbs the shared mapping', () {
      // arrange
      const dto = fixture_shared.SharedSource(6);

      // act
      final converted = mappr.convert<fixture_shared.SharedSource, fixture_shared.SharedTarget>(dto);

      // assert
      expect(converted, equals(const fixture_shared.SharedTarget('n6')));
    });

    test('absorbs the mapping of the including mappr', () {
      // arrange
      const dto = fixture_left.LeftSource(fixture_shared.SharedSource(7));

      // act
      final converted = mappr.convert<fixture_left.LeftSource, fixture_left.LeftTarget>(dto);

      // assert
      expect(converted, equals(const fixture_left.LeftTarget(fixture_shared.SharedTarget('n7'))));
    });
  });

  group('mappr listed twice in the same includes list', () {
    late final fixture_repeated.RepeatedIncludeMappr mappr;

    setUpAll(() {
      mappr = const fixture_repeated.RepeatedIncludeMappr();
    });

    test('absorbs the shared mapping', () {
      // arrange
      const dto = fixture_shared.SharedSource(8);

      // act
      final converted = mappr.convert<fixture_shared.SharedSource, fixture_shared.SharedTarget>(dto);

      // assert
      expect(converted, equals(const fixture_shared.SharedTarget('n8')));
    });
  });
}
