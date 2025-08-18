import 'package:auto_mappr/auto_mappr.dart';
import 'package:auto_mappr/src/helpers/run_zoned_auto_mappr.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

import 'fixture/enum_mapping.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  test('Simple enum', () {
    const source = fixture.Person.parent;

    final target = mappr.convert<fixture.Person, fixture.User>(source);

    expect(target, equals(fixture.User.parent));
  });

  test('Simple enum with unknown case', () {
    const source = fixture.RemotePerson.vp;
    final target = mappr.convert<fixture.RemotePerson, fixture.LocalPerson>(source);

    expect(target, equals(fixture.LocalPerson.unknown));
  });

  test('Enhanced enum', () {
    const source = fixture.EnhancedSource.parent;

    final target = mappr.convert<fixture.EnhancedSource, fixture.EnhancedTarget>(source);

    expect(target, equals(fixture.EnhancedTarget.parent));
  });

  test('Enhanced enum with unknown case', () {
    const source = fixture.EnhancedSourceWithUnknown.alien;

    final target = mappr.convert<fixture.EnhancedSourceWithUnknown, fixture.EnhancedTarget>(source);

    expect(target, equals(fixture.EnhancedTarget.unknown));
  });
}
