import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/builder/convert_method_builder.dart';
import 'package:auto_mappr/models/dart_type_extension.dart';
import 'package:auto_mappr/models/expression_extension.dart';
import 'package:auto_mappr/models/models.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

class ValueAssignmentBuilder {
  final AutoMapperConfig mapperConfig;
  final TypeMapping mapping;
  final SourceAssignment assignment;

  ValueAssignmentBuilder({
    required this.mapperConfig,
    required this.mapping,
    required this.assignment,
  });

  Expression build() {
    final sourceField = assignment.sourceField;

    if (sourceField == null) {
      if (assignment.fieldMapping != null && assignment.fieldMapping!.canBeApplied(assignment)) {
        return assignment.fieldMapping!.apply(assignment);
      }

      return assignment.getDefaultValue();
    }

    final fieldMapping = assignment.fieldMapping;

    if (fieldMapping != null && fieldMapping.canBeApplied(assignment)) {
      return fieldMapping.apply(assignment);
    }

    if (assignment.shouldAssignListLike()) {
      return _assignListLikeValue(assignment);
    }

    if (assignment.shouldAssignMap()) {
      return _assignMapValue(assignment);
    }

    final assignNestedObject = !assignment.targetType.isPrimitiveType;
    if (assignNestedObject) {
      return _assignNestedObject(
        source: sourceField.type,
        target: assignment.targetType,
        assignment: assignment,
        convertMethodArg: refer('model').property(sourceField.name),
      );
    }

    final rightSide =
        refer(sourceField.isStatic ? '${sourceField.enclosingElement.name}' : 'model').property(sourceField.name);

    if (fieldMapping?.hasWhenNullDefault() ?? false) {
      return rightSide.ifNullThen(fieldMapping!.whenNullExpression!);
    }

    return rightSide;
  }

  Expression _assignListLikeValue(SourceAssignment assignment) {
    final sourceType = assignment.sourceField!.type;
    final targetType = assignment.targetType;

    final sourceNullable = sourceType.nullabilitySuffix == NullabilitySuffix.question;
    final targetNullable = targetType.nullabilitySuffix == NullabilitySuffix.question;

    final targetListLikeType = (targetType as ParameterizedType).typeArguments.first;
    final sourceListLikeType = (sourceType as ParameterizedType).typeArguments.first;

    final shouldFilterNullInSource = sourceListLikeType.nullabilitySuffix == NullabilitySuffix.question &&
        targetListLikeType.nullabilitySuffix != NullabilitySuffix.question;
    final assignNestedObject = !targetListLikeType.isPrimitiveType && (targetListLikeType != sourceListLikeType);

    // When [sourceListLikeType] is nullable and [targetListLikeType] is not, remove null values.
    final sourceListLikeExpression = refer('model').property(assignment.sourceField!.name).maybeWhereListLikeNotNull(
          condition: shouldFilterNullInSource,
          isOnNullable: sourceNullable,
        );

    final defaultListLikeValueExpression = targetListLikeType.defaultListLikeExpression();

    if (assignNestedObject) {
      return sourceListLikeExpression
          // Map complex nested types.
          .maybeNullSafeProperty('map', isOnNullable: sourceNullable)
          .call(
            [_nestedMapCallForListLike(assignment)],
            {},
            [refer(targetListLikeType.getDisplayString(withNullability: true))],
          )
          // Call toList, toSet or nothing.
          .maybeToIterableCall(assignment.targetType, isOnNullable: sourceNullable)
          // When [sourceNullable], use default value.
          .maybeIfNullThen(defaultListLikeValueExpression, isOnNullable: sourceNullable);
    }

    return sourceListLikeExpression
        .maybeToIterableCall(
          assignment.targetType,
          isOnNullable: !targetNullable && sourceNullable,
        )
        .maybeIfNullThen(
          defaultListLikeValueExpression,
          isOnNullable: !targetNullable && sourceNullable,
        );
  }

