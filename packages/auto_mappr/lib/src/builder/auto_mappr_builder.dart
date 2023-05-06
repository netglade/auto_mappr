// ignore_for_file: public_member_api_docs
// ignore_for_file: format-comment

import 'package:analyzer/dart/element/element.dart';
import 'package:auto_mappr/src/builder/convert_method_builder.dart';
import 'package:auto_mappr/src/builder/map_model_body_method_builder.dart';
import 'package:auto_mappr/src/models/auto_mappr_config.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';

class AutoMapprBuilder {
  final AutoMapprConfig config;
  final ClassElement mapperClassElement;

  static const List<String> fileIgnores = [
    'unnecessary_parenthesis',
    'non_constant_identifier_names',
    'unnecessary_const',
    'require_trailing_commas',
    'unnecessary_raw_strings',
    'unnecessary_lambdas',

    // Can we fix this somehow? (const defaults, const customs)
    'prefer_const_constructors',
    'prefer_const_literals_to_create_immutables'
  ];

  AutoMapprBuilder({
    required this.config,
    required this.mapperClassElement,
  });

  Library build() {
    return Library(
      (b) => b
        ..ignoreForFile = ListBuilder(fileIgnores)
        ..body.addAll(
          [
            Class(
              (b) => b
                ..name = '\$${mapperClassElement.displayName}'
                ..implements = ListBuilder([refer('AutoMapprInterface')])
                ..methods.addAll(_buildMethods())
                ..constructors.addAll(_buildConstructors())
                ..docs = ListBuilder(config.getAvailableMappingsDocComment()),
            ),
          ],
        ),
    );
  }

  /// Generates all constructors within mapper.
  List<Constructor> _buildConstructors() {
    return [
      // Constant constructor to allow usage of modules.
      Constructor(
        (builder) => builder..constant = true,
      ),
    ];
  }

  /// Generates all methods within mapper.
  List<Method> _buildMethods() {
    final convertMethodBuilder = ConvertMethodBuilder(config);

    // Generates non nullable mapping method.
    return [
      // Helper method for typeOf.
      convertMethodBuilder.buildTypeOfHelperMethod(),

      // Getter method for modules from the annotation.
      convertMethodBuilder.buildModulesGetter(config.modules),

      // Public canConvert method.
      convertMethodBuilder.buildCanConvertMethod(),
      // Public convert method.
      convertMethodBuilder.buildConvertMethod(),
      // Public tryConvert method.
      convertMethodBuilder.buildTryConvertMethod(),

      // Public convertIterable and tryConvertIterable methods.
      convertMethodBuilder.buildConvertIterableMethod(wrapper: 'Iterable'),
      convertMethodBuilder.buildTryConvertIterableMethod(wrapper: 'Iterable'),

      // Public convertList and tryConvertList methods.
      convertMethodBuilder.buildConvertIterableMethod(wrapper: 'List', iterableTransformer: 'toList'),
      convertMethodBuilder.buildTryConvertIterableMethod(wrapper: 'List', iterableTransformer: 'toList'),

      // Public convertSet and tryConvertSet methods.
      convertMethodBuilder.buildConvertIterableMethod(wrapper: 'Set', iterableTransformer: 'toSet'),
      convertMethodBuilder.buildTryConvertIterableMethod(wrapper: 'Set', iterableTransformer: 'toSet'),

      // Internal convert method
      convertMethodBuilder.buildInternalConvertMethod(),

      // Generate non-nullable mapping method.
      for (final mapping in config.mappers)
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
            ..body = MapModelBodyMethodBuilder(
              mapping: mapping,
              mapperConfig: config,
              usedNullableMethodCallback: convertMethodBuilder.usedNullableMappingMethod,
            ).build(),
        ),

      // Generates nullable mapping method only when nullable method is used.
      for (final mapping in config.mappers.where(convertMethodBuilder.shouldGenerateNullableMappingMethod))
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
            ..body = MapModelBodyMethodBuilder(
              mapping: mapping,
              mapperConfig: config,
              nullable: true,
            ).build(),
        ),
    ];
  }
}
