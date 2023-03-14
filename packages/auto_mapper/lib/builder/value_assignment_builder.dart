import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mapper/models/models.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

class ValueAssignmentBuilder {
  final AutoMapperConfig mapperConfig;
  final AutoMapPart mapping;
  final SourceAssignment assignment;

  ValueAssignmentBuilder({
    required this.mapperConfig,
    required this.mapping,
    required this.assignment,
  });

  Expression build() {
    if (assignment.sourceField == null) {
      if (assignment.memberMapping != null &&
          assignment.memberMapping!.custom != null &&
          assignment.memberMapping!.canBeApplied(assignment)) {
        return assignment.memberMapping!.apply(assignment);
      }

      return assignment.getDefaultValue();
    }

    final memberMapping = assignment.memberMapping;

    if (memberMapping != null && memberMapping.canBeApplied(assignment)) {
      return memberMapping.apply(assignment);
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

    final hasDefaultValue = memberMapping?.whenNullDefault?.referCallString != null;

    // TODO: if whenNullDefault was used and the member is nullable, use nullAware
    final x = refer('model').property(assignment.sourceField!.name);

    if (hasDefaultValue) {
      return x.ifNullThen(refer(memberMapping!.whenNullDefault!.referCallString)).call([]);
    }

    return x;
  }

  //todo tests
  Expression _assignListValue(SourceAssignment assignment) {
    final sourceType = assignment.sourceField!.type;
    final targetType = assignment.targetType;
    final sourceNullable = sourceType.nullabilitySuffix == NullabilitySuffix.question;
    final targetNullable = assignment.targetNullability == NullabilitySuffix.question;

    print('S: $sourceNullable, T: $targetNullable');

    final targetListType = (assignment.targetType as ParameterizedType).typeArguments.first;
    final sourceListType = (sourceType as ParameterizedType).typeArguments.first;
    final assignNestedObject = !targetListType.isPrimitiveType && (targetListType != sourceListType);

    final sourceListExpr = refer('model').property(assignment.sourceField!.name);
    final defaultListValueExpr = refer('<${targetListType.getDisplayString(withNullability: true)}>[]');

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

    final convertCallExpr = refer('_convert').call(
      [convertMethodArg],
      {'canReturnNull': refer(target.nullabilitySuffix == NullabilitySuffix.question ? 'true' : 'false')},
      includeGenericTypes
          ? [
              refer(source.getDisplayString(withNullability: true)),
              refer(target.getDisplayString(withNullability: true)),
            ]
          : [],
    );

    // IF source == null and target not nullable -> use whenNullDefault if possible
    final memberMapping = mapping.tryGetMapping(assignment.targetName);
    if (source.nullabilitySuffix == NullabilitySuffix.question && memberMapping?.whenNullDefault != null) {
      return refer('model').property(assignment.sourceField!.displayName).equalTo(refer('null')).conditional(
            refer(memberMapping!.whenNullDefault!.referCallString).call([]),
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
