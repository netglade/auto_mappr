import 'package:auto_mapper_generator/builder.dart';
import 'package:generator_test/generator_test.dart';
import 'package:test/test.dart';

void main() {
  test('Only positional', () async {
    final generator = SuccessGenerator.fromBuilder('only_positional', automapperBuilder);
    await generator.test();
  });

  test('Only required named', () async {
    final generator = SuccessGenerator.fromBuilder('only_positional', automapperBuilder);
    await generator.test();
  });
}
