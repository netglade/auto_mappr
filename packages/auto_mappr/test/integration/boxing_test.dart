import 'package:test/test.dart';

import 'fixture/boxing.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  group('primitives', () {
    test('boxes every field', () {
      // arrange
      const dto = fixture.Todo(id: 42, title: 'Buy milk', done: true);

      // act
      final converted = mappr.convert<fixture.Todo, fixture.TodoCompanion>(dto);

      // assert
      expect(
        converted,
        equals(
          const fixture.TodoCompanion(
            id: fixture.Value(42),
            title: fixture.Value('Buy milk'),
            done: fixture.Value(true),
          ),
        ),
      );
    });

    test('unboxes every field in the reverse direction', () {
      // arrange
      const companion = fixture.TodoCompanion(
        id: fixture.Value(42),
        title: fixture.Value('Buy milk'),
        done: fixture.Value(true),
      );

      // act
      final converted = mappr.convert<fixture.TodoCompanion, fixture.Todo>(companion);

      // assert
      expect(converted, equals(const fixture.Todo(id: 42, title: 'Buy milk', done: true)));
    });
  });

  group('nested object', () {
    test('maps the nested object and boxes the result', () {
      // arrange
      const dto = fixture.Book(fixture.Author('Tolkien'));

      // act
      final converted = mappr.convert<fixture.Book, fixture.BookCompanion>(dto);

      // assert
      expect(
        converted,
        equals(const fixture.BookCompanion(author: fixture.Value(fixture.AuthorEntity('Tolkien')))),
      );
    });

    test('unboxes before mapping the nested object', () {
      // arrange
      const companion = fixture.BookCompanion(author: fixture.Value(fixture.AuthorEntity('Tolkien')));

      // act
      final converted = mappr.convert<fixture.BookCompanion, fixture.Book>(companion);

      // assert
      expect(converted, equals(const fixture.Book(fixture.Author('Tolkien'))));
    });
  });

  group('iterable', () {
    test('boxes the whole list', () {
      // arrange
      const dto = fixture.Tags(['red', 'green']);

      // act
      final converted = mappr.convert<fixture.Tags, fixture.TagsCompanion>(dto);

      // assert
      expect(converted, equals(const fixture.TagsCompanion(values: fixture.Value(['red', 'green']))));
    });

    test('unboxes the whole list', () {
      // arrange
      const companion = fixture.TagsCompanion(values: fixture.Value(['red', 'green']));

      // act
      final converted = mappr.convert<fixture.TagsCompanion, fixture.Tags>(companion);

      // assert
      expect(converted, equals(const fixture.Tags(['red', 'green'])));
    });
  });

  test('leaves already boxed and plain fields alone', () {
    // arrange
    const dto = fixture.Mixed(boxed: 1, alreadyBoxed: fixture.Value(2), plain: 'plain');

    // act
    final converted = mappr.convert<fixture.Mixed, fixture.MixedCompanion>(dto);

    // assert
    expect(
      converted,
      equals(
        const fixture.MixedCompanion(
          boxed: fixture.Value(1),
          alreadyBoxed: fixture.Value(2),
          plain: 'plain',
        ),
      ),
    );
  });

  test('boxing: false falls back to a type converter', () {
    // arrange
    const dto = fixture.OptOut(viaConverter: 7, viaBox: 7);

    // act
    final converted = mappr.convert<fixture.OptOut, fixture.OptOutCompanion>(dto);

    // assert
    expect(
      converted,
      equals(
        const fixture.OptOutCompanion(
          // The converter multiplies by ten, the boxing does not.
          viaConverter: fixture.Value(70),
          viaBox: fixture.Value(7),
        ),
      ),
    );
  });

  test('a custom mapping provides the box itself', () {
    // arrange
    const dto = fixture.Custom(viaCustom: 'a', viaBox: 'b');

    // act
    final converted = mappr.convert<fixture.Custom, fixture.CustomCompanion>(dto);

    // assert
    expect(
      converted,
      equals(
        const fixture.CustomCompanion(
          viaCustom: fixture.Value('custom-a'),
          viaBox: fixture.Value('b'),
        ),
      ),
    );
  });

  test('unboxing works without boxing', () {
    // arrange
    const dto = fixture.OnlyUnbox(fixture.Value(99));

    // act
    final converted = mappr.convert<fixture.OnlyUnbox, fixture.OnlyUnboxTarget>(dto);

    // assert
    expect(converted, equals(const fixture.OnlyUnboxTarget(99)));
  });

  test('an ignored boxed field keeps the box default instead of being null', () {
    // arrange
    const dto = fixture.Ignored(keep: 1, skip: 2);

    // act
    final converted = mappr.convert<fixture.Ignored, fixture.IgnoredCompanion>(dto);

    // assert
    expect(converted, equals(const fixture.IgnoredCompanion(keep: fixture.Value(1))));
    expect(converted.skip.present, isFalse);
  });

  test('the box constructor tearoff works as the boxing function', () {
    // arrange
    const dto = fixture.Tearoff(3);

    // act
    final converted = mappr.convert<fixture.Tearoff, fixture.TearoffCompanion>(dto);

    // assert
    expect(converted, equals(const fixture.TearoffCompanion(amount: fixture.Value(3))));
  });

  test('ignoreFieldNull applies to the unboxed type', () {
    // arrange
    const dto = fixture.Nullable(5);

    // act
    final converted = mappr.convert<fixture.Nullable, fixture.NullableCompanion>(dto);

    // assert
    expect(converted, equals(const fixture.NullableCompanion(amount: fixture.Value(5))));
  });
}
