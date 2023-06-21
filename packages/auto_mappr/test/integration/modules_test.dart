import 'package:test/test.dart';

import 'fixture/modules.dart' as fixture_group;
import 'fixture/modules/module_alpha.dart' as fixture_alpha;
import 'fixture/modules/module_beta.dart' as fixture_beta;
import 'fixture/modules/module_gama.dart' as fixture_gama;

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
    test(
      'group',
      () {
        const dto = fixture_group.GroupDto(1);
        final converted = mappr.convert<fixture_group.GroupDto, fixture_group.Group>(dto);

        expect(
          converted,
          const fixture_group.Group(1),
        );
      },
    );

    test(
      'alpha',
      () {
        const dto = fixture_alpha.AlphaDto(2);
        final converted = mappr.convert<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

        expect(
          converted,
          const fixture_alpha.Alpha(2),
        );
      },
    );

    test(
      'beta',
      () {
        const dto = fixture_beta.BetaDto(3);
        final converted = mappr.convert<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

        expect(
          converted,
          const fixture_beta.Beta(3),
        );
      },
    );

    test(
      'gama',
      () {
        const dto = fixture_gama.GamaDto(4);
        final converted = mappr.convert<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

        expect(
          converted,
          const fixture_gama.Gama(4),
        );
      },
    );
  });

  group(
    'tryConvert',
    () {
      test(
        'group',
        () {
          const dto = fixture_group.GroupDto(1);
          final converted = mappr.tryConvert<fixture_group.GroupDto, fixture_group.Group>(dto);

          expect(
            converted,
            const fixture_group.Group(1),
          );
        },
      );

      test(
        'group w/ null',
        () {
          const fixture_group.GroupDto? dto = null;
          final converted = mappr.tryConvert<fixture_group.GroupDto, fixture_group.Group>(dto);

          expect(
            converted,
            null,
          );
        },
      );

      test(
        'alpha',
        () {
          const dto = fixture_alpha.AlphaDto(2);
          final converted = mappr.tryConvert<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

          expect(
            converted,
            const fixture_alpha.Alpha(2),
          );
        },
      );

      test(
        'alpha w/ null',
        () {
          const fixture_alpha.AlphaDto? dto = null;
          final converted = mappr.tryConvert<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

          expect(
            converted,
            null,
          );
        },
      );

      test(
        'beta',
        () {
          const dto = fixture_beta.BetaDto(3);
          final converted = mappr.tryConvert<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

          expect(
            converted,
            const fixture_beta.Beta(3),
          );
        },
      );

      test(
        'beta w/ null',
        () {
          const fixture_beta.BetaDto? dto = null;
          final converted = mappr.tryConvert<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

          expect(
            converted,
            null,
          );
        },
      );

      test(
        'gama',
        () {
          const dto = fixture_gama.GamaDto(4);
          final converted = mappr.tryConvert<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

          expect(
            converted,
            const fixture_gama.Gama(4),
          );
        },
      );

      test(
        'gama w/ null',
        () {
          const fixture_gama.GamaDto? dto = null;
          final converted = mappr.tryConvert<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

          expect(
            converted,
            null,
          );
        },
      );
    },
  );

  group(
    'convertIterable',
    () {
      test(
        'group',
        () {
          final dto = [
            const fixture_group.GroupDto(1),
            const fixture_group.GroupDto(2),
            const fixture_group.GroupDto(3),
          ].map((e) => e);
          final converted = mappr.convertIterable<fixture_group.GroupDto, fixture_group.Group>(dto);

          expect(
            converted,
            const [
              fixture_group.Group(1),
              fixture_group.Group(2),
              fixture_group.Group(3),
            ],
          );
        },
      );

      test(
        'alpha',
        () {
          final dto = [
            const fixture_alpha.AlphaDto(4),
            const fixture_alpha.AlphaDto(5),
          ].map((e) => e);
          final converted = mappr.convertIterable<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

          expect(
            converted,
            const [
              fixture_alpha.Alpha(4),
              fixture_alpha.Alpha(5),
            ],
          );
        },
      );

      test(
        'beta',
        () {
          final dto = [
            const fixture_beta.BetaDto(6),
            const fixture_beta.BetaDto(7),
            const fixture_beta.BetaDto(8),
          ].map((e) => e);
          final converted = mappr.convertIterable<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

          expect(
            converted,
            const [
              fixture_beta.Beta(6),
              fixture_beta.Beta(7),
              fixture_beta.Beta(8),
            ],
          );
        },
      );

      test(
        'gama',
        () {
          final dto = [
            const fixture_gama.GamaDto(9),
            const fixture_gama.GamaDto(10),
          ].map((e) => e);
          final converted = mappr.convertIterable<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

          expect(
            converted,
            const [
              fixture_gama.Gama(9),
              fixture_gama.Gama(10),
            ],
          );
        },
      );
    },
  );

  group(
    'tryConvertIterable',
    () {
      test(
        'group',
        () {
          final dto = [
            const fixture_group.GroupDto(1),
            const fixture_group.GroupDto(2),
            const fixture_group.GroupDto(3),
          ].map((e) => e);
          final converted = mappr.tryConvertIterable<fixture_group.GroupDto, fixture_group.Group>(dto);

          expect(
            converted,
            const [
              fixture_group.Group(1),
              fixture_group.Group(2),
              fixture_group.Group(3),
            ],
          );
        },
      );

      test(
        'group w/ null',
        () {
          final dto = [
            const fixture_group.GroupDto(1),
            null,
            const fixture_group.GroupDto(3),
          ].map((e) => e);
          final converted = mappr.tryConvertIterable<fixture_group.GroupDto, fixture_group.Group>(dto);

          expect(
            converted,
            const [
              fixture_group.Group(1),
              null,
              fixture_group.Group(3),
            ],
          );
        },
      );

      test(
        'alpha',
        () {
          final dto = [
            const fixture_alpha.AlphaDto(4),
            const fixture_alpha.AlphaDto(5),
          ].map((e) => e);
          final converted = mappr.tryConvertIterable<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

          expect(
            converted,
            const [
              fixture_alpha.Alpha(4),
              fixture_alpha.Alpha(5),
            ],
          );
        },
      );

      test(
        'alpha w/ null',
        () {
          final dto = [
            const fixture_alpha.AlphaDto(4),
            const fixture_alpha.AlphaDto(5),
            null,
          ].map((e) => e);
          final converted = mappr.tryConvertIterable<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

          expect(
            converted,
            const [
              fixture_alpha.Alpha(4),
              fixture_alpha.Alpha(5),
              null,
            ],
          );
        },
      );

      test(
        'beta',
        () {
          final dto = [
            const fixture_beta.BetaDto(6),
            const fixture_beta.BetaDto(7),
            const fixture_beta.BetaDto(8),
          ].map((e) => e);
          final converted = mappr.tryConvertIterable<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

          expect(
            converted,
            const [
              fixture_beta.Beta(6),
              fixture_beta.Beta(7),
              fixture_beta.Beta(8),
            ],
          );
        },
      );

      test(
        'beta w/ null',
        () {
          final dto = [
            null,
            const fixture_beta.BetaDto(7),
            const fixture_beta.BetaDto(8),
          ].map((e) => e);
          final converted = mappr.tryConvertIterable<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

          expect(
            converted,
            const [
              null,
              fixture_beta.Beta(7),
              fixture_beta.Beta(8),
            ],
          );
        },
      );

      test(
        'gama',
        () {
          final dto = [
            const fixture_gama.GamaDto(9),
            const fixture_gama.GamaDto(10),
          ].map((e) => e);
          final converted = mappr.tryConvertIterable<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

          expect(
            converted,
            const [
              fixture_gama.Gama(9),
              fixture_gama.Gama(10),
            ],
          );
        },
      );

      test(
        'gama w/ null',
        () {
          final dto = [
            null,
            const fixture_gama.GamaDto(9),
            const fixture_gama.GamaDto(10),
          ].map((e) => e);
          final converted = mappr.tryConvertIterable<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

          expect(
            converted,
            const [
              null,
              fixture_gama.Gama(9),
              fixture_gama.Gama(10),
            ],
          );
        },
      );
    },
  );

  group(
    'convertList',
    () {
      test(
        'group',
        () {
          const dto = <fixture_group.GroupDto>[
            fixture_group.GroupDto(1),
            fixture_group.GroupDto(2),
            fixture_group.GroupDto(3),
          ];
          final converted = mappr.convertList<fixture_group.GroupDto, fixture_group.Group>(dto);

          expect(
            converted,
            const [
              fixture_group.Group(1),
              fixture_group.Group(2),
              fixture_group.Group(3),
            ],
          );
        },
      );

      test(
        'alpha',
        () {
          const dto = <fixture_alpha.AlphaDto>[
            fixture_alpha.AlphaDto(4),
            fixture_alpha.AlphaDto(5),
          ];
          final converted = mappr.convertList<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

          expect(
            converted,
            const [
              fixture_alpha.Alpha(4),
              fixture_alpha.Alpha(5),
            ],
          );
        },
      );

      test(
        'beta',
        () {
          const dto = <fixture_beta.BetaDto>[
            fixture_beta.BetaDto(6),
            fixture_beta.BetaDto(7),
            fixture_beta.BetaDto(8),
          ];
          final converted = mappr.convertList<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

          expect(
            converted,
            const [
              fixture_beta.Beta(6),
              fixture_beta.Beta(7),
              fixture_beta.Beta(8),
            ],
          );
        },
      );

      test(
        'gama',
        () {
          const dto = <fixture_gama.GamaDto>[
            fixture_gama.GamaDto(9),
            fixture_gama.GamaDto(10),
          ];
          final converted = mappr.convertList<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

          expect(
            converted,
            const [
              fixture_gama.Gama(9),
              fixture_gama.Gama(10),
            ],
          );
        },
      );
    },
  );

  group(
    'tryConvertList',
    () {
      test(
        'group',
        () {
          const dto = <fixture_group.GroupDto?>[
            fixture_group.GroupDto(1),
            fixture_group.GroupDto(2),
            fixture_group.GroupDto(3),
          ];
          final converted = mappr.tryConvertList<fixture_group.GroupDto, fixture_group.Group>(dto);

          expect(
            converted,
            const [
              fixture_group.Group(1),
              fixture_group.Group(2),
              fixture_group.Group(3),
            ],
          );
        },
      );

      test(
        'group w/ null',
        () {
          const dto = <fixture_group.GroupDto?>[
            fixture_group.GroupDto(1),
            null,
            fixture_group.GroupDto(3),
          ];
          final converted = mappr.tryConvertList<fixture_group.GroupDto, fixture_group.Group>(dto);

          expect(
            converted,
            const [
              fixture_group.Group(1),
              null,
              fixture_group.Group(3),
            ],
          );
        },
      );

      test(
        'alpha',
        () {
          const dto = <fixture_alpha.AlphaDto?>[
            fixture_alpha.AlphaDto(4),
            fixture_alpha.AlphaDto(5),
          ];
          final converted = mappr.tryConvertList<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

          expect(
            converted,
            const [
              fixture_alpha.Alpha(4),
              fixture_alpha.Alpha(5),
            ],
          );
        },
      );

      test(
        'alpha w/ null',
        () {
          const dto = <fixture_alpha.AlphaDto?>[
            fixture_alpha.AlphaDto(4),
            fixture_alpha.AlphaDto(5),
            null,
          ];
          final converted = mappr.tryConvertList<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

          expect(
            converted,
            const [
              fixture_alpha.Alpha(4),
              fixture_alpha.Alpha(5),
              null,
            ],
          );
        },
      );

      test(
        'beta',
        () {
          const dto = <fixture_beta.BetaDto?>[
            fixture_beta.BetaDto(6),
            fixture_beta.BetaDto(7),
            fixture_beta.BetaDto(8),
          ];
          final converted = mappr.tryConvertList<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

          expect(
            converted,
            const [
              fixture_beta.Beta(6),
              fixture_beta.Beta(7),
              fixture_beta.Beta(8),
            ],
          );
        },
      );

      test(
        'beta w/ null',
        () {
          const dto = <fixture_beta.BetaDto?>[
            null,
            fixture_beta.BetaDto(7),
            fixture_beta.BetaDto(8),
          ];
          final converted = mappr.tryConvertList<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

          expect(
            converted,
            const [
              null,
              fixture_beta.Beta(7),
              fixture_beta.Beta(8),
            ],
          );
        },
      );

      test(
        'gama',
        () {
          const dto = <fixture_gama.GamaDto?>[
            fixture_gama.GamaDto(9),
            fixture_gama.GamaDto(10),
          ];
          final converted = mappr.tryConvertList<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

          expect(
            converted,
            const [
              fixture_gama.Gama(9),
              fixture_gama.Gama(10),
            ],
          );
        },
      );

      test(
        'gama w/ null',
        () {
          const dto = <fixture_gama.GamaDto?>[
            null,
            fixture_gama.GamaDto(9),
            fixture_gama.GamaDto(10),
          ];
          final converted = mappr.tryConvertList<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

          expect(
            converted,
            const [
              null,
              fixture_gama.Gama(9),
              fixture_gama.Gama(10),
            ],
          );
        },
      );
    },
  );

  group(
    'convertSet',
    () {
      test(
        'group',
        () {
          const dto = <fixture_group.GroupDto>{
            fixture_group.GroupDto(1),
            fixture_group.GroupDto(2),
            fixture_group.GroupDto(3),
          };
          final converted = mappr.convertSet<fixture_group.GroupDto, fixture_group.Group>(dto);

          expect(
            converted,
            const [
              fixture_group.Group(1),
              fixture_group.Group(2),
              fixture_group.Group(3),
            ],
          );
        },
      );

      test(
        'alpha',
        () {
          const dto = <fixture_alpha.AlphaDto>{
            fixture_alpha.AlphaDto(4),
            fixture_alpha.AlphaDto(5),
          };
          final converted = mappr.convertSet<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

          expect(
            converted,
            const [
              fixture_alpha.Alpha(4),
              fixture_alpha.Alpha(5),
            ],
          );
        },
      );

      test(
        'beta',
        () {
          const dto = <fixture_beta.BetaDto>{
            fixture_beta.BetaDto(6),
            fixture_beta.BetaDto(7),
            fixture_beta.BetaDto(8),
          };
          final converted = mappr.convertSet<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

          expect(
            converted,
            const [
              fixture_beta.Beta(6),
              fixture_beta.Beta(7),
              fixture_beta.Beta(8),
            ],
          );
        },
      );

      test(
        'gama',
        () {
          const dto = <fixture_gama.GamaDto>{
            fixture_gama.GamaDto(9),
            fixture_gama.GamaDto(10),
          };
          final converted = mappr.convertSet<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

          expect(
            converted,
            const [
              fixture_gama.Gama(9),
              fixture_gama.Gama(10),
            ],
          );
        },
      );
    },
  );

  group(
    'tryConvertSet',
    () {
      test(
        'group',
        () {
          const dto = <fixture_group.GroupDto?>{
            fixture_group.GroupDto(1),
            fixture_group.GroupDto(2),
            fixture_group.GroupDto(3),
          };
          final converted = mappr.tryConvertSet<fixture_group.GroupDto, fixture_group.Group>(dto);

          expect(
            converted,
            const [
              fixture_group.Group(1),
              fixture_group.Group(2),
              fixture_group.Group(3),
            ],
          );
        },
      );

      test(
        'group w/ null',
        () {
          const dto = <fixture_group.GroupDto?>{
            fixture_group.GroupDto(1),
            null,
            fixture_group.GroupDto(3),
          };
          final converted = mappr.tryConvertSet<fixture_group.GroupDto, fixture_group.Group>(dto);

          expect(
            converted,
            const [
              fixture_group.Group(1),
              null,
              fixture_group.Group(3),
            ],
          );
        },
      );

      test(
        'alpha',
        () {
          const dto = <fixture_alpha.AlphaDto?>{
            fixture_alpha.AlphaDto(4),
            fixture_alpha.AlphaDto(5),
          };
          final converted = mappr.tryConvertSet<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

          expect(
            converted,
            const [
              fixture_alpha.Alpha(4),
              fixture_alpha.Alpha(5),
            ],
          );
        },
      );

      test(
        'alpha w/ null',
        () {
          const dto = <fixture_alpha.AlphaDto?>{
            fixture_alpha.AlphaDto(4),
            fixture_alpha.AlphaDto(5),
            null,
          };
          final converted = mappr.tryConvertSet<fixture_alpha.AlphaDto, fixture_alpha.Alpha>(dto);

          expect(
            converted,
            const [
              fixture_alpha.Alpha(4),
              fixture_alpha.Alpha(5),
              null,
            ],
          );
        },
      );

      test(
        'beta',
        () {
          const dto = <fixture_beta.BetaDto?>{
            fixture_beta.BetaDto(6),
            fixture_beta.BetaDto(7),
            fixture_beta.BetaDto(8),
          };
          final converted = mappr.tryConvertSet<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

          expect(
            converted,
            const [
              fixture_beta.Beta(6),
              fixture_beta.Beta(7),
              fixture_beta.Beta(8),
            ],
          );
        },
      );

      test(
        'beta w/ null',
        () {
          const dto = <fixture_beta.BetaDto?>{
            null,
            fixture_beta.BetaDto(7),
            fixture_beta.BetaDto(8),
          };
          final converted = mappr.tryConvertSet<fixture_beta.BetaDto, fixture_beta.Beta>(dto);

          expect(
            converted,
            const [
              null,
              fixture_beta.Beta(7),
              fixture_beta.Beta(8),
            ],
          );
        },
      );

      test(
        'gama',
        () {
          const dto = <fixture_gama.GamaDto?>{
            fixture_gama.GamaDto(9),
            fixture_gama.GamaDto(10),
          };
          final converted = mappr.tryConvertSet<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

          expect(
            converted,
            const [
              fixture_gama.Gama(9),
              fixture_gama.Gama(10),
            ],
          );
        },
      );

      test(
        'gama w/ null',
        () {
          const dto = <fixture_gama.GamaDto?>{
            null,
            fixture_gama.GamaDto(9),
            fixture_gama.GamaDto(10),
          };
          final converted = mappr.tryConvertSet<fixture_gama.GamaDto, fixture_gama.Gama>(dto);

          expect(
            converted,
            const [
              null,
              fixture_gama.Gama(9),
              fixture_gama.Gama(10),
            ],
          );
        },
      );
    },
  );
}
