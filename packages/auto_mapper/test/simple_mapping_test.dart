import 'package:auto_mapper_generator/builder.dart';
import 'package:generator_test/generator_test.dart';
import 'package:test/test.dart';

import 'fixture/only_positional.dart' as positional;

void main() {
  test('Only positional', () async {
    final generator = SuccessGenerator.fromBuilder('only_positional', automapperBuilder);
    await generator.test();

    // Mapping test
    final mapper = positional.Mapper();
    final dto = positional.UserDto(1, 'joe');
    final user = mapper.convert<positional.UserDto, positional.User>(dto);

    expect(user.id, dto.id);
    expect(user.name, dto.name);
  });

  test('Only required named', () async {
    final generator = SuccessGenerator.fromBuilder('only_required_named', automapperBuilder);
    await generator.test();
  });
}
