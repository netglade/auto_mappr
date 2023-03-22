import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:auto_mappr/builder/value_assignment_builder.dart';
import 'package:auto_mappr/extensions/expression_extension.dart';
import 'package:auto_mappr/extensions/field_element_extension.dart';
import 'package:auto_mappr/models/models.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';

class MapModelBodyMethodBuilder {
  final AutoMapprConfig mapperConfig;
  final TypeMapping mapping;

  MapModelBodyMethodBuilder({
    required this.mapperConfig,
    required this.mapping,
  });

  Code build() {
    final block = BlockBuilder();

    final sourceClass = mapping.source.element! as ClassElement;
    final targetClass = mapping.target.element! as ClassElement;

    final sourceFields = _getAllReadableFields(sourceClass);
    // Name of the source field names which can be mapped into constructor field

    final mappedSourceFieldNames = <String>[];

    // Input as local model.
    block.statements.add(declareFinal('model').assign(refer('input')).statement);
    // Add handling of whenSourceIsNull.
    block.statements.add(_whenModelIsNullHandling());

    // Map fields using a constructor.
    _processConstructorMapping(
      mappedSourceFieldNames: mappedSourceFieldNames,
      sourceFields: sourceFields,
      targetClass: targetClass,
      block: block,
    );

    // Map fields not mapped directly in constructor as setters if possible.
    _mapSetterFields(
      alreadyMapped: mappedSourceFieldNames,
      sourceFields: sourceFields,
      targetClass: targetClass,
      block: block,
    );

    // Return target.
    block.statements.add(refer('result').returned.statement);

    return block.build();
  }

  void _assertParamFieldCanBeIgnored(ParameterElement param, FieldElement sourceField) {
    final sourceFieldName = sourceField.getDisplayString(withNullability: true);
    if (param.isPositional && param.type.nullabilitySuffix != NullabilitySuffix.question) {
      throw InvalidGenerationSourceError(
        "Can't ignore field '$sourceFieldName' as it is positional not-nullable parameter",
      );
    }

    if (param.isRequiredNamed && param.type.nullabilitySuffix != NullabilitySuffix.question) {
      throw InvalidGenerationSourceError(
        "Can't ignore field '$sourceFieldName' as it is required named not-nullable parameter",
      );
    }
  }

  void _assertNotMappedConstructorParameters(Iterable<ParameterElement> notMapped) {
    for (final param in notMapped) {
      if (param.isPositional && param.type.nullabilitySuffix != NullabilitySuffix.question) {
        throw InvalidGenerationSourceError(
          "Can't generate mapping $mapping as there is non mapped not-nullable positional parameter ${param.displayName}",
        );
      }

      if (param.isRequiredNamed && param.type.nullabilitySuffix != NullabilitySuffix.question) {
        if (param.type.isDartCoreList) return;
        throw InvalidGenerationSourceError(
          "Can't generate mapping $mapping as there is non mapped not-nullable required named parameter ${param.displayName}",
        );
      }
    }
  }

  void _processConstructorMapping({
    required List<String> mappedSourceFieldNames,
    required Map<String, FieldElement> sourceFields,
    required ClassElement targetClass,
    required BlockBuilder block,
  }) {
    final mappedTargetConstructorParams = <SourceAssignment>[];
    final notMappedTargetParameters = <SourceAssignment>[];

    final targetConstructor = _findBestConstructor(targetClass, forcedConstructor: mapping.constructor);

    // Map constructor parameters
    for (var i = 0; i < targetConstructor.parameters.length; i++) {
      final param = targetConstructor.parameters[i];
      final paramPosition = param.isPositional ? i : null;
      final constructorAssignment = ConstructorAssignment(param: param, position: paramPosition);

      final fieldMapping = mapping.tryGetFieldMapping(param.name);

      // Handles renaming.
      final from = fieldMapping?.from;
      final sourceFieldName = from ?? param.name;

      // Custom mapping has precedence.
      if (fieldMapping?.hasCustomMapping() ?? false) {
        final targetField =
            targetClass.fields.firstWhere((targetField) => targetField.displayName == fieldMapping?.field);

        if (mapping.fieldShouldBeIgnored(targetField.displayName)) {
          _assertParamFieldCanBeIgnored(param, targetField);
        }

        final sourceAssignment = SourceAssignment(
          sourceField: null,
          targetField: targetField,
          targetConstructorParam: constructorAssignment,
          fieldMapping: mapping.tryGetFieldMapping(targetField.displayName),
        );

        mappedTargetConstructorParams.add(sourceAssignment);
        mappedSourceFieldNames.add(param.name);
      }
      // Source field has the same name as target parameter or is renamed using [from].
      else if (sourceFields.containsKey(sourceFieldName)) {
        final sourceField = sourceFields[sourceFieldName]!;

        final targetField = from != null
            // support custom field rename mapping
            ? targetClass.fields.firstWhere((targetField) => targetField.displayName == fieldMapping?.field)
            // find target field based on matching source field
            : targetClass.fields.firstWhere((targetField) => targetField.displayName == sourceField.displayName);

        if (mapping.fieldShouldBeIgnored(targetField.displayName)) {
          _assertParamFieldCanBeIgnored(param, sourceField);
        }

        final sourceAssignment = SourceAssignment(
          sourceField: sourceFields[sourceFieldName],
          targetField: targetField,
          targetConstructorParam: constructorAssignment,
          fieldMapping: mapping.tryGetFieldMapping(targetField.displayName),
        );

        mappedTargetConstructorParams.add(sourceAssignment);
        mappedSourceFieldNames.add(param.name);
      } else {
        // If not mapped constructor param is optional - skip it
        if (param.isOptional) continue;

        final targetField =
            targetClass.fields.firstWhereOrNull((targetField) => targetField.displayName == param.displayName);

        final fieldMapping = mapping.tryGetFieldMapping(param.displayName);

        if (targetField == null && fieldMapping == null) {
          throw InvalidGenerationSourceError(
            "Can't find mapping for target's constructor parameter: ${param.displayName}. Parameter is required and no mapping or target's class field not found",
          );
        }

        notMappedTargetParameters.add(
          SourceAssignment(
            sourceField: null,
            targetField: targetField,
            fieldMapping: fieldMapping,
            targetConstructorParam: constructorAssignment,
          ),
        );
      }
    }

    _assertNotMappedConstructorParameters(notMappedTargetParameters.map((e) => e.targetConstructorParam!.param));

    // Prepare and merge mapped and notMapped parameters into Positional and Named arrays
    final mappedPositionalParameters =
        mappedTargetConstructorParams.where((x) => x.targetConstructorParam?.position != null);
    final notMappedPositionalParameters =
        notMappedTargetParameters.where((x) => x.targetConstructorParam?.position != null);

    final positionalParameters = <SourceAssignment>[...mappedPositionalParameters, ...notMappedPositionalParameters]
      ..sortByCompare((x) => x.targetConstructorParam!.position!, (a, b) => a - b);

    final namedParameters = <SourceAssignment>[
      ...mappedTargetConstructorParams.where((x) => x.targetConstructorParam?.isNamed ?? false),
      ...notMappedTargetParameters.where((element) => element.targetConstructorParam?.isNamed ?? false)
    ];

    // Mapped fields into constructor - positional and named
    final constructorCode = _mapConstructor(
      targetConstructor,
      positional: positionalParameters,
      named: namedParameters,
    );
    block.statements.add(constructorCode);
  }

