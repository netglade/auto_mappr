import 'package:test/test.dart';

import 'fixture/special_characters.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = fixture.Mappr();
  });

  group(
    'in class',
    () {
      test(
        'dollar to dollar',
        () {
          const dto = fixture.Dollar$Class(value: 1);
          final converted = mappr.convert<fixture.Dollar$Class, fixture.Dollar$Class>(dto);

          expect(
            converted,
            const fixture.Dollar$Class(value: 1),
          );
        },
      );

      test(
        'dollar to underscore',
            () {
          const dto = fixture.Dollar$Class(value: 2);
          final converted = mappr.convert<fixture.Dollar$Class, fixture.Underscore_Class>(dto);

          expect(
            converted,
            const fixture.Underscore_Class(value: 2),
          );
        },
      );

      test(
        'dollar to number',
            () {
          const dto = fixture.Dollar$Class(value: 3);
          final converted = mappr.convert<fixture.Dollar$Class, fixture.Number123Class>(dto);

          expect(
            converted,
            const fixture.Number123Class(value: 3),
          );
        },
      );

      test(
        'underscore to dollar',
            () {
          const dto = fixture.Underscore_Class(value: 4);
          final converted = mappr.convert<fixture.Underscore_Class, fixture.Dollar$Class>(dto);

          expect(
            converted,
            const fixture.Dollar$Class(value: 4),
          );
        },
      );

      test(
        'underscore to underscore',
            () {
          const dto = fixture.Underscore_Class(value: 5);
          final converted = mappr.convert<fixture.Underscore_Class, fixture.Underscore_Class>(dto);

          expect(
            converted,
            const fixture.Underscore_Class(value: 5),
          );
        },
      );

      test(
        'underscore to number',
            () {
          const dto = fixture.Underscore_Class(value: 6);
          final converted = mappr.convert<fixture.Underscore_Class, fixture.Number123Class>(dto);

          expect(
            converted,
            const fixture.Number123Class(value: 6),
          );
        },
      );

      test(
        'number to dollar',
            () {
          const dto = fixture.Number123Class(value: 7);
          final converted = mappr.convert<fixture.Number123Class, fixture.Dollar$Class>(dto);

          expect(
            converted,
            const fixture.Dollar$Class(value: 7),
          );
        },
      );

      test(
        'number to underscore',
            () {
          const dto = fixture.Number123Class(value: 8);
          final converted = mappr.convert<fixture.Number123Class, fixture.Underscore_Class>(dto);

          expect(
            converted,
            const fixture.Underscore_Class(value: 8),
          );
        },
      );

      test(
        'number to number',
            () {
          const dto = fixture.Number123Class(value: 9);
          final converted = mappr.convert<fixture.Number123Class, fixture.Number123Class>(dto);

          expect(
            converted,
            const fixture.Number123Class(value: 9),
          );
        },
      );
    },
  );

  group(
    'in field',
        () {
      test(
        'dollar to dollar',
            () {
          const dto = fixture.DollarField(val$ue: 1);
          final converted = mappr.convert<fixture.DollarField, fixture.DollarField>(dto);

          expect(
            converted,
            const fixture.DollarField(val$ue: 1),
          );
        },
      );

      test(
        'dollar to underscore',
            () {
          const dto = fixture.DollarField(val$ue: 2);
          final converted = mappr.convert<fixture.DollarField, fixture.UnderscoreField>(dto);

          expect(
            converted,
            const fixture.UnderscoreField(val_ue: 2),
          );
        },
      );

      test(
        'dollar to number',
            () {
          const dto = fixture.DollarField(val$ue: 3);
          final converted = mappr.convert<fixture.DollarField, fixture.NumberField>(dto);

          expect(
            converted,
            const fixture.NumberField(val123ue: 3),
          );
        },
      );

      test(
        'underscore to dollar',
            () {
          const dto = fixture.UnderscoreField(val_ue: 4);
          final converted = mappr.convert<fixture.UnderscoreField, fixture.DollarField>(dto);

          expect(
            converted,
            const fixture.DollarField(val$ue: 4),
          );
        },
      );

      test(
        'underscore to underscore',
            () {
          const dto = fixture.UnderscoreField(val_ue: 5);
          final converted = mappr.convert<fixture.UnderscoreField, fixture.UnderscoreField>(dto);

          expect(
            converted,
            const fixture.UnderscoreField(val_ue: 5),
          );
        },
      );

      test(
        'underscore to number',
            () {
          const dto = fixture.UnderscoreField(val_ue: 6);
          final converted = mappr.convert<fixture.UnderscoreField, fixture.NumberField>(dto);

          expect(
            converted,
            const fixture.NumberField(val123ue: 6),
          );
        },
      );

      test(
        'number to dollar',
            () {
          const dto = fixture.NumberField(val123ue: 7);
          final converted = mappr.convert<fixture.NumberField, fixture.DollarField>(dto);

          expect(
            converted,
            const fixture.DollarField(val$ue: 7),
          );
        },
      );

      test(
        'number to underscore',
            () {
          const dto = fixture.NumberField(val123ue: 8);
          final converted = mappr.convert<fixture.NumberField, fixture.UnderscoreField>(dto);

          expect(
            converted,
            const fixture.UnderscoreField(val_ue: 8),
          );
        },
      );

      test(
        'number to number',
            () {
          const dto = fixture.NumberField(val123ue: 9);
          final converted = mappr.convert<fixture.NumberField, fixture.NumberField>(dto);

          expect(
            converted,
            const fixture.NumberField(val123ue: 9),
          );
        },
      );
    },
  );
}
