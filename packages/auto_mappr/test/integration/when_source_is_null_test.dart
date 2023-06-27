import 'package:test/test.dart';

import 'fixture/when_source_is_null.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = fixture.Mappr();
  });

  test('whenSourceIsNull with static value ', () {
    const source = fixture.SourceValue(null);
    final target = mappr.convert<fixture.SourceValue, fixture.Target>(source);

    expect(target.name, equals('static'));
  });

  test('whenSourceIsNull with static function in Mappr', () {
    const source = fixture.SourceStatic(null);
    final target = mappr.convert<fixture.SourceStatic, fixture.Target>(source);

    expect(target.name, equals('whenSourceIsNull'));
  });

  test('whenSourceIsNull with top level function', () {
    const source = fixture.SourceTopLevel(null);
    final target = mappr.convert<fixture.SourceTopLevel, fixture.Target>(source);

    expect(target.name, equals('whenSourceIsNullTopLevel'));
  });
}
