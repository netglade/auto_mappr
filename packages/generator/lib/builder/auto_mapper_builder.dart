// ignore_for_file: public_member_api_docs
// ignore_for_file: format-comment

import 'package:analyzer/dart/element/element.dart';
import 'package:auto_mapper_generator/builder/convert_method_builder.dart';
import 'package:auto_mapper_generator/builder/map_model_body_method_builder.dart';
import 'package:auto_mapper_generator/models/auto_mapper_config.dart';
import 'package:code_builder/code_builder.dart';

class AutoMapperBuilder {
  final AutoMapperConfig config;
  final ClassElement mapperClassElement;

  AutoMapperBuilder({
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
    final methods = <Method>[
      _buildTypeOfHelperMethod(),
      //    ConvertMethodBuilder.buildCanConvert(config),
      // Public convert method
      ConvertMethodBuilder.buildConvertMethod(),

      // Internal convert method
      ConvertMethodBuilder.buildInternalConvertMethod(config)
    ];

    // Individual mapper methods of each mappings
    for (final mapping in config.parts) {
      methods.add(
        Method(
          (b) => b
            ..name = mapping.mappingMapMethodName
            ..requiredParameters.addAll([
              Parameter(
                (p) => p
                  ..name = 'input'
                  ..type = refer(mapping.source.getDisplayString(withNullability: true)),
              )
            ])
            ..returns = refer(mapping.target.getDisplayString(withNullability: true))
            ..body = MapModelBodyMethodBuilder(mapping: mapping, mapperConfig: config).build(),
        ),
      );
    }

    return methods;
  }

  Method _buildTypeOfHelperMethod() {
    return Method(
      (b) => b
        ..name = '_typeOf'
        ..types.add(refer('X'))
        ..returns = refer('Type')
        ..lambda = true
        ..body = const Code('X'),
    );
  }
}
