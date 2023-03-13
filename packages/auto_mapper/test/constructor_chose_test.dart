import 'package:auto_mapper/builder.dart';
import 'package:generator_test/generator_test.dart';
import 'package:test/test.dart';

void main() {
  test('Multiple  constructors', () async {
    final generator = SuccessGenerator.fromBuilder('constructor_multiple', autoMapperBuilder);
    await generator.test();
  });
}
