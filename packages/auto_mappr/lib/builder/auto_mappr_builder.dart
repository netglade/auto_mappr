// ignore_for_file: public_member_api_docs
// ignore_for_file: format-comment

import 'package:analyzer/dart/element/element.dart';
import 'package:auto_mappr/builder/convert_method_builder.dart';
import 'package:auto_mappr/builder/map_model_body_method_builder.dart';
import 'package:auto_mappr/models/auto_mappr_config.dart';
import 'package:code_builder/code_builder.dart';

class AutoMapprBuilder {
  final AutoMapprConfig config;
  final ClassElement mapperClassElement;

  AutoMapprBuilder({
    required this.config,
    required this.mapperClassElement,
  });

  Library build() {
    return Library(
      (b) => b.body.addAll(
        [
          Class(
            (b) => b
              ..name = '\$${mapperClassElement.displayName}'
              ..methods.addAll(_buildMethods()),
          ),
        ],
      ),
    );
  }

  /// Generates all methods within mapper.
  List<Method> _buildMethods() {
    return [
      // Helper method for typeOf.
      ConvertMethodBuilder.buildTypeOfHelperMethod(),

      // Public convert method
      ConvertMethodBuilder.buildConvertMethod(),

      // Internal convert method
      ConvertMethodBuilder.buildInternalConvertMethod(config),

      // Individual mapper methods of each mappings
      for (final mapping in config.mappers) ...[
        // Returns non nullable.
        Method(
          (b) => b
            ..name = mapping.mappingMethodName
            ..requiredParameters.addAll([
              Parameter(
                (p) => p
                  ..name = 'input'
                  ..type = refer('${mapping.source.getDisplayString(withNullability: false)}?'),
              )
            ])
            ..returns = refer(mapping.target.getDisplayString(withNullability: false))
            ..body = MapModelBodyMethodBuilder(mapping: mapping, mapperConfig: config).build(),
        ),
        // Returns nullable.
        if (!mapping.hasWhenNullDefault())
          Method(
            (b) => b
              ..name = mapping.nullableMappingMethodName
              ..requiredParameters.addAll([
                Parameter(
                  (p) => p
                    ..name = 'input'
                    ..type = refer('${mapping.source.getDisplayString(withNullability: false)}?'),
                )
              ])
              ..returns = refer('${mapping.target.getDisplayString(withNullability: true)}?')
              ..body = MapModelBodyMethodBuilder(mapping: mapping, mapperConfig: config, nullable: true).build(),
          ),
      ]
    ];
  }
}
