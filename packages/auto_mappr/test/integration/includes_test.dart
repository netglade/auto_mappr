import 'package:test/test.dart';

import 'fixture/includes.dart' as fixture_group;
import 'fixture/includes/module_alpha.dart' as fixture_alpha;
import 'fixture/includes/module_beta.dart' as fixture_beta;
import 'fixture/includes/module_gama.dart' as fixture_gama;

// includes hierarchy:
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
      const dto = fixture_group.GroupDto(
        fixture_alpha.AlphaDto(1),
        fixture_beta.BetaDto(2),
        fixture_gama.GamaDto(3),
      );

      // act
      final converted = mappr.convert<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(
        converted,
        equals(const fixture_group.Group(fixture_alpha.Alpha(1), fixture_beta.Beta(2), fixture_gama.Gama(3))),
      );
    });

    test('alpha', () {
      // arrange
      const dto = fixture_alpha.AlphaDto(4);

      // act
      final converted = mappr.convert<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

      // assert
      expect(converted, equals(const fixture_alpha.Alpha(4)));
    });

    test('beta', () {
      // arrange
      const dto = fixture_beta.BetaDto(5);

      // act
      final converted = mappr.convert<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

      // assert
      expect(converted, equals(const fixture_beta.Beta(5)));
    });

    test('gama', () {
      // arrange
      const dto = fixture_gama.GamaDto(6);

      // act
      final converted = mappr.convert<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

      // assert
      expect(converted, equals(const fixture_gama.Gama(6)));
    });
  });

  group('tryConvert', () {
    test('group', () {
      // arrange
      const dto = fixture_group.GroupDto(fixture_alpha.AlphaDto(1), fixture_beta.BetaDto(2), fixture_gama.GamaDto(3));

      // act
      final converted = mappr.tryConvert<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(
        converted,
        equals(const fixture_group.Group(fixture_alpha.Alpha(1), fixture_beta.Beta(2), fixture_gama.Gama(3))),
      );
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

    test('gama w/ null value', () {
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
        const fixture_group.GroupDto(fixture_alpha.AlphaDto(1), fixture_beta.BetaDto(2), fixture_gama.GamaDto(3)),
        const fixture_group.GroupDto(fixture_alpha.AlphaDto(4), fixture_beta.BetaDto(5), fixture_gama.GamaDto(6)),
        const fixture_group.GroupDto(fixture_alpha.AlphaDto(7), fixture_beta.BetaDto(8), fixture_gama.GamaDto(9)),
      ].map((e) => e);

      // act
      final converted = mappr.convertIterable<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(
        converted,
        equals(const [
          fixture_group.Group(fixture_alpha.Alpha(1), fixture_beta.Beta(2), fixture_gama.Gama(3)),
          fixture_group.Group(fixture_alpha.Alpha(4), fixture_beta.Beta(5), fixture_gama.Gama(6)),
          fixture_group.Group(fixture_alpha.Alpha(7), fixture_beta.Beta(8), fixture_gama.Gama(9)),
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
      final dto = const [
        fixture_group.GroupDto(fixture_alpha.AlphaDto(11), fixture_beta.BetaDto(12), fixture_gama.GamaDto(13)),
        fixture_group.GroupDto(fixture_alpha.AlphaDto(14), fixture_beta.BetaDto(15), fixture_gama.GamaDto(16)),
        fixture_group.GroupDto(fixture_alpha.AlphaDto(17), fixture_beta.BetaDto(18), fixture_gama.GamaDto(19)),
      ].map((e) => e);

      // act
      final converted = mappr.tryConvertIterable<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(
        converted,
        equals(const [
          fixture_group.Group(fixture_alpha.Alpha(11), fixture_beta.Beta(12), fixture_gama.Gama(13)),
          fixture_group.Group(fixture_alpha.Alpha(14), fixture_beta.Beta(15), fixture_gama.Gama(16)),
          fixture_group.Group(fixture_alpha.Alpha(17), fixture_beta.Beta(18), fixture_gama.Gama(19)),
        ]),
      );
    });

    test('group w/ null', () {
      // arrange
      final dto = [
        const fixture_group.GroupDto(fixture_alpha.AlphaDto(101), fixture_beta.BetaDto(102), fixture_gama.GamaDto(103)),
        null,
        const fixture_group.GroupDto(fixture_alpha.AlphaDto(201), fixture_beta.BetaDto(202), fixture_gama.GamaDto(203)),
      ].map((e) => e);

      // act
      final converted = mappr.tryConvertIterable<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(
        converted,
        equals(const [
          fixture_group.Group(fixture_alpha.Alpha(101), fixture_beta.Beta(102), fixture_gama.Gama(103)),
          null,
          fixture_group.Group(fixture_alpha.Alpha(201), fixture_beta.Beta(202), fixture_gama.Gama(203)),
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
        fixture_group.GroupDto(fixture_alpha.AlphaDto(21), fixture_beta.BetaDto(22), fixture_gama.GamaDto(23)),
        fixture_group.GroupDto(fixture_alpha.AlphaDto(24), fixture_beta.BetaDto(25), fixture_gama.GamaDto(26)),
        fixture_group.GroupDto(fixture_alpha.AlphaDto(27), fixture_beta.BetaDto(28), fixture_gama.GamaDto(29)),
      ];

      // act
      final converted = mappr.convertList<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(
        converted,
        equals(const [
          fixture_group.Group(fixture_alpha.Alpha(21), fixture_beta.Beta(22), fixture_gama.Gama(23)),
          fixture_group.Group(fixture_alpha.Alpha(24), fixture_beta.Beta(25), fixture_gama.Gama(26)),
          fixture_group.Group(fixture_alpha.Alpha(27), fixture_beta.Beta(28), fixture_gama.Gama(29)),
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
        fixture_group.GroupDto(fixture_alpha.AlphaDto(31), fixture_beta.BetaDto(32), fixture_gama.GamaDto(33)),
        fixture_group.GroupDto(fixture_alpha.AlphaDto(34), fixture_beta.BetaDto(35), fixture_gama.GamaDto(36)),
        fixture_group.GroupDto(fixture_alpha.AlphaDto(37), fixture_beta.BetaDto(38), fixture_gama.GamaDto(39)),
      ];

      // act
      final converted = mappr.tryConvertList<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(
        converted,
        equals(const [
          fixture_group.Group(fixture_alpha.Alpha(31), fixture_beta.Beta(32), fixture_gama.Gama(33)),
          fixture_group.Group(fixture_alpha.Alpha(34), fixture_beta.Beta(35), fixture_gama.Gama(36)),
          fixture_group.Group(fixture_alpha.Alpha(37), fixture_beta.Beta(38), fixture_gama.Gama(39)),
        ]),
      );
    });

    test('group w/ null', () {
      // arrange
      const dto = <fixture_group.GroupDto?>[
        fixture_group.GroupDto(fixture_alpha.AlphaDto(221), fixture_beta.BetaDto(222), fixture_gama.GamaDto(223)),
        null,
        fixture_group.GroupDto(fixture_alpha.AlphaDto(231), fixture_beta.BetaDto(232), fixture_gama.GamaDto(233)),
      ];

      // act
      final converted = mappr.tryConvertList<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(
        converted,
        equals(const [
          fixture_group.Group(fixture_alpha.Alpha(221), fixture_beta.Beta(222), fixture_gama.Gama(223)),
          null,
          fixture_group.Group(fixture_alpha.Alpha(231), fixture_beta.Beta(232), fixture_gama.Gama(233)),
        ]),
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
        fixture_group.GroupDto(fixture_alpha.AlphaDto(41), fixture_beta.BetaDto(42), fixture_gama.GamaDto(43)),
        fixture_group.GroupDto(fixture_alpha.AlphaDto(44), fixture_beta.BetaDto(45), fixture_gama.GamaDto(46)),
        fixture_group.GroupDto(fixture_alpha.AlphaDto(47), fixture_beta.BetaDto(48), fixture_gama.GamaDto(49)),
      };

      // act
      final converted = mappr.convertSet<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(
        converted,
        equals({
          const fixture_group.Group(fixture_alpha.Alpha(41), fixture_beta.Beta(42), fixture_gama.Gama(43)),
          const fixture_group.Group(fixture_alpha.Alpha(44), fixture_beta.Beta(45), fixture_gama.Gama(46)),
          const fixture_group.Group(fixture_alpha.Alpha(47), fixture_beta.Beta(48), fixture_gama.Gama(49)),
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
        fixture_group.GroupDto(fixture_alpha.AlphaDto(51), fixture_beta.BetaDto(52), fixture_gama.GamaDto(53)),
        fixture_group.GroupDto(fixture_alpha.AlphaDto(54), fixture_beta.BetaDto(55), fixture_gama.GamaDto(56)),
        fixture_group.GroupDto(fixture_alpha.AlphaDto(57), fixture_beta.BetaDto(58), fixture_gama.GamaDto(59)),
      };

      // act
      final converted = mappr.tryConvertSet<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(
        converted,
        equals({
          const fixture_group.Group(fixture_alpha.Alpha(51), fixture_beta.Beta(52), fixture_gama.Gama(53)),
          const fixture_group.Group(fixture_alpha.Alpha(54), fixture_beta.Beta(55), fixture_gama.Gama(56)),
          const fixture_group.Group(fixture_alpha.Alpha(57), fixture_beta.Beta(58), fixture_gama.Gama(59)),
        }),
      );
    });

    test('group w/ null', () {
      // arrange
      const dto = <fixture_group.GroupDto?>{
        fixture_group.GroupDto(fixture_alpha.AlphaDto(421), fixture_beta.BetaDto(422), fixture_gama.GamaDto(423)),
        null,
        fixture_group.GroupDto(fixture_alpha.AlphaDto(431), fixture_beta.BetaDto(432), fixture_gama.GamaDto(433)),
      };

      // act
      final converted = mappr.tryConvertSet<fixture_group.GroupDto, fixture_group.Group>(dto);

      // assert
      expect(
        converted,
        equals({
          const fixture_group.Group(fixture_alpha.Alpha(421), fixture_beta.Beta(422), fixture_gama.Gama(423)),
          null,
          const fixture_group.Group(fixture_alpha.Alpha(431), fixture_beta.Beta(432), fixture_gama.Gama(433)),
        }),
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
