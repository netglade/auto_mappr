import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator/generator.dart';

/// Main Builder for the [Mapping] Annotation
Builder automapperBuilder(BuilderOptions options) =>
    PartBuilder([MapperGenerator()], '.g.dart', options: options);
