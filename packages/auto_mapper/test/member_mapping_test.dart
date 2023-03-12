import 'package:auto_mapper/builder.dart';
import 'package:generator_test/generator_test.dart';
import 'package:test/test.dart';

void main() {
  test('Member mapping - nullability', () async {
    final generator = SuccessGenerator.fromBuilder(
        'member_mapping_nullables', automapperBuilder);
    await generator.test();
  });
}
