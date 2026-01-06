import 'package:test/test.dart';

import 'fixture/delegates.dart' as fixture_group;
import 'fixture/delegates/module_alpha.dart' as fixture_alpha;
import 'fixture/delegates/module_beta.dart' as fixture_beta;
import 'fixture/delegates/module_gama.dart' as fixture_gama;

// modules hierarchy:
//
// - Group (this one)
//   - Alpha
//     - Beta
//       - Gama
void main() {
  late final fixture_group.MapprGroup mappr;

  setUpAll(() {
    mappr = const fixture_group.MapprGroup();
  });

  group('convert', () {
    test('group', () {
      // arrange
      const dto = fixture_group.GroupDto(1);

      // act
      final converted = mappr.convert<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(converted, equals(const fixture_group.Group(1)));
    });

    test('alpha', () {
      // arrange
      const dto = fixture_alpha.AlphaDto(2);

      // act
      final converted = mappr.convert<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

      // assert
      expect(converted, equals(const fixture_alpha.Alpha(2)));
    });

    test('beta', () {
      // arrange
      const dto = fixture_beta.BetaDto(3);

      // act
      final converted = mappr.convert<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

      // assert
      expect(converted, equals(const fixture_beta.Beta(3)));
    });

    test('gama', () {
      // arrange
      const dto = fixture_gama.GamaDto(4);

      // act
      final converted = mappr.convert<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

      // assert
      expect(converted, equals(const fixture_gama.Gama(4)));
    });
  });

  group('tryConvert', () {
    test('group', () {
      // arrange
      const dto = fixture_group.GroupDto(1);

      // act
      final converted = mappr.tryConvert<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(converted, equals(const fixture_group.Group(1)));
    });

    test('group w/ null', () {
      // arrange
      const fixture_group.GroupDto? dto = null;

      // act
      final converted = mappr.tryConvert<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(converted, isNull);
    });

    test('alpha', () {
      // arrange
      const dto = fixture_alpha.AlphaDto(2);

      // act
      final converted = mappr.tryConvert<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

      // assert
      expect(converted, equals(const fixture_alpha.Alpha(2)));
    });

    test('alpha w/ null', () {
      // arrange
      const fixture_alpha.AlphaDto? dto = null;

      // act
      final converted = mappr.tryConvert<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

      // assert
      expect(converted, isNull);
    });

    test('beta', () {
      // arrange
      const dto = fixture_beta.BetaDto(3);

      // act
      final converted = mappr.tryConvert<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

      // assert
      expect(converted, equals(const fixture_beta.Beta(3)));
    });

    test('beta w/ null', () {
      // arrange
      const fixture_beta.BetaDto? dto = null;

      // act
      final converted = mappr.tryConvert<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

      // assert
      expect(converted, isNull);
    });

    test('beta w/ null value', () {
      // arrange
      const dto = fixture_beta.BetaDto(null);

      // act
      // assert
      expect(
        () => mappr.tryConvert<fixture_beta.BetaDto, fixture_beta.Beta>(dto),
        throwsA(predicate((e) => e is TypeError)),
      );
    });

    test('gama', () {
      // arrange
      const dto = fixture_gama.GamaDto(4);

      // act
      final converted = mappr.tryConvert<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

      // assert
      expect(converted, equals(const fixture_gama.Gama(4)));
    });

    test('gama w/ null', () {
      // arrange
      const fixture_gama.GamaDto? dto = null;

      // act
      final converted = mappr.tryConvert<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

      // assert
      expect(converted, isNull);
    });

    test('gama w/ null value (safe mapping on)', () {
      // arrange
      const dto = fixture_gama.GamaDto(null);

      // act
      final converted = mappr.tryConvert<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

      // assert
      expect(converted, isNull);
    });
  });

  group('convertIterable', () {
    test('group', () {
      // arrange
      final dto = [
        const fixture_group.GroupDto(1),
        const fixture_group.GroupDto(2),
        const fixture_group.GroupDto(3),
      ].map((e) => e);

      // act
      final converted = mappr.convertIterable<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(
        converted,
        equals(const [
          fixture_group.Group(1),
          fixture_group.Group(2),
          fixture_group.Group(3),
        ]),
      );
    });

    test('alpha', () {
      // arrange
      final dto = [
        const fixture_alpha.AlphaDto(4),
        const fixture_alpha.AlphaDto(5),
      ].map((e) => e);

      // act
      final converted = mappr.convertIterable<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

      // assert
      expect(
        converted,
        equals(const [fixture_alpha.Alpha(4), fixture_alpha.Alpha(5)]),
      );
    });

    test('beta', () {
      // arrange
      final dto = [
        const fixture_beta.BetaDto(6),
        const fixture_beta.BetaDto(7),
        const fixture_beta.BetaDto(8),
      ].map((e) => e);

      // act
      final converted = mappr.convertIterable<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

      // assert
      expect(
        converted,
        equals(const [
          fixture_beta.Beta(6),
          fixture_beta.Beta(7),
          fixture_beta.Beta(8),
        ]),
      );
    });

    test('gama', () {
      // arrange
      final dto = [
        const fixture_gama.GamaDto(9),
        const fixture_gama.GamaDto(10),
      ].map((e) => e);

      // act
      final converted = mappr.convertIterable<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

      // assert
      expect(converted, equals(const [fixture_gama.Gama(9), fixture_gama.Gama(10)]));
    });
  });

  group('tryConvertIterable', () {
    test('group', () {
      // arrange
      final dto = [
        const fixture_group.GroupDto(1),
        const fixture_group.GroupDto(2),
        const fixture_group.GroupDto(3),
      ].map((e) => e);

      // act
      final converted = mappr.tryConvertIterable<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(
        converted,
        equals(const [
          fixture_group.Group(1),
          fixture_group.Group(2),
          fixture_group.Group(3),
        ]),
      );
    });

    test('group w/ null', () {
      // arrange
      final dto = [
        const fixture_group.GroupDto(1),
        null,
        const fixture_group.GroupDto(3),
      ].map((e) => e);
      // act
      final converted = mappr.tryConvertIterable<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(
        converted,
        equals(const [fixture_group.Group(1), null, fixture_group.Group(3)]),
      );
    });

    test('alpha', () {
      // arrange
      final dto = [
        const fixture_alpha.AlphaDto(4),
        const fixture_alpha.AlphaDto(5),
      ].map((e) => e);

      // act
      final converted = mappr.tryConvertIterable<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

      // assert
      expect(
        converted,
        equals(const [fixture_alpha.Alpha(4), fixture_alpha.Alpha(5)]),
      );
    });

    test('alpha w/ null', () {
      // arrange
      final dto = [
        const fixture_alpha.AlphaDto(4),
        const fixture_alpha.AlphaDto(5),
        null,
      ].map((e) => e);

      // act
      final converted = mappr.tryConvertIterable<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

      // assert
      expect(
        converted,
        equals(const [fixture_alpha.Alpha(4), fixture_alpha.Alpha(5), null]),
      );
    });

    test('beta', () {
      // arrange
      final dto = [
        const fixture_beta.BetaDto(6),
        const fixture_beta.BetaDto(7),
        const fixture_beta.BetaDto(8),
      ].map((e) => e);

      // act
      final converted = mappr.tryConvertIterable<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

      // assert
      expect(
        converted,
        equals(const [
          fixture_beta.Beta(6),
          fixture_beta.Beta(7),
          fixture_beta.Beta(8),
        ]),
      );
    });

    test('beta w/ null', () {
      // arrange
      final dto = [
        null,
        const fixture_beta.BetaDto(7),
        const fixture_beta.BetaDto(8),
      ].map((e) => e);

      // act
      final converted = mappr.tryConvertIterable<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

      // assert
      expect(
        converted,
        equals(const [null, fixture_beta.Beta(7), fixture_beta.Beta(8)]),
      );
    });

    test('gama', () {
      // arrange
      final dto = [
        const fixture_gama.GamaDto(9),
        const fixture_gama.GamaDto(10),
      ].map((e) => e);

      // act
      final converted = mappr.tryConvertIterable<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

      // assert
      expect(converted, equals(const [fixture_gama.Gama(9), fixture_gama.Gama(10)]));
    });

    test('gama w/ null', () {
      // arrange
      final dto = [
        null,
        const fixture_gama.GamaDto(9),
        const fixture_gama.GamaDto(10),
      ].map((e) => e);

      // act
      final converted = mappr.tryConvertIterable<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

      // assert
      expect(
        converted,
        equals(const [null, fixture_gama.Gama(9), fixture_gama.Gama(10)]),
      );
    });
  });

  group('convertList', () {
    test('group', () {
      // arrange
      const dto = [
        fixture_group.GroupDto(1),
        fixture_group.GroupDto(2),
        fixture_group.GroupDto(3),
      ];

      // act
      final converted = mappr.convertList<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(
        converted,
        equals(const [
          fixture_group.Group(1),
          fixture_group.Group(2),
          fixture_group.Group(3),
        ]),
      );
    });

    test('alpha', () {
      // arrange
      const dto = [fixture_alpha.AlphaDto(4), fixture_alpha.AlphaDto(5)];

      // act
      final converted = mappr.convertList<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

      // assert
      expect(
        converted,
        equals(const [fixture_alpha.Alpha(4), fixture_alpha.Alpha(5)]),
      );
    });

    test('beta', () {
      // arrange
      const dto = [
        fixture_beta.BetaDto(6),
        fixture_beta.BetaDto(7),
        fixture_beta.BetaDto(8),
      ];

      // act
      final converted = mappr.convertList<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

      // assert
      expect(
        converted,
        equals(const [
          fixture_beta.Beta(6),
          fixture_beta.Beta(7),
          fixture_beta.Beta(8),
        ]),
      );
    });

    test('gama', () {
      // arrange
      const dto = [fixture_gama.GamaDto(9), fixture_gama.GamaDto(10)];

      // act
      final converted = mappr.convertList<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

      // assert
      expect(converted, equals(const [fixture_gama.Gama(9), fixture_gama.Gama(10)]));
    });
  });

  group('tryConvertList', () {
    test('group', () {
      // arrange
      const dto = <fixture_group.GroupDto?>[
        fixture_group.GroupDto(1),
        fixture_group.GroupDto(2),
        fixture_group.GroupDto(3),
      ];

      // act
      final converted = mappr.tryConvertList<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(
        converted,
        equals(const [
          fixture_group.Group(1),
          fixture_group.Group(2),
          fixture_group.Group(3),
        ]),
      );
    });

    test('group w/ null', () {
      // arrange
      const dto = <fixture_group.GroupDto?>[
        fixture_group.GroupDto(1),
        null,
        fixture_group.GroupDto(3),
      ];

      // act
      final converted = mappr.tryConvertList<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(
        converted,
        equals(const [fixture_group.Group(1), null, fixture_group.Group(3)]),
      );
    });

    test('alpha', () {
      // arrange
      const dto = <fixture_alpha.AlphaDto?>[
        fixture_alpha.AlphaDto(4),
        fixture_alpha.AlphaDto(5),
      ];

      // act
      final converted = mappr.tryConvertList<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

      // assert
      expect(
        converted,
        equals(const [fixture_alpha.Alpha(4), fixture_alpha.Alpha(5)]),
      );
    });

    test('alpha w/ null', () {
      // arrange
      const dto = <fixture_alpha.AlphaDto?>[
        fixture_alpha.AlphaDto(4),
        fixture_alpha.AlphaDto(5),
        null,
      ];

      // act
      final converted = mappr.tryConvertList<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

      // assert
      expect(
        converted,
        equals(const [fixture_alpha.Alpha(4), fixture_alpha.Alpha(5), null]),
      );
    });

    test('beta', () {
      // arrange
      const dto = <fixture_beta.BetaDto?>[
        fixture_beta.BetaDto(6),
        fixture_beta.BetaDto(7),
        fixture_beta.BetaDto(8),
      ];

      // act
      final converted = mappr.tryConvertList<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

      // assert
      expect(
        converted,
        equals(const [
          fixture_beta.Beta(6),
          fixture_beta.Beta(7),
          fixture_beta.Beta(8),
        ]),
      );
    });

    test('beta w/ null', () {
      // arrange
      const dto = <fixture_beta.BetaDto?>[
        null,
        fixture_beta.BetaDto(7),
        fixture_beta.BetaDto(8),
      ];

      // act
      final converted = mappr.tryConvertList<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

      // assert
      expect(
        converted,
        equals(const [null, fixture_beta.Beta(7), fixture_beta.Beta(8)]),
      );
    });

    test('gama', () {
      // arrange
      const dto = <fixture_gama.GamaDto?>[
        fixture_gama.GamaDto(9),
        fixture_gama.GamaDto(10),
      ];

      // act
      final converted = mappr.tryConvertList<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

      // assert
      expect(converted, equals(const [fixture_gama.Gama(9), fixture_gama.Gama(10)]));
    });

    test('gama w/ null', () {
      // arrange
      const dto = <fixture_gama.GamaDto?>[
        null,
        fixture_gama.GamaDto(9),
        fixture_gama.GamaDto(10),
      ];

      // act
      final converted = mappr.tryConvertList<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

      // assert
      expect(
        converted,
        equals(const [null, fixture_gama.Gama(9), fixture_gama.Gama(10)]),
      );
    });
  });

  group('convertSet', () {
    test('group', () {
      // arrange
      const dto = {
        fixture_group.GroupDto(1),
        fixture_group.GroupDto(2),
        fixture_group.GroupDto(3),
      };

      // act
      final converted = mappr.convertSet<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(
        converted,
        equals({
          const fixture_group.Group(1),
          const fixture_group.Group(2),
          const fixture_group.Group(3),
        }),
      );
    });

    test('alpha', () {
      // arrange
      const dto = {fixture_alpha.AlphaDto(4), fixture_alpha.AlphaDto(5)};

      // act
      final converted = mappr.convertSet<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

      // assert
      expect(
        converted,
        equals({const fixture_alpha.Alpha(4), const fixture_alpha.Alpha(5)}),
      );
    });

    test('beta', () {
      // arrange
      const dto = {
        fixture_beta.BetaDto(6),
        fixture_beta.BetaDto(7),
        fixture_beta.BetaDto(8),
      };

      // act
      final converted = mappr.convertSet<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

      // assert
      expect(
        converted,
        equals({
          const fixture_beta.Beta(6),
          const fixture_beta.Beta(7),
          const fixture_beta.Beta(8),
        }),
      );
    });

    test('gama', () {
      // arrange
      const dto = {fixture_gama.GamaDto(9), fixture_gama.GamaDto(10)};

      // act
      final converted = mappr.convertSet<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

      // assert
      expect(converted, equals({const fixture_gama.Gama(9), const fixture_gama.Gama(10)}));
    });
  });

  group('tryConvertSet', () {
    test('group', () {
      // arrange
      const dto = <fixture_group.GroupDto?>{
        fixture_group.GroupDto(1),
        fixture_group.GroupDto(2),
        fixture_group.GroupDto(3),
      };

      // act
      final converted = mappr.tryConvertSet<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(
        converted,
        equals({
          const fixture_group.Group(1),
          const fixture_group.Group(2),
          const fixture_group.Group(3),
        }),
      );
    });

    test('group w/ null', () {
      // arrange
      const dto = <fixture_group.GroupDto?>{
        fixture_group.GroupDto(1),
        null,
        fixture_group.GroupDto(3),
      };

      // act
      final converted = mappr.tryConvertSet<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(
        converted,
        equals({const fixture_group.Group(1), null, const fixture_group.Group(3)}),
      );
    });

    test('alpha', () {
      // arrange
      const dto = <fixture_alpha.AlphaDto?>{
        fixture_alpha.AlphaDto(4),
        fixture_alpha.AlphaDto(5),
      };

      // act
      final converted = mappr.tryConvertSet<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

      // assert
      expect(
        converted,
        equals({const fixture_alpha.Alpha(4), const fixture_alpha.Alpha(5)}),
      );
    });

    test('alpha w/ null', () {
      // arrange
      const dto = <fixture_alpha.AlphaDto?>{
        fixture_alpha.AlphaDto(4),
        fixture_alpha.AlphaDto(5),
        null,
      };

      // act
      final converted = mappr.tryConvertSet<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

      // assert
      expect(
        converted,
        equals({const fixture_alpha.Alpha(4), const fixture_alpha.Alpha(5), null}),
      );
    });

    test('beta', () {
      // arrange
      const dto = <fixture_beta.BetaDto?>{
        fixture_beta.BetaDto(6),
        fixture_beta.BetaDto(7),
        fixture_beta.BetaDto(8),
      };

      // act
      final converted = mappr.tryConvertSet<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

      // assert
      expect(
        converted,
        equals({
          const fixture_beta.Beta(6),
          const fixture_beta.Beta(7),
          const fixture_beta.Beta(8),
        }),
      );
    });

    test('beta w/ null', () {
      // arrange
      const dto = <fixture_beta.BetaDto?>{
        null,
        fixture_beta.BetaDto(7),
        fixture_beta.BetaDto(8),
      };

      // act
      final converted = mappr.tryConvertSet<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

      // assert
      expect(
        converted,
        equals({null, const fixture_beta.Beta(7), const fixture_beta.Beta(8)}),
      );
    });

    test('gama', () {
      // arrange
      const dto = <fixture_gama.GamaDto?>{
        fixture_gama.GamaDto(9),
        fixture_gama.GamaDto(10),
      };

      // act
      final converted = mappr.tryConvertSet<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

      // assert
      expect(converted, equals({const fixture_gama.Gama(9), const fixture_gama.Gama(10)}));
    });

    test('gama w/ null', () {
      // arrange
      const dto = <fixture_gama.GamaDto?>{
        null,
        fixture_gama.GamaDto(9),
        fixture_gama.GamaDto(10),
      };

      // act
      final converted = mappr.tryConvertSet<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

      // assert
      expect(
        converted,
        equals({null, const fixture_gama.Gama(9), const fixture_gama.Gama(10)}),
      );
    });
  });
}
