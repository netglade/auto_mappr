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
    'canConvert',
    () {
      // TODO(modules): add
    },
  );

  group(
    'convert{Iterable, List, Set}',
    () {
      // TODO(modules): add
    },
  );

  group(
    'canConvert{Iterable, List, Set}',
    () {
      // TODO(modules): add
    },
  );
}
