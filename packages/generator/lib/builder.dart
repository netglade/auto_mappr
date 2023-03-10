//ignore_for_file: prefer-static-class

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator/auto_mapper_generator.dart';

/// Main Builder for the [Mapping] Annotation
Builder automapperBuilder(BuilderOptions options) => PartBuilder(
      [AutoMapperGenerator()],
      '.g.dart',
      options: options,
    );
