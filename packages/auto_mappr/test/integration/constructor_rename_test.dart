// ignore_for_file: prefer-static-class

import 'package:test/test.dart';

import 'fixture/constructor_rename.dart' as fixture;

void main() {
  late final fixture.ConstructorRenameMappr mappr;

  setUpAll(() {
    mappr = fixture.ConstructorRenameMappr();
  });

  group('Uses renaming constructor', () {
    test('Use renaming constructor', () {
      // arrange
      const source = fixture.Source(
        name: 'Test',
        address: 'Test Address',
        note: 'Test Note',
      );

      // act
      final converted = mappr.convert<fixture.Source, fixture.Target>(source);

      // assert
      expect(
        converted,
        equals(
          const fixture.Target(
            name: 'Test',
            address: 'Test Address',
            note: 'Test Note',
          ),
        ),
      );
    });
  });
}
