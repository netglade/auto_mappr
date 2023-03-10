import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mapper_generator/models/models.dart';
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
    if (assignment.sourceField == null) return assignment.getDefaultValue();

    if (mapping.hasMapping(assignment.sourceField!.displayName)) {
      final memberMapping = mapping.getMapping(assignment.sourceField!.displayName);

      return memberMapping.apply(assignment);
    }

    //todo support Map and Set
    if (assignment.shouldAssignList()) {
      return _assignListvalue(assignment);
    }

    // TODO Mapping nested object
    final assignNestedObject = !assignment.targetType.isSimpleType;
    if (assignNestedObject) {
      return _assignNestedObject(
        source: assignment.sourceField!.type,
        target: assignment.targetType,
        assignment: assignment,
        convertMethodCall: refer('model').property(assignment.sourceField!.name),
      );
    }

    return refer('model').property(assignment.sourceField!.name);
  }

  //todo tests
  Expression _assignListvalue(SourceAssignment assignment) {
    final sourceNullable = assignment.sourceField!.type.nullabilitySuffix == NullabilitySuffix.question;
    final targetNullable = assignment.targetNullability == NullabilitySuffix.question;

    print('S: $sourceNullable, T: $targetNullable');

    final targetListType = (assignment.targetType as ParameterizedType).typeArguments.first;
    final sourceListType = (assignment.sourceField!.type as ParameterizedType).typeArguments.first;
    final assignNestedObject = !targetListType.isSimpleType && (targetListType != sourceListType);

    if (assignNestedObject) {
      print('Assign nested complext list type');
    }

    final sourceListExpr = refer('model').property(assignment.sourceField!.name);

    if (!targetNullable && !sourceNullable) {
      if (assignNestedObject)
        return sourceListExpr.property('map').call([_nestedListMapCall(assignment)]).property('toList').call([]);

      return refer('model').property(assignment.sourceField!.name);
    }

    if (!targetNullable && sourceNullable) {
      if (assignNestedObject)
        return sourceListExpr
            .nullSafeProperty('map')
            .call([_nestedListMapCall(assignment)])
            .property('toList')
            .call([])
            .ifNullThen(refer('[]'));

      return refer('model').property(assignment.sourceField!.name).ifNullThen(refer('[]'));
    }

    if (targetNullable && !sourceNullable) {
      if (assignNestedObject)
        return sourceListExpr.property('map').call([_nestedListMapCall(assignment)]).property('toList').call([]);

      return refer('model').property(assignment.sourceField!.name);
    }

    // sourceNullable && targetNullable
    if (assignNestedObject)
      return sourceListExpr
          .nullSafeProperty('map')
          .call([_nestedListMapCall(assignment)])
          .property('toList')
          .call([])
          .ifNullThen(refer('[]'));

    return refer('model').property(assignment.sourceField!.name);
  }

  Expression _assignNestedObject({
    required DartType source,
    required DartType target,
    required SourceAssignment assignment,
    required Expression convertMethodCall,
  }) {
    final reverseMapping = mapperConfig.findMapping(source: source, target: target);

    if (reverseMapping == null) {
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

    return refer('convert').call([
      convertMethodCall
    ], {}, [
      refer(source.getDisplayString(withNullability: false)),
      refer(target.getDisplayString(withNullability: false)),
    ]);
  }

  Expression _nestedListMapCall(
    SourceAssignment assignment,
  ) {
    final targetListType = (assignment.targetType as ParameterizedType).typeArguments.first;
    final sourceListType = (assignment.sourceField!.type as ParameterizedType).typeArguments.first;
    final convertMethodCall = _assignNestedObject(
            assignment: assignment, source: sourceListType, target: targetListType, convertMethodCall: refer('e'))
        .accept(DartEmitter());

    return refer(('(e) => $convertMethodCall'));
  }
}
