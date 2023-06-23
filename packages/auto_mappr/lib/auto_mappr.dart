//ignore_for_file: prefer-static-class

import 'package:auto_mappr/src/generator/auto_mappr_generator.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// Main Builder for the `AutoMappr` Annotation.
Builder autoMapprBuilder(BuilderOptions _) => SharedPartBuilder(
      [const AutoMapprGenerator()],
      'auto_mappr',
    );

Builder autoMapprBuilderNotShared(BuilderOptions _) => PartBuilder(
      [const AutoMapprGenerator()],
      '.auto_mappr.dart',
    );
