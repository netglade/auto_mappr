import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/builder/assignments/assignments.dart';
import 'package:auto_mappr/src/builder/methods/method_builder_base.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/helpers/emitter_helper.dart';
import 'package:auto_mappr/src/models/models.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

/// Separate logic as a mixin so we do not soil [AssignmentBuilderBase].
mixin NestedObjectMixin on AssignmentBuilderBase {
  /// Assigns nested object as either:
  /// - default value
  /// - call to already generated mapping between two typ`es
  ///
  /// If [convertMethodArgument] is null, uses a tear off call instead.
  Expression assignNestedObject({
    required DartType source,
    required DartType target,
    required SourceAssignment assignment,
    Expression? convertMethodArgument,
    bool includeGenericTypes = false,
  }) {
    final sourceOnModel = refer('model').property(assignment.sourceField!.displayName);

    // Source and target is the same.
    if (source.isSame(target)) {
      return sourceOnModel;
    }

    final nestedMapping = mapperConfig.findMapping(
      source: source,
      target: target,
    );

    // Type converters.
    final typeConvertersBuilder = TypeConverterBuilder(
      assignment: assignment,
      mapperConfig: mapperConfig,
      mapping: mapping,
      usedNullableMethodCallback: null,
      convertMethodArgument: convertMethodArgument,
      source: source,
      target: target,
    );
    if (typeConvertersBuilder.canAssign()) {
      return typeConvertersBuilder.buildAssignment();
    }

    // if (assignment.typeConverters
    //         .firstWhereOrNull((converter) => converter.canBeUsed(mappingSource: source, mappingTarget: target))
    //     case final converter?) {
    //   // Call.
    //   if (convertMethodArgument != null) {
    //     final targetRefer = EmitterHelper.current.typeRefer(type: target);

    //     return EmitterHelper.current
    //         .refer(converter.converter.referCallString, converter.converter.library.identifier)
    //         .call([convertMethodArgument]).asA(targetRefer);
    //   }

    //   final sourceEmitted = EmitterHelper.current.typeReferEmitted(type: source);
    //   final targetEmitted = EmitterHelper.current.typeReferEmitted(type: target);

    //   // Tear-off.
    //   return EmitterHelper.current
    //       .refer(converter.converter.referCallString, converter.converter.library.identifier)
    //       .asA(refer('$targetEmitted Function($sourceEmitted)'));
    // }

    // Unknown mapping.
    if (nestedMapping == null) {
      final sourceName = assignment.sourceField?.getDisplayString(withNullability: true);

      if (target.isNullable) {
        log.warning("Can't find nested mapping '$assignment' but target is nullable. Setting null");

        return literalNull;
      }

      final emittedTarget = EmitterHelper.current.typeReferEmitted(type: target);
      throw InvalidGenerationSourceError(
        'Trying to map nested object from "$assignment" but no mapping is configured.',
        todo: 'Configure mapping from $sourceName to $emittedTarget',
      );
    }

    final convertCallExpression = mappingCall(
      nestedMapping: nestedMapping,
      source: source,
      target: target,
      convertMethodArgument: convertMethodArgument,
      includeGenericTypes: includeGenericTypes,
    );

    // If source == null and target not nullable -> use whenNullDefault if possible
    final fieldMapping = mapping.tryGetFieldMapping(assignment.targetName);
    if (source.isNullable && (fieldMapping?.whenNullExpression != null)) {
      // Generates code like:
      //
      // model.name == null
      //     ? const Nested(
      //         id: 123,
      //         name: 'test',
      //       )
      //     : _map_NestedDto_To_Nested(model.name),
      return sourceOnModel.equalTo(literalNull).conditional(
            fieldMapping!.whenNullExpression!,
            convertCallExpression,
          );
    }

    // Generates code like:
    //
    // `_map_NestedDto_To_Nested(model.name)`
    return convertCallExpression;
  }

  /// Generates a mapping call `_mapAlphaDto_to_Alpha(convertMethodArgument)`.
  /// When [convertMethodArgument] is null, then a tear off `_mapAlphaDto_to_Alpha` is generated.
  ///
  /// This function also marks nullable mapping to be generated
  /// using the [usedNullableMethodCallback] callback.
  Expression mappingCall({
    required DartType source,
    required DartType target,
    required TypeMapping nestedMapping,
    Expression? convertMethodArgument,
    bool includeGenericTypes = false,
  }) {
    final targetNullable = target.isNullable;

    final useNullableMethod = targetNullable && !mapping.hasWhenNullDefault();

    // When target is nullable, use nullable convert method.
    // But use non-nullable when the mapping has default value.
    //
    // Otherwise use non-nullable.
    final convertMethod = refer(
      useNullableMethod
          ? MethodBuilderBase.constructNullableConvertMethodName(
              source: source,
              target: target,
              config: mapperConfig,
            )
          : MethodBuilderBase.constructConvertMethodName(
              source: source,
              target: target,
              config: mapperConfig,
            ),
    );

    if (useNullableMethod) {
      usedNullableMethodCallback?.call(nestedMapping);
    }

    return convertMethodArgument == null
        ? convertMethod
        : convertMethod.call(
            [convertMethodArgument],
            {},
            includeGenericTypes
                ? [
                    EmitterHelper.current.typeRefer(type: source),
                    EmitterHelper.current.typeRefer(type: target),
                  ]
                : [],
          );
  }
}
