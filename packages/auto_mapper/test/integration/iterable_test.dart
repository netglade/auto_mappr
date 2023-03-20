import 'package:test/test.dart';

import 'fixture/iterable.dart' as fixture;

void main() {
  late final fixture.Mapper mapper;

  setUpAll(() {
    mapper = fixture.Mapper();
  });

  // TODO(collections): add tests
  // test('Equatable.props and only-setter fields are not mapped', () {
  //   const dto = fixture.Source(123);
  //   final converted = mapper.convert<fixture.Source, fixture.Target>(dto);
  //
  //   expect(
  //     converted,
  //     const fixture.Target(123),
  //   );
  // });
}
