import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/builder/convert_method_builder.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:auto_mappr/src/models/models.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

class ValueAssignmentBuilder {
  final AutoMapprConfig mapperConfig;
  final TypeMapping mapping;
  final SourceAssignment assignment;
  final void Function(TypeMapping? mapping)? usedNullableMethodCallback;

  ValueAssignmentBuilder({
    required this.mapperConfig,
    required this.mapping,
    required this.assignment,
    required this.usedNullableMethodCallback,
  });

  Expression build() {
    final sourceField = assignment.sourceField;

    final fieldMapping = assignment.fieldMapping;

    if (sourceField == null) {
      if (fieldMapping != null && fieldMapping.canBeApplied(assignment)) {
        return fieldMapping.apply(assignment);
      }

      return assignment.getDefaultValue();
    }

    if (fieldMapping != null && fieldMapping.canBeApplied(assignment)) {
      return fieldMapping.apply(assignment);
    }

    if (assignment.shouldAssignIterable()) {
      return _assignIterableValue(assignment);
    }

    if (assignment.shouldAssignMap()) {
      return _assignMapValue(assignment);
    }

    final rightSide =
        refer(sourceField.isStatic ? '${sourceField.enclosingElement.name}' : 'model').property(sourceField.name);

      return _assignNestedObject(
        source: assignment.sourceType!,
        target: assignment.targetType,
        assignment: assignment,
        convertMethodArgument: rightSide,
      );
  }

  Expression _assignIterableValue(SourceAssignment assignment) {
    final sourceType = assignment.sourceType!;
    final targetType = assignment.targetType;

    final sourceNullable = sourceType.nullabilitySuffix == NullabilitySuffix.question;
    final targetNullable = targetType.nullabilitySuffix == NullabilitySuffix.question;

    final sourceIterableType = (sourceType as ParameterizedType).typeArguments.first;
    final targetIterableType = (targetType as ParameterizedType).typeArguments.first;

    final shouldFilterNullInSource = sourceIterableType.nullabilitySuffix == NullabilitySuffix.question &&
        targetIterableType.nullabilitySuffix != NullabilitySuffix.question;

    final assignNestedObject = !targetIterableType.isPrimitiveType && (!targetIterableType.isAssignableTo(sourceIterableType));

    // When [sourceIterableType] is nullable and [targetIterableType] is not, remove null values.
    final sourceIterableExpression = refer('model').property(assignment.sourceField!.name).maybeWhereIterableNotNull(
          condition: shouldFilterNullInSource,
          isOnNullable: sourceNullable,
        );

    final defaultIterableValueExpression = targetType.defaultIterableExpression(config: mapperConfig);

    if (assignNestedObject) {
      return sourceIterableExpression
          // Map complex nested types.
          .maybeNullSafeProperty('map', isOnNullable: sourceNullable)
          .call(
            [_nestedMapCallForIterable(assignment)],
            {},
            [
              refer(
                targetIterableType.getDisplayStringWithLibraryAlias(
                  withNullability: true,
                  config: mapperConfig,
                ),
              )
            ],
          )
          // Call toList, toSet or nothing.
          // isOnNullable is false, because if map() was called, the value is non-null
          .maybeToIterableCall(
            source: sourceType,
            target: targetType,
            forceCast: true, //map was used so we want force toIterable() call
            isOnNullable: false,
          )
          // When [sourceNullable], use default value.
          .maybeIfNullThen(defaultIterableValueExpression, isOnNullable: sourceNullable && !targetNullable);
    }

    return sourceIterableExpression
        .maybeToIterableCall(
          source: sourceType,
          target: targetType,
          forceCast: shouldFilterNullInSource, // if whereNotNull was used -> we want to force toIterable() call
          isOnNullable: !targetNullable && sourceNullable,
        )
        .maybeIfNullThen(
          defaultIterableValueExpression,
          isOnNullable: !targetNullable && sourceNullable,
        );
  }

