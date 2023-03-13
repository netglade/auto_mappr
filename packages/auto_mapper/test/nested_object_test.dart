import 'package:auto_mapper/builder.dart';
import 'package:generator_test/generator_test.dart';
import 'package:test/test.dart';

void main() {
  test('Nested object mapping', () async {
    final generator = SuccessGenerator.fromBuilder('nested_object', autoMapperBuilder);
    await generator.test();
  });
}
