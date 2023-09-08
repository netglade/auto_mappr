//ignore_for_file: prefer-static-class

import 'package:auto_mappr/src/generator/auto_mappr_generator.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// Main Builder for the `AutoMappr` Annotation.
Builder autoMapprBuilder(BuilderOptions options) => LibraryBuilder(
      AutoMapprGenerator(builderOptions: options),
      generatedExtension: '.auto_mappr.dart',
      allowSyntaxErrors: true,
      options: options,
    );
