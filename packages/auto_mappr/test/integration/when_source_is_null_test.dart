import 'package:test/test.dart';

import 'fixture/when_source_is_null.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = fixture.Mappr();
  });

  test('whenSourceIsNull with static value ', () {
    // arrange
    const source = fixture.SourceValue(null);

    // act
    final target = mappr.convert<fixture.SourceValue, fixture.Target>(source);

    // assert
    expect(target.name, equals('static'));
  });

  test('whenSourceIsNull with static function in Mappr', () {
    // arrange
    const source = fixture.SourceStatic(null);
    
    // act
    final target = mappr.convert<fixture.SourceStatic, fixture.Target>(source);

    // assert
    expect(target.name, equals('whenSourceIsNull'));
  });

  test('whenSourceIsNull with top level function', () {
    // arrange
    const source = fixture.SourceTopLevel(null);

    // act
    final target = mappr.convert<fixture.SourceTopLevel, fixture.Target>(source);

    // assert
    expect(target.name, equals('whenSourceIsNullTopLevel'));
  });
}