  Expression _assignMapValue(SourceAssignment assignment) {
    final sourceType = assignment.sourceType!;
    final targetType = assignment.targetType;

    final sourceNullable = sourceType.nullabilitySuffix == NullabilitySuffix.question;

    final sourceKeyType = (sourceType as ParameterizedType).typeArguments.first;
    final sourceValueType = sourceType.typeArguments.last;

    final targetKeyType = (targetType as ParameterizedType).typeArguments.first;
    final targetValueType = targetType.typeArguments.last;

    final sourceNullableKey = sourceKeyType.nullabilitySuffix == NullabilitySuffix.question;
    final sourceNullableValue = sourceValueType.nullabilitySuffix == NullabilitySuffix.question;
    final targetNullableKey = targetKeyType.nullabilitySuffix == NullabilitySuffix.question;
    final targetNullableValue = targetValueType.nullabilitySuffix == NullabilitySuffix.question;

    final keyMapping = mapperConfig.findMapping(source: sourceKeyType, target: targetKeyType);
    final valueMapping = mapperConfig.findMapping(source: sourceValueType, target: targetValueType);

    // Keys: source is null, target is not null, and default value does not exist.
    final shouldRemoveNullsKey =
        sourceNullableKey && !targetNullableKey && (!(keyMapping?.hasWhenNullDefault() ?? false));

    // Value: source is null, target is not null, and default value does not exist.
    final shouldRemoveNullsValue =
        sourceNullableValue && !targetNullableValue && (!(valueMapping?.hasWhenNullDefault() ?? false));

    final sourceMapExpression = refer('model').property(assignment.sourceField!.name);

    final defaultMapValueExpression = literalMap(
      {},
      refer(targetKeyType.getDisplayStringWithLibraryAlias(withNullability: true, config: mapperConfig)),
      refer(targetValueType.getDisplayStringWithLibraryAlias(withNullability: true, config: mapperConfig)),
    );

    final assignNestedObjectKey = !targetKeyType.isPrimitiveType && (targetKeyType != sourceKeyType);
    final assignNestedObjectValue = !targetValueType.isPrimitiveType && (targetValueType != sourceValueType);

    final shouldDoMapCall = assignNestedObjectKey || assignNestedObjectValue;

    return sourceMapExpression
        // Filter nulls when source key/value is nullable and target is not.
        .maybeWhereMapNotNull(
      isOnNullable: sourceNullable,
      keyIsNullable: shouldRemoveNullsKey,
      valueIsNullable: shouldRemoveNullsValue,
      keyType: sourceKeyType,
      valueType: sourceValueType,
      config: mapperConfig,
    )
        .maybeCall(
      'map',
      isOnNullable: sourceNullable,
      // Call map only when actually some mapping is required.
      condition: shouldDoMapCall,
      positionalArguments: [
        _callMapForMap(assignment),
      ],
      typeArguments: [
        refer(targetKeyType.getDisplayStringWithLibraryAlias(withNullability: true, config: mapperConfig)),
        refer(targetValueType.getDisplayStringWithLibraryAlias(withNullability: true, config: mapperConfig)),
      ],
    )
        // When [sourceNullable], use default value.
        .maybeIfNullThen(defaultMapValueExpression, isOnNullable: sourceNullable);
  }

