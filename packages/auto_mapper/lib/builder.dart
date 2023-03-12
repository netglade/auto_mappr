//ignore_for_file: prefer-static-class

import 'package:auto_mapper/generator/auto_mapper_generator.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// Main Builder for the [Mapping] Annotation
Builder automapperBuilder(BuilderOptions options) => PartBuilder(
      [AutoMapperGenerator()],
      '.g.dart',
      options: options,
    );
