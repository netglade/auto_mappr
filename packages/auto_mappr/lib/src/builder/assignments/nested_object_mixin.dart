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
  /// - call to already generated mapping between two types
  ///
  /// If [convertMethodArgument] is null, uses a tear off call instead.
  Expression assignNestedObject({
    required DartType source,
    required DartType target,
    required SourceAssignment assignment,
    Expression? convertMethodArgument,
    bool includeGenericTypes = false,
  }) {
    final sourceOnModel = AssignmentBuilderBase.modelReference.property(assignment.sourceField!.displayName);

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
      onUsedNullableMethodCallback: null,
      convertMethodArgument: convertMethodArgument,
      source: source,
      target: target,
    );
    if (typeConvertersBuilder.canAssign()) {
      return typeConvertersBuilder.buildAssignment();
    }

    // Unknown mapping.
    if (nestedMapping == null) {
      final sourceParentClass = assignment.sourceField?.enclosingElement.name;
      final targetParentClass = assignment.targetField?.enclosingElement.name;
      final enclosingMappingMessage = "Parent mapping holding this is '$sourceParentClass' -> '$targetParentClass'";

      if (target.isNullable) {
        log.warning(
          "Can't find nested mapping '$assignment' but target is nullable. Setting null. ($enclosingMappingMessage).",
        );

        return literalNull;
      }

      throw InvalidGenerationSourceError(
        "Mapping nested object '$assignment' but no mapping is configured. ($enclosingMappingMessage).",
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
  /// using the [onUsedNullableMethodCallback] callback.
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
      onUsedNullableMethodCallback?.call(nestedMapping);
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
