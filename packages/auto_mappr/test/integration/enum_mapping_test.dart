import 'package:test/test.dart';

import 'fixture/enum_mapping.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  test('Simple enum', () {
    // arrange
    const source = fixture.Person.parent;

    // act
    final target = mappr.convert<fixture.Person, fixture.User>(source);

    // assert
    expect(target, equals(fixture.User.parent));
  });

  test('Simple enum with unknown case', () {
    // arrange
    const source = fixture.RemotePerson.vp;

    // act
    final target = mappr.convert<fixture.RemotePerson, fixture.LocalPerson>(source);

    // assert
    expect(target, equals(fixture.LocalPerson.unknown));
  });

  test('Enhanced enum', () {
    // arrange
    const source = fixture.EnhancedSource.parent;

    // act
    final target = mappr.convert<fixture.EnhancedSource, fixture.EnhancedTarget>(source);

    // assert
    expect(target, equals(fixture.EnhancedTarget.parent));
  });

  test('Enhanced enum with unknown case', () {
    // arrange
    const source = fixture.EnhancedSourceWithUnknown.alien;

    // act
    final target = mappr.convert<fixture.EnhancedSourceWithUnknown, fixture.EnhancedTarget>(source);

    // assert
    expect(target, equals(fixture.EnhancedTarget.unknown));
  });
}
