import 'package:auto_mapper/builder.dart';
import 'package:generator_test/generator_test.dart';
import 'package:test/test.dart';

import '../fixture/rename.dart' as fixture;

void main() {
  late final fixture.Mapper mapper;

  setUpAll(() {
    mapper = fixture.Mapper();
  });

  group(
    'Generator',
    () {
      test('generates', () async {
        final generator = SuccessGenerator.fromBuilder('rename', autoMapperBuilder);
        await generator.test();
      });
    },
  );
}