  /// Assigns nested object as either:
  /// - default value
  /// - call to already generated mapping between two types
  ///
  /// If [convertMethodArgument] is null, uses a tear off call instead.
  Expression _assignNestedObject({
    required DartType source,
    required DartType target,
    required SourceAssignment assignment,
    Expression? convertMethodArgument,
    bool includeGenericTypes = false,
  }) {
    if (source.isAssignableTo(target)) {
      final expression = convertMethodArgument ?? refer('model').property(assignment.sourceField!.displayName);

      if(assignment.fieldMapping?.hasWhenNullDefault() ?? false) {
        return expression.ifNullThen(assignment.fieldMapping!.whenNullExpression!);
      }

      return expression;
    }

    final nestedMapping = mapperConfig.findMapping(
      source: source,
      target: target,
    );

    if (nestedMapping == null) {
      final targetTypeName = target.getDisplayStringWithLibraryAlias(
        withNullability: true,
        config: mapperConfig,
      );

      if (assignment.hasTypeConversion()) {
        return assignment.getTypeConversion().apply(assignment);
      }

      if(mapperConfig.hasTypeConversion(assignment)) {
        return mapperConfig.getTypeConversion(assignment).apply(assignment);
      }

      if (target.nullabilitySuffix == NullabilitySuffix.question) {
        log.warning("Can't find nested mapping '$assignment' but target is nullable. Setting null");

        return literalNull;
      }

      final sourceName = assignment.sourceField?.getDisplayString(withNullability: true);
      throw InvalidGenerationSourceError(
        'Trying to map nested object from "$assignment" but no mapping is configured.',
        todo: 'Configure mapping from $sourceName to $targetTypeName',
      );
    }

    final convertCallExpression = _mappingCall(
      nestedMapping: nestedMapping,
      source: source,
      target: target,
      convertMethodArgument: convertMethodArgument,
      includeGenericTypes: includeGenericTypes,
    );

    // If source == null and target not nullable -> use whenNullDefault if possible
    final fieldMapping = mapping.tryGetFieldMapping(assignment.targetName);
    if (source.nullabilitySuffix == NullabilitySuffix.question && (fieldMapping?.hasWhenNullDefault() ?? false)) {
      // Generates code like:
      //
      // model.name == null
      //     ? const Nested(
      //         id: 123,
      //         name: 'test',
      //       )
      //     : _map_NestedDto_To_Nested(model.name),
      return refer('model').property(assignment.sourceField!.displayName).equalTo(literalNull).conditional(
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
  Expression _mappingCall({
    required DartType source,
    required DartType target,
    required TypeMapping nestedMapping,
    Expression? convertMethodArgument,
    bool includeGenericTypes = false,
  }) {
    final targetNullable = target.nullabilitySuffix == NullabilitySuffix.question;

    final useNullableMethod = targetNullable && !mapping.hasWhenNullDefault();

    // When target is nullable, use nullable convert method.
    // But use non-nullable when the mapping has default value.
    //
    // Otherwise use non-nullable.
    final convertMethod = refer(
      useNullableMethod
          ? ConvertMethodBuilder.concreteNullableConvertMethodName(
              source: source,
              target: target,
              config: mapperConfig,
            )
          : ConvertMethodBuilder.concreteConvertMethodName(
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
                    refer(source.getDisplayStringWithLibraryAlias(withNullability: true, config: mapperConfig)),
                    refer(target.getDisplayStringWithLibraryAlias(withNullability: true, config: mapperConfig))
                  ]
                : [],
          );
  }

  Expression _nestedMapCallForIterable(SourceAssignment assignment) {
    final targetListType = (assignment.targetType as ParameterizedType).typeArguments.first;
    final sourceListType = (assignment.sourceType! as ParameterizedType).typeArguments.first;

    return _assignNestedObject(
      assignment: assignment,
      source: sourceListType,
      target: targetListType,
    );
  }

  Expression _callMapForMap(
    SourceAssignment assignment,
  ) {
    final sourceKeyType = (assignment.sourceType! as ParameterizedType).typeArguments.first;
    final sourceValueType = (assignment.sourceType! as ParameterizedType).typeArguments.last;
    final targetKeyType = (assignment.targetType as ParameterizedType).typeArguments.first;
    final targetValueType = (assignment.targetType as ParameterizedType).typeArguments.last;

    final assignNestedObjectKey = !targetKeyType.isPrimitiveType && (targetKeyType != sourceKeyType);
    final assignNestedObjectValue = !targetValueType.isPrimitiveType && (targetValueType != sourceValueType);

    final keysAreSameType = sourceKeyType == targetKeyType;
    final valuesAreSameType = sourceValueType == targetValueType;

    // Returns a tear off when no nested call is needed.
    if (!assignNestedObjectKey && !assignNestedObjectValue) {
      return refer('MapEntry.new');
    }

    final sourceMapExpression = refer('key');
    final targetMapExpression = refer('value');

    final keyExpression = assignNestedObjectKey
        ? _assignNestedObject(
            assignment: assignment,
            source: sourceKeyType,
            target: targetKeyType,
            convertMethodArgument: keysAreSameType ? null : sourceMapExpression,
          )
        : sourceMapExpression;

    final valueExpression = assignNestedObjectValue
        ? _assignNestedObject(
            assignment: assignment,
            source: sourceValueType,
            target: targetValueType,
            convertMethodArgument: valuesAreSameType ? null : targetMapExpression,
          )
        : targetMapExpression;

    return refer(
      '(key, value) => MapEntry(${keyExpression.accept(DartEmitter())}, ${valueExpression.accept(DartEmitter())})',
    );
  }
}
