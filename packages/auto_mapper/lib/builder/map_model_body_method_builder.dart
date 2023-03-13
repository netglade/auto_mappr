import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:auto_mapper/builder/value_assignment_builder.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';

import '../models/models.dart';

/*
* Map positional fields
* Map named fields
* Map setters
* Support mapping List
*   - Support mapping Map(?)
* Null safety

* Nested mapping (recursive convert<I,R> call)

    - Implicit = even when not defined as top mapping it should try recursively map it ?
        - FOR NOW THIS WILL BE COMPLICATED
    
    - Explicit = use canConvert and convert<I,R> call
  */
class MapModelBodyMethodBuilder {
  final AutoMapperConfig mapperConfig;
  final AutoMapPart mapping;

  MapModelBodyMethodBuilder({
    required this.mapperConfig,
    required this.mapping,
  });

  Code build() {
    final block = BlockBuilder();

    final targetClass = mapping.target.element as ClassElement;
    final sourceClass = mapping.source.element as ClassElement;

    final targetConstructor = _findBestConstructor(targetClass);

    // local model = input variable
    block.statements.add(declareFinal('model').assign(refer('input')).statement);
    block.statements.add(_checkNullExpr());

    final sourceFields = _getSourceFields(sourceClass);
    final mappedTargetConstructorParams = <SourceAssignment>[];
    final notMappedTargetParameters = <SourceAssignment>[];

    // Name of the source field names which can be mapped into constructor field
    final mappedSourceFieldNames = <String>[];

    // Map constructor parameters
    for (var i = 0; i < targetConstructor.parameters.length; i++) {
      final param = targetConstructor.parameters[i];
      final paramPosition = param.isPositional ? i : null;
      final constructorAssignment = ConstructorAssignment(param: param, position: paramPosition);

      final memberMapping = mapping.tryGetMapping(param.name);
      final rename = memberMapping?.rename;

      final sourceFieldName = rename ?? param.name;
      if (sourceFields.containsKey(sourceFieldName)) {
        final sourceField = sourceFields[sourceFieldName]!;

        final targetField = rename != null
            // support custom member rename mapping
            ? targetClass.fields.firstWhere((element) => element.displayName == memberMapping!.member)

            // find target field based on matching source field
            : targetClass.fields.firstWhere((targetField) => targetField.displayName == sourceField.displayName);

        if (mapping.memberShouldBeIgnored(targetField.displayName)) {
          _assertParamMemberCanBeIgnored(param, sourceField);
        }

        final sourceAssignment = SourceAssignment(
          sourceField: sourceFields[sourceFieldName]!,
          targetField: targetField,
          targetConstructorParam: constructorAssignment,
          memberMapping: mapping.tryGetMapping(targetField.displayName),
        );

        mappedTargetConstructorParams.add(sourceAssignment);
        mappedSourceFieldNames.add(param.name);
      } else {
        print("NOT FOUND $param");
        // If not mapped constructor param is optional - skip it
        if (param.isOptional) continue;

        final targetField =
            targetClass.fields.firstWhereOrNull((targetField) => targetField.displayName == param.displayName);

        final memberMapping = mapping.tryGetMapping(param.displayName);

        if (targetField == null && memberMapping == null) {
          throw InvalidGenerationSourceError(
              "Can't find mapping for target's constructor parameter: ${param.displayName}. Parameter is required and no mapping or target's class field not found");
        }

        notMappedTargetParameters.add(
          SourceAssignment(
            sourceField: null,
            targetField: targetField,
            memberMapping: memberMapping,
            targetConstructorParam: constructorAssignment,
          ),
        );
      }
    }

    _assertNotMappedConstructorParameters(notMappedTargetParameters);

    // Prepare and merge mapped and notMapped parameters into Positional and Named arrays
    final mappedPositionalParameters =
        mappedTargetConstructorParams.where((x) => x.targetConstructorParam?.position != null);
    final notMappedPositionalParameters =
        notMappedTargetParameters.where((x) => x.targetConstructorParam?.position != null);

    final positionalParameters = <SourceAssignment>[...mappedPositionalParameters, ...notMappedPositionalParameters];
    positionalParameters.sortByCompare((x) => x.targetConstructorParam!.position!, (a, b) => a - b);

    final namedParameters = <SourceAssignment>[
      ...mappedTargetConstructorParams.where((x) => x.targetConstructorParam?.isNamed ?? false),
      ...notMappedTargetParameters.where((element) => element.targetConstructorParam?.isNamed ?? false)
    ];

    // Mapped fields into constructor - positional and named
    final constructorExpr = _mapConstructor(
      targetConstructor,
      positional: positionalParameters,
      named: namedParameters,
    );
    block.statements.add(constructorExpr);

    // Not mapped directly in constructor
    _mapSetterFields(mappedSourceFieldNames, sourceFields, targetClass, block);

    block.statements.add(refer('result').returned.statement);

    return block.build();
  }