  Expression _assignMapValue(SourceAssignment assignment) {
    final sourceType = assignment.sourceField!.type;
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

    final shouldRemoveNullsKey =
        sourceNullableKey && !targetNullableKey && (!(keyMapping?.hasWhenNullDefault() ?? false));

    final shouldRemoveNullsValue =
        sourceNullableValue && !targetNullableValue && (!(valueMapping?.hasWhenNullDefault() ?? false));

    // Source is null, target is not null, and default value does not exist.
    final shouldRemoveNulls = shouldRemoveNullsKey || shouldRemoveNullsValue;

    final sourceMapExpression = refer('model').property(assignment.sourceField!.name);

    final defaultMapValueExpression = literalMap(
      {},
      refer(targetKeyType.getDisplayString(withNullability: true)),
      refer(targetValueType.getDisplayString(withNullability: true)),
    );

    return sourceMapExpression
        // Filter nulls when source key/value is nullable and target is not.
        .maybeWhereMapNotNull(
          condition: shouldRemoveNulls,
          isOnNullable: sourceNullable,
          keyType: sourceKeyType,
          valueType: sourceValueType,
        )
        // Map map entries.
        .maybeNullSafeProperty('map', isOnNullable: sourceNullable)
        .call(
      [_callMapForMap(assignment)],
      {},
      [
        refer(targetKeyType.getDisplayString(withNullability: true)),
        refer(targetValueType.getDisplayString(withNullability: true)),
      ],
    )
        // When [sourceNullable], use default value.
        .maybeIfNullThen(defaultMapValueExpression, isOnNullable: sourceNullable);
  }

  Expression _assignNestedObject({
    required DartType source,
    required DartType target,
    required SourceAssignment assignment,
    required Expression convertMethodArg,
    bool includeGenericTypes = false,
  }) {
    if (source == target) {
      return refer('model').property(assignment.sourceField!.displayName);
    }

    final nestedMapping = mapperConfig.findMapping(source: source, target: target);
    if (nestedMapping == null) {
      final targetTypeName = target.getDisplayString(withNullability: true);
      final sourceName = assignment.sourceField?.getDisplayString(withNullability: true);

      if (target.nullabilitySuffix == NullabilitySuffix.question) {
        log.warning("Can't find nested mapping '$assignment' but target is nullable. Setting null");

        return refer('null');
      }

      throw InvalidGenerationSourceError(
        'Trying to map nested object from "$assignment" but no mapping is configured.',
        todo: 'Configure mapping from $sourceName to $targetTypeName',
      );
    }

    final convertCallExpr = refer(ConvertMethodBuilder.concreteConvertMethodName(source, target)).call(
      [convertMethodArg],
      {'canReturnNull': refer(target.nullabilitySuffix == NullabilitySuffix.question ? 'true' : 'false')},
      includeGenericTypes
          ? [
              refer(source.getDisplayString(withNullability: true)),
              refer(target.getDisplayString(withNullability: true)),
            ]
          : [],
    ).asA(refer(target.getDisplayString(withNullability: true)));

    // IF source == null and target not nullable -> use whenNullDefault if possible
    final fieldMapping = mapping.tryGetFieldMapping(assignment.targetName);
    if (source.nullabilitySuffix == NullabilitySuffix.question && (fieldMapping?.hasWhenNullDefault() ?? false)) {
      return refer('model').property(assignment.sourceField!.displayName).equalTo(refer('null')).conditional(
            fieldMapping!.whenNullExpression!,
            convertCallExpr,
          );
    }

    return convertCallExpr;
  }

  Expression _nestedMapCallForListLike(SourceAssignment assignment) {
    final targetListType = (assignment.targetType as ParameterizedType).typeArguments.first;
    final sourceListType = (assignment.sourceField!.type as ParameterizedType).typeArguments.first;
    final convertMethodCall = _assignNestedObject(
      assignment: assignment,
      source: sourceListType,
      target: targetListType,
      convertMethodArg: refer('e'),
    ).accept(DartEmitter());

    return refer('(e) => $convertMethodCall');
  }

  Expression _callMapForMap(
    SourceAssignment assignment,
  ) {
    final targetKeyType = (assignment.targetType as ParameterizedType).typeArguments.first;
    final targetValueType = (assignment.targetType as ParameterizedType).typeArguments.last;

    final sourceKeyType = (assignment.sourceField!.type as ParameterizedType).typeArguments.first;
    final sourceValueType = (assignment.sourceField!.type as ParameterizedType).typeArguments.last;

    final assignNestedObjectKey = !targetKeyType.isPrimitiveType && (targetKeyType != sourceKeyType);
    final assignNestedObjectValue = !targetValueType.isPrimitiveType && (targetValueType != sourceValueType);

    final sourceMapExpression = refer('key');
    final targetMapExpression = refer('value');

    final keyExpression = assignNestedObjectKey
        ? _assignNestedObject(
            assignment: assignment,
            source: sourceKeyType,
            target: targetKeyType,
            convertMethodArg: sourceMapExpression,
          )
        : sourceMapExpression;

    final valueExpression = assignNestedObjectValue
        ? _assignNestedObject(
            assignment: assignment,
            source: sourceValueType,
            target: targetValueType,
            convertMethodArg: targetMapExpression,
          )
        : targetMapExpression;

    return refer(
      '(key, value) => MapEntry(${keyExpression.accept(DartEmitter())}, ${valueExpression.accept(DartEmitter())})',
    );
  }
}
