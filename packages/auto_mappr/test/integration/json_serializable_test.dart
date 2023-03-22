import 'package:test/test.dart';

import 'fixture/json_serializable.dart' as fixture;

void main() {
  late final fixture.Mapper mapper;

  setUpAll(() {
    mapper = fixture.Mapper();
  });

  test('Mapper works with json serializable', () {
    const dto = fixture.UserDto(firstName: 'Ada', lastName: 'Lovelace');
    final converted = mapper.convert<fixture.UserDto, fixture.User>(dto);

    expect(converted.firstName, 'Ada');
    expect(converted.lastName, 'Lovelace');
  });

  test('Finds correct constructor with one field', () {
    const dto = fixture.ValueHolderDto({'alpha': 'beta'});
    final converted = mapper.convert<fixture.ValueHolderDto, fixture.ValueHolder>(dto);

    expect(converted.json, {'alpha': 'beta'});
  });
}