  void _assertParamMemberCanBeIgnored(ParameterElement param, FieldElement sourceField) {
    final sourceFieldName = sourceField.getDisplayString(withNullability: true);
    if (param.isPositional && param.type.nullabilitySuffix != NullabilitySuffix.question) {
      throw InvalidGenerationSourceError(
          "Can't ignore member '${sourceFieldName}' as it is positional not-nullable parameter");
    }

    if (param.isRequiredNamed && param.type.nullabilitySuffix != NullabilitySuffix.question) {
      throw InvalidGenerationSourceError(
          "Can't ignore member '${sourceFieldName}' as it is required named not-nullable parameter");
    }
  }

  void _assertNotMappedConstructorParameters(List<SourceAssignment> notMappedParameters) {
    final notMapped = notMappedParameters.map((e) => e.targetConstructorParam!.param);

    for (var param in notMapped) {
      if (param.isPositional && param.type.nullabilitySuffix != NullabilitySuffix.question) {
        throw InvalidGenerationSourceError(
          "Can't generate mapping ${mapping.toString()} as there is non mapped not-nullable positional parameter ${param.displayName}",
        );
      }

      if (param.isRequiredNamed && param.type.nullabilitySuffix != NullabilitySuffix.question) {
        if (param.type.isDartCoreList) return;
        throw InvalidGenerationSourceError(
          "Can't generate mapping ${mapping.toString()} as there is non mapped not-nullable required named parameter ${param.displayName}",
        );
      }
    }
  }

  void _mapSetterFields(
    List<String> alreadyMapped,
    Map<String, FieldElement> sourceFields,
    ClassElement targetClass,
    BlockBuilder block,
  ) {
    bool filterField(FieldElement field) =>
        targetClass.fields.any((element) => element.displayName == field.displayName);

    final potentialSetterFields = sourceFields.keys.where((field) => !alreadyMapped.contains(field)).toList();
    final fields =
        potentialSetterFields.where((key) => filterField(sourceFields[key]!)).map((e) => sourceFields[e]!).toList();

    for (final sourceField in fields) {
      final targetField = targetClass.fields.firstWhere((field) => field.displayName == sourceField.displayName);

      // Source.X has ignore:true -> skip
      if (mapping.memberShouldBeIgnored(sourceField.displayName)) continue;

      // assign result.X = model.X
      final expr = refer('result').property(sourceField.displayName).assign(
            ValueAssignmentBuilder(
              mapperConfig: mapperConfig,
              mapping: mapping,
              assignment: SourceAssignment(
                sourceField: sourceField,
                targetField: targetField,
              ),
            ).build(),
          );

      block.statements.add(expr.statement);
    }
  }

  Code _mapConstructor(ConstructorElement targetConstructor,
      {required List<SourceAssignment> positional, required List<SourceAssignment> named}) {
    return declareFinal('result')
        .assign(refer(targetConstructor.displayName).newInstance(
          positional.map((assignment) =>
              ValueAssignmentBuilder(mapperConfig: mapperConfig, mapping: mapping, assignment: assignment).build()),
          {
            for (final assignment in named)
              assignment.targetConstructorParam!.param.name:
                  ValueAssignmentBuilder(mapperConfig: mapperConfig, mapping: mapping, assignment: assignment).build(),
          },
        ))
        .statement;
  }

  Map<String, FieldElement> _getSourceFields(ClassElement sourceClass) {
    fieldFilter(FieldElement field) => !field.isSynthetic;

    return {
      for (final field in sourceClass.fields.where(fieldFilter)) field.name: field,
    };
  }

  /// Tries to find best constructor for mapping -> currently returns constructor with the most parameter count
  ConstructorElement _findBestConstructor(ClassElement element) {
    final constructors = element.constructors.where((c) => !c.isFactory).toList();

    constructors.sort(((a, b) => b.parameters.length - a.parameters.length));

    return constructors.first;
  }

  Code _checkNullExpr() {
    // if (model == null)
    final ifConditionExp = refer('model').equalTo(refer('null')).accept(DartEmitter());
    // Eg. when static class is used => Static.mapFrom()
    if (mapping.whenNullDefault != null) {
      // return whenNullDefault value
      final _target = mapping.whenNullDefault!;
      final callRefer = _target.referCallString;
      final defaultValueCall = refer(callRefer).call([]).statement.accept(DartEmitter());

      return Code('if ($ifConditionExp) return $defaultValueCall');
    } else {
      // otherwise throw exception

      return Code(
          "if ($ifConditionExp) { return canReturnNull ? null : throw Exception('Mapping $mapping when null but no default value provided!');}");
    }
  }
}
