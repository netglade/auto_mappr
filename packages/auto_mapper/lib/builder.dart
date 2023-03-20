//ignore_for_file: prefer-static-class

import 'package:auto_mapper/generator/auto_mapper_generator.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// Main Builder for the `AutoMapper` Annotation
Builder autoMapperBuilder(BuilderOptions _) => SharedPartBuilder(
      [AutoMapperGenerator()],
      'auto_mapper',
    );
