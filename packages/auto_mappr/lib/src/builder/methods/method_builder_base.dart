import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:auto_mappr/src/helpers/emitter_helper.dart';
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

  static const modelReference = Reference('model');

  static final ListBuilder<Reference> overrideAnnotation = ListBuilder([const Reference('override')]);

  final AutoMapprConfig config;

  const MethodBuilderBase(this.config);

  static String constructConvertMethodName({
    required DartType source,
    required DartType target,
  }) =>
      '_map_${source.toConvertMethodName()}_To_${target.toConvertMethodName()}';

  static String constructNullableConvertMethodName({
    required DartType source,
    required DartType target,
  }) =>
      '${constructConvertMethodName(source: source, target: target)}_Nullable';

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
    final sourceName = EmitterHelper.current.typeReferEmitted(type: mapping.source);
    final targetName = EmitterHelper.current.typeReferEmitted(type: mapping.target);

    final modelIsTypeExpression = sourceTypeOfReference
        .equalTo(refer('_typeOf<$sourceName>()'))
        .or(sourceTypeOfReference.equalTo(refer('_typeOf<$sourceName?>()')));

    final outputExpression = targetTypeOfReference
        .equalTo(refer('_typeOf<$targetName>()'))
        .or(targetTypeOfReference.equalTo(refer('_typeOf<$targetName?>()')));

    final ifConditionExpression = modelIsTypeExpression.bracketed().and(outputExpression.bracketed());

    return ifConditionExpression.ifStatement2(ifBody: inIfExpression);
  }

  Expression buildSourceAndTargetEquals({required TypeMapping mapping}) {
    final sourceName = EmitterHelper.current.typeReferEmitted(type: mapping.source);
    final targetName = EmitterHelper.current.typeReferEmitted(type: mapping.target);

    final sourceEquation = refer('sourceTypeOf').equalTo(refer('_typeOf<$sourceName>()'));

    final targetEquation = refer('targetTypeOf').equalTo(refer('_typeOf<$targetName>()'));

    return sourceEquation.and(targetEquation);
  }
}
