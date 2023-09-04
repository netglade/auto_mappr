import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:auto_mappr/src/models/auto_mappr_config.dart';
import 'package:auto_mappr/src/models/type_mapping.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';
import 'package:meta/meta.dart';

/// Base class for method builders.
abstract class MethodBuilderBase {
  static const delegatesField = '_delegates';

  static const sourceKey = 'SOURCE';
  static const sourceTypeReference = Reference(sourceKey);
  static const nullableSourceTypeReference = Reference('$sourceKey?');
  static const sourceTypeOf = Reference('_typeOf<$sourceKey>()');

  static const targetKey = 'TARGET';
  static const targetTypeReference = Reference(targetKey);
  static const nullableTargetTypeReference = Reference('$targetKey?');
  static const targetTypeOf = Reference('_typeOf<$targetKey>()');

  static final ListBuilder<Reference> overrideAnnotation = ListBuilder([const Reference('override')]);

  final AutoMapprConfig config;
  final Set<TypeMapping> nullableMappings;

  MethodBuilderBase(this.config) : nullableMappings = {};

  static String constructConvertMethodName({
    required DartType source,
    required DartType target,
    required AutoMapprConfig config,
  }) =>
      '_map__${source.toConvertMethodName(withNullability: false, config: config)}__To__${target.toConvertMethodName(
        withNullability: false,
        config: config,
      )}';

  static String constructNullableConvertMethodName({
    required DartType source,
    required DartType target,
    required AutoMapprConfig config,
  }) =>
      '${constructConvertMethodName(
        source: source,
        target: target,
        config: config,
      )}_Nullable';

  bool shouldGenerateNullableMappingMethod(TypeMapping mapping) {
    return nullableMappings.contains(mapping);
  }

  void usedNullableMappingMethod(TypeMapping? mapping) {
    if (mapping == null) return;

    final _ = nullableMappings.add(mapping);
  }

  Method buildMethod();

  @protected
  Code buildBody();

  // Generates code like:
  /*
     final sourceTypeOf = _typeOf<SOURCE>();
     final targetTypeOf = _typeOf<TARGET>();
     if ((sourceTypeOf == _typeOf<UserDto>() ||
             sourceTypeOf == _typeOf<UserDto?>()) &&
         (targetTypeOf == _typeOf<User>() || targetTypeOf == _typeOf<User?>())) {
       return true
      }
  */
  Expression buildMatchingIfCondition({
    required TypeMapping mapping,
    required Reference sourceTypeOfReference,
    required Reference targetTypeOfReference,
    required Spec inIfExpression,
  }) {
    final sourceName = mapping.source.getDisplayStringWithLibraryAlias(config: config);
    final targetName = mapping.target.getDisplayStringWithLibraryAlias(config: config);

    final modelIsTypeExpression = sourceTypeOfReference
        .equalTo(refer('_typeOf<$sourceName>()'))
        .or(sourceTypeOfReference.equalTo(refer('_typeOf<$sourceName?>()')));

    final outputExpression = targetTypeOfReference
        .equalTo(refer('_typeOf<$targetName>()'))
        .or(targetTypeOfReference.equalTo(refer('_typeOf<$targetName?>()')));

    final ifConditionExpression = modelIsTypeExpression.bracketed().and(outputExpression.bracketed());

    return ifConditionExpression.ifStatement2(ifBody: inIfExpression);
  }
}
