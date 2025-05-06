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
      const source = fixture.Source(
        name: 'Test',
        address: 'Test Address',
        note: 'Test Note',
      );

      final converted = mappr.convert<fixture.Source, fixture.Target>(source);

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
