// ignore_for_file: prefer-static-class

import 'package:test/test.dart';

import 'fixture/source_constructor.dart' as fixture;

void main() {
  late final fixture.SourceConstructorMappr mappr;

  setUpAll(() {
    mappr = const fixture.SourceConstructorMappr();
  });

  group('sourceConstructor', () {
    test('uses targetConstructor for forward mapping', () {
      // arrange
      const source = fixture.Source(name: 'Alpha', note: 'Note');

      // act
      final converted = mappr.convert<fixture.Source, fixture.Target>(source);

      // assert
      expect(converted, equals(const fixture.Target(name: 'Alpha', note: 'forward: Note')));
    });

    test('uses sourceConstructor for reverse mapping', () {
      // arrange
      const target = fixture.Target(name: 'Alpha', note: 'Note');

      // act
      final converted = mappr.convert<fixture.Target, fixture.Source>(target);

      // assert
      expect(converted, equals(const fixture.Source(name: 'Alpha', note: 'reversed: Note')));
    });

    test('falls back to the default constructor when sourceConstructor is not set', () {
      // arrange
      const target = fixture.DefaultReverseTarget(name: 'Alpha', note: 'Note');

      // act
      final converted = mappr.convert<fixture.DefaultReverseTarget, fixture.Source>(target);

      // assert
      expect(converted, equals(const fixture.Source(name: 'Alpha', note: 'Note')));
    });

    test('maps into constructor parameters not corresponding to the fields of the class they construct', () {
      // arrange
      const source = fixture.NonCorrespondingSource(secret: 'Alpha');

      // act
      final converted = mappr.convert<fixture.NonCorrespondingSource, fixture.NonCorrespondingTarget>(source);

      // assert
      expect(converted, equals(const fixture.NonCorrespondingTarget(value: 'forward: Alpha')));
    });

    test('maps into sourceConstructor parameters not corresponding to the fields of the class they construct', () {
      // arrange
      const target = fixture.NonCorrespondingTarget(value: 'Alpha');

      // act
      final converted = mappr.convert<fixture.NonCorrespondingTarget, fixture.NonCorrespondingSource>(target);

      // assert
      expect(converted, equals(const fixture.NonCorrespondingSource(secret: 'reversed: Alpha')));
    });

    test('does not reuse constructor on the source class when it has the same name', () {
      // arrange
      const target = fixture.SharedNameTarget(value: 'Alpha');

      // act
      final converted = mappr.convert<fixture.SharedNameTarget, fixture.SharedNameSource>(target);

      // assert
      expect(converted, equals(const fixture.SharedNameSource(value: 'Alpha')));
    });
  });
}
