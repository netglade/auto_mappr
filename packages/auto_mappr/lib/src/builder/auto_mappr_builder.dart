// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/element/element2.dart';
import 'package:auto_mappr/src/builder/methods/methods.dart';
import 'package:auto_mappr/src/helpers/urls.dart';
import 'package:auto_mappr/src/models/auto_mappr_config.dart';
import 'package:auto_mappr/src/models/type_mapping.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';

/// Entrypoint for mappr class generation.
class AutoMapprBuilder {
  final AutoMapprConfig config;
  // ignore: deprecated_member_use, source_gen requires this
  final ClassElement2 mapperClassElement;

  static const List<String> fileIgnores = [
    // ignore everything
    'type=lint',
    'unused_local_variable',
    'unnecessary_cast',
  ];

  const AutoMapprBuilder({
    required this.config,
    required this.mapperClassElement,
  });

  Library build() {
    return Library(
      (b) => b
        ..ignoreForFile = ListBuilder(fileIgnores)
        ..body.addAll([
          Class(
            (cb) => cb
              ..name = '\$${mapperClassElement.displayName}'
              ..implements = ListBuilder([refer('AutoMapprInterface', Urls.annotationPackageUrl)])
              ..methods.addAll(_buildMethods())
              ..constructors.addAll(_buildConstructors())
              ..docs = ListBuilder(config.getAvailableMappingsDocComment()),
          ),
        ]),
    );
  }

  /// Generates all constructors within mapper.
  List<Constructor> _buildConstructors() {
    return [
      // Constant constructor to allow usage of modules.
      Constructor((builder) => builder..constant = true),
    ];
  }

  /// Generates all methods within mapper.
  List<Method> _buildMethods() {
    final nullableMappings = <TypeMapping>{};

    // ignore: avoid-local-functions, better to keep local here
    void usedNullableMappingMethod(TypeMapping? mapping) {
      if (mapping == null) return;

      final _ = nullableMappings.add(mapping);
    }

    // Generates non nullable mapping method.
    return [
      // Helper method for typeOf.
      TypeOfMethodBuilder(config).buildMethod(),

      // Getter method for modules from the annotation.
      PrivateModulesMethodBuilder(config).buildMethod(),

      // Public canConvert method.
      CanConvertMethodBuilder(config).buildMethod(),
      // Public convert method.
      ConvertMethodBuilder(config).buildMethod(),
      // Public tryConvert method.
      TryConvertMethodBuilder(config).buildMethod(),

      // Public convertIterable and tryConvertIterable methods.
      ConvertIterableMethodBuilder(config, wrapper: 'Iterable').buildMethod(),
      TryConvertIterableMethodBuilder(config, wrapper: 'Iterable').buildMethod(),

      // Public convertList and tryConvertList methods.
      ConvertIterableMethodBuilder(
        config,
        wrapper: 'List',
        iterableTransformer: 'toList',
      ).buildMethod(),
      TryConvertIterableMethodBuilder(
        config,
        wrapper: 'List',
        iterableTransformer: 'toList',
      ).buildMethod(),

      // Public convertSet and tryConvertSet methods.
      ConvertIterableMethodBuilder(
        config,
        wrapper: 'Set',
        iterableTransformer: 'toSet',
      ).buildMethod(),
      TryConvertIterableMethodBuilder(
        config,
        wrapper: 'Set',
        iterableTransformer: 'toSet',
      ).buildMethod(),

      // Internal convert method.
      PrivateConvertMethodBuilder(config).buildMethod(),

      // Internal safe convert method.
      SafeConvertMethodBuilder(config).buildMethod(),

      // Use safe mapping  method.
      UseSafeMappingMethodBuilder(config).buildMethod(),

      // Generate non-nullable mapping method.
      for (final mapping in config.mappers)
        MappingMethodBuilder(
          config,
          mapping: mapping,
          onUsedNullableMethodCallback: usedNullableMappingMethod,
        ).buildMethod(),

      // Generates nullable mapping method only when nullable method is used.
      for (final mapping in config.mappers.where(nullableMappings.contains))
        MappingMethodBuilder(config, mapping: mapping, nullable: true).buildMethod(),
    ];
  }
}
