@Skip('Only for manual run')

import 'dart:io';

import 'package:automapper_generator/builder.dart';
import 'package:generator_test/generator_test.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() async {
  final fixtureDir = Directory(p.join('test', 'fixture'));

  final files = (await fixtureDir.list().toList()).whereType<File>();

  for (var file in files) {
    test('Test ${file.uri.pathSegments.last}', () async {
      final generator = SuccessGenerator.fromBuilder(
        file.uri.pathSegments.last.replaceAll('.dart', ''),
        automapperBuilder,
        inputDir: 'test/fixture',
        fixtureDir: 'test/fixture/fixtures',
        compareWithFixture: true,
        onLog: (x) => print(x.message),
      );

      await generator.test();
    });
  }
}
