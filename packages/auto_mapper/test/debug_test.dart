import 'package:auto_mapper/builder.dart';
import 'package:generator_test/generator_test.dart';
import 'package:test/test.dart';

void main() {
  test('debug', () async {
    final generator = SuccessGenerator.fromBuilder(
        '_debug',
        fixtureDir: 'test/debug',
        inputDir: 'test/debug',
        automapperBuilder,
        compareWithFixture: false);

    await generator.test();

    final v = generator.fixtureContent();

    print(v);
  });

  // test('fixtures', () async {
  //   initializeBuildLogTracking();
  //   final reader = await initializeLibraryReaderForDirectory(
  //     p.join('test', 'fixture'),
  //     'input.dart',
  //   );

  //   testAnnotatedElements(
  //     reader,
  //     MapperGenerator(),
  //     expectedAnnotatedTests: _expectedAnnotatedTests,
  //   );
  // });
}