  Code _mapConstructor(
    ConstructorElement targetConstructor, {
    required List<SourceAssignment> positional,
    required List<SourceAssignment> named,
  }) {
    return declareFinal('result')
        .assign(
          refer(targetConstructor.displayName).newInstance(
            positional.map(
              (assignment) => ValueAssignmentBuilder(
                mapperConfig: mapperConfig,
                mapping: mapping,
                assignment: assignment,
              ).build(),
            ),
            {
              for (final assignment in named)
                assignment.targetConstructorParam!.param.name: ValueAssignmentBuilder(
                  mapperConfig: mapperConfig,
                  mapping: mapping,
                  assignment: assignment,
                ).build(),
            },
          ),
        )
        .statement;
  }

  void _mapSetterFields({
    required List<String> alreadyMapped,
    required Map<String, FieldElement> sourceFields,
    required ClassElement targetClass,
    required BlockBuilder block,
  }) {
    final potentialSetterFields = sourceFields.keys.where((field) => !alreadyMapped.contains(field)).toList();
    final fields = potentialSetterFields
        .map((key) => sourceFields[key])
        .whereNotNull()
        .where(
          (field) =>
              targetClass.fields.any((element) => element.displayName == field.displayName && element.isWritable),
        )
        .toList();

    for (final sourceField in fields) {
      final targetField = targetClass.fields.firstWhere((field) => field.displayName == sourceField.displayName);

      // Source.X has ignore:true -> skip
      if (mapping.fieldShouldBeIgnored(sourceField.displayName)) continue;

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

  /// Returns all public fields (instance or static) that have a getter.
  Map<String, FieldElement> _getAllReadableFields(ClassElement classElement) {
    final fieldsWithGetter = classElement.fields.where((field) => field.isReadable);

    return {
      for (final field in fieldsWithGetter) field.name: field,
    };
  }

  /// Tries to find best constructor for mapping -> currently returns constructor with the most parameter count
  ConstructorElement _findBestConstructor(ClassElement element, {String? forcedConstructor}) {
    if (forcedConstructor != null) {
      final selectedConstructor = element.constructors.firstWhereOrNull((c) => c.name == forcedConstructor);
      if (selectedConstructor != null) return selectedConstructor;

      log.warning(
        "Couldn't find constructor '$forcedConstructor', fall-backing to using the most fitted one instead.",
      );
    }

    final constructors = element.constructors.where((c) => !c.isFactory).toList()
      ..sort((a, b) => b.parameters.length - a.parameters.length);

    return constructors.first;
  }

  Code _whenModelIsNullHandling() {
    final ifConditionExpression = refer('model').equalTo(refer('null'));

    final ifBodyExpression = mapping.hasWhenNullDefault()
        ? mapping.whenSourceIsNullExpression!
        : refer('canReturnNull').conditional(
            literalNull,
            refer("throw Exception('Mapping $mapping when null but no default value provided!')"),
          );

    // Generates code like:
    //
    // if (model == null) {
    //   return canReturnNull
    //       ? null
    //       : throw Exception(
    //       'Mapping UserDto -> User when null but no default value provided!');
    // }
    return ifConditionExpression.ifStatement(ifBody: ifBodyExpression.returned.statement).code;
  }
}
