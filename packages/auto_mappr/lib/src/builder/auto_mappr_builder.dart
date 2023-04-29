// ignore_for_file: public_member_api_docs
// ignore_for_file: format-comment

import 'package:analyzer/dart/element/element.dart';
import 'package:auto_mappr/src/builder/convert_method_builder.dart';
import 'package:auto_mappr/src/builder/map_model_body_method_builder.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/models/auto_mappr_config.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';

class AutoMapprBuilder {
  final AutoMapprConfig config;
  final ClassElement mapperClassElement;

  static const List<String> fileIgnores = [
    'unnecessary_parenthesis',
    'non_constant_identifier_names',
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
                ..methods.addAll(_buildMethods())
                ..docs = ListBuilder(config.getAvailableMappingsDocComment()),
            ),
          ],
        ),
    );
  }

  /// Generates all methods within mapper.
  List<Method> _buildMethods() {
    final convertMethodBuilder = ConvertMethodBuilder(config);

    // Generates non nullable mapping method.
    return [
      // Helper method for typeOf.
      convertMethodBuilder.buildTypeOfHelperMethod(),

      // Public convert method
      convertMethodBuilder.buildConvertMethod(),
      // Public tryConvert method
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
            ..name = mapping.mappingMethodName(config: config)
            ..requiredParameters.addAll([
              Parameter(
                (p) => p
                  ..name = 'input'
                  ..type = refer('${mapping.source.getDisplayStringWithLibraryAlias(config: config)}?'),
              )
            ])
            ..returns = refer(
              mapping.target.getDisplayStringWithLibraryAlias(config: config),
            )
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
            ..name = mapping.nullableMappingMethodName(config: config)
            ..requiredParameters.addAll([
              Parameter(
                (p) => p
                  ..name = 'input'
                  ..type = refer('${mapping.source.getDisplayStringWithLibraryAlias(config: config)}?'),
              )
            ])
            ..returns = refer('${mapping.target.getDisplayStringWithLibraryAlias(
              withNullability: true,
              config: config,
            )}?')
            ..body = MapModelBodyMethodBuilder(
              mapping: mapping,
              mapperConfig: config,
              nullable: true,
            ).build(),
        ),
    ];
  }
}
