//ignore_for_file: prefer-static-class

import 'package:auto_mappr/generator/auto_mapper_generator.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// Main Builder for the `AutoMappr` Annotation
Builder autoMapprBuilder(BuilderOptions _) => SharedPartBuilder(
      [AutoMapperGenerator()],
      'auto_mappr',
    );
