import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mapper/builder/convert_method_builder.dart';
import 'package:auto_mapper/models/dart_type_extension.dart';
import 'package:auto_mapper/models/models.dart';
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
    if (assignment.sourceField == null) {
      if (assignment.fieldMapping != null && assignment.fieldMapping!.canBeApplied(assignment)) {
        return assignment.fieldMapping!.apply(assignment);
      }

      return assignment.getDefaultValue();
    }

    final fieldMapping = assignment.fieldMapping;

    if (fieldMapping != null && fieldMapping.canBeApplied(assignment)) {
      return fieldMapping.apply(assignment);
    }

    //todo support Map and Set
    if (assignment.shouldAssignList()) {
      return _assignListValue(assignment);
    }

    // print(
    //     '${assignment.sourceField!.name} mapping as nested object: $assignNestedObject. DartType isEnum? ${assignment.targetType.isDartCoreEnum}');

    final assignNestedObject = !assignment.targetType.isPrimitiveType;
    if (assignNestedObject) {
      return _assignNestedObject(
        source: assignment.sourceField!.type,
        target: assignment.targetType,
        assignment: assignment,
        convertMethodArg: refer('model').property(assignment.sourceField!.name),
      );
    }

    final x = refer('model').property(assignment.sourceField!.name);

    if (fieldMapping?.hasWhenNullDefault() ?? false) {
      return x.ifNullThen(fieldMapping!.whenNullExpression!);
    }

    return x;
  }

  Expression _assignListValue(SourceAssignment assignment) {
    final sourceType = assignment.sourceField!.type;
    final targetType = assignment.targetType;
    final sourceNullable = sourceType.nullabilitySuffix == NullabilitySuffix.question;
    final targetNullable = assignment.targetNullability == NullabilitySuffix.question;

    final targetListType = (assignment.targetType as ParameterizedType).typeArguments.first;
    final sourceListType = (sourceType as ParameterizedType).typeArguments.first;
    final assignNestedObject = !targetListType.isPrimitiveType && (targetListType != sourceListType);

    final sourceListExpr = refer('model').property(assignment.sourceField!.name);
    final defaultListValueExpr = literalList([], refer(targetListType.getDisplayString(withNullability: true)));

    if (!targetNullable && !sourceNullable) {
      if (assignNestedObject)
        return sourceListExpr
            .property('map')
            .call(
              [_nestedListMapCall(assignment)],
              {},
              [refer(targetListType.getDisplayString(withNullability: true))],
            )
            .property('toList')
            .call([]);

      return refer('model').property(assignment.sourceField!.name);
    }

    if (!targetNullable && sourceNullable) {
      if (assignNestedObject)
        return sourceListExpr
            .nullSafeProperty('map')
            .call(
              [_nestedListMapCall(assignment)],
              {},
              [refer(targetListType.getDisplayString(withNullability: true))],
            )
            .property('toList')
            .call([])
            .ifNullThen(defaultListValueExpr);

      return refer('model').property(assignment.sourceField!.name).ifNullThen(refer('[]'));
    }

    if (targetNullable && !sourceNullable) {
      if (assignNestedObject)
        return sourceListExpr
            .property('map')
            .call(
              [_nestedListMapCall(assignment)],
              {},
              [refer(targetListType.getDisplayString(withNullability: true))],
            )
            .property('toList')
            .call([]);

      return refer('model').property(assignment.sourceField!.name);
    }

    // sourceNullable && targetNullable
    if (assignNestedObject)
      return sourceListExpr
          .nullSafeProperty('map')
          .call(
            [_nestedListMapCall(assignment)],
            {},
            [refer(targetListType.getDisplayString(withNullability: true))],
          )
          .property('toList')
          .call([])
          .ifNullThen(defaultListValueExpr);

    return refer('model').property(assignment.sourceField!.name);
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
        todo: 'Configure mapping from ${sourceName} to ${targetTypeName}',
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

  Expression _nestedListMapCall(
    SourceAssignment assignment,
  ) {
    final targetListType = (assignment.targetType as ParameterizedType).typeArguments.first;
    final sourceListType = (assignment.sourceField!.type as ParameterizedType).typeArguments.first;
    final convertMethodCall = _assignNestedObject(
            assignment: assignment, source: sourceListType, target: targetListType, convertMethodArg: refer('e'))
        .accept(DartEmitter());

    return refer(('(e) => $convertMethodCall'));
  }
}
