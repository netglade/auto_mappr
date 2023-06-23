import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/builder/enum_assignment_builder.dart';
import 'package:auto_mappr/src/builder/value_assignment_builder.dart';
import 'package:auto_mappr/src/extensions/element_extension.dart';
import 'package:auto_mappr/src/extensions/expression_extension.dart';
import 'package:auto_mappr/src/extensions/interface_type_extension.dart';
import 'package:auto_mappr/src/models/models.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';

class MapModelBodyMethodBuilder {
  final AutoMapprConfig mapperConfig;
  final TypeMapping mapping;
  final bool nullable;
  final void Function(TypeMapping? mapping)? usedNullableMethodCallback;

  MapModelBodyMethodBuilder({
    required this.mapperConfig,
    required this.mapping,
    this.usedNullableMethodCallback,
    this.nullable = false,
  });

  Code build() {
    final block = BlockBuilder();

    final sourceFields = _getAllReadableFields(classType: mapping.source);

    // Name of the source field names which can be mapped into constructor field
    final mappedSourceFieldNames = <String>[];

    // Input as local model.
    block.statements.add(declareFinal('model').assign(refer('input')).statement);
    // Add handling of whenSourceIsNull.
    block.statements.add(_whenModelIsNullHandling());

    // Is there an enum involved in the mapping?
    if (mapping.isEnumMapping) {
      final enumBuilder = EnumAssignmentBuilder(mapperConfig: mapperConfig, mapping: mapping);

      final assignment = enumBuilder.build();

      block.statements.add(assignment);

      return block.build();
    }

    // Map fields using a constructor.
    // Returns an constructor call without `;`.
    //
    // One(
    //   usingConstructor1: model.usingConstructor1,
    //   usingConstructor2: model.usingConstructor2,
    // )
    final constructorExpression = _processConstructorMapping(
      mappedSourceFieldNames: mappedSourceFieldNames,
      sourceFields: sourceFields,
    );

    // Map fields not mapped directly in constructor as setters if possible.
    //
    // Code like:
    //
    // <constructorExpression>
    // ..withoutConstructor1 = model.withoutConstructor1
    // ..withoutConstructor2 = model.withoutConstructor2
    // ..withoutConstructor3 = model.withoutConstructor3
    final constructorWithSetters = _mapSetterFields(
      alreadyMapped: mappedSourceFieldNames,
      sourceFields: sourceFields,
      constructorExpression: constructorExpression,
    );

    // Return a constructor call
    // optionally with cascaded setter assignments.
    block.statements.add(constructorWithSetters.returned.statement);

    return block.build();
  }

  void _assertParamFieldCanBeIgnored(ParameterElement param, PropertyAccessorElement sourceField) {
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

  Expression _processConstructorMapping({
    required List<String> mappedSourceFieldNames,
    required Map<String, PropertyAccessorElement> sourceFields,
  }) {
    final mappedTargetConstructorParams = <SourceAssignment>[];
    final notMappedTargetParameters = <SourceAssignment>[];

    final targetConstructor = _findBestConstructor(mapping.target, forcedConstructor: mapping.constructor);

    final targetClassGetters = (mapping.target).getAllGetters();

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
            targetClassGetters.firstWhere((targetField) => targetField.displayName == fieldMapping?.field);

        if (mapping.fieldShouldBeIgnored(targetField.displayName)) {
          _assertParamFieldCanBeIgnored(param, targetField);
        }

        final sourceAssignment = SourceAssignment(
          sourceField: null,
          targetField: targetField,
          targetConstructorParam: constructorAssignment,
          fieldMapping: mapping.tryGetFieldMapping(targetField.displayName),
          typeMapping: mapping,
          config: mapperConfig,
        );

        mappedTargetConstructorParams.add(sourceAssignment);
        mappedSourceFieldNames.add(param.name);
      }
      // Source field has the same name as target parameter or is renamed using [from].
      else if (sourceFields.containsKey(sourceFieldName)) {
        final sourceField = sourceFields[sourceFieldName]!;

        final targetField = from != null
            // support custom field rename mapping
            ? targetClassGetters.firstWhere((field) => field.displayName == fieldMapping?.field)
            // find target field based on matching source field
            : targetClassGetters.firstWhere((field) => field.displayName == sourceField.displayName);

        if (mapping.fieldShouldBeIgnored(targetField.displayName)) {
          _assertParamFieldCanBeIgnored(param, sourceField);
        }

        final sourceAssignment = SourceAssignment(
          sourceField: sourceFields[sourceFieldName],
          targetField: targetField,
          targetConstructorParam: constructorAssignment,
          fieldMapping: mapping.tryGetFieldMapping(targetField.displayName),
          typeMapping: mapping,
          config: mapperConfig,
        );

        mappedTargetConstructorParams.add(sourceAssignment);
        mappedSourceFieldNames.add(param.name);
      } else {
        // If not mapped constructor param is optional - skip it
        if (param.isOptional) continue;

        final targetField =
            (mapping.target).getAllGetters().firstWhereOrNull((field) => field.displayName == param.displayName);

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
            typeMapping: mapping,
            config: mapperConfig,
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
    return _mapConstructor(
      targetConstructor,
      positional: positionalParameters,
      named: namedParameters,
    );
  }

  Expression _mapConstructor(
    ConstructorElement targetConstructor, {
    required List<SourceAssignment> positional,
    required List<SourceAssignment> named,
  }) {
    final alias = targetConstructor.enclosingElement.getLibraryAlias(config: mapperConfig);
    final constructorName = targetConstructor.displayName;

    return refer('$alias$constructorName').newInstance(
      positional.map(
        (assignment) => ValueAssignmentBuilder(
          mapperConfig: mapperConfig,
          mapping: mapping,
          assignment: assignment,
          usedNullableMethodCallback: usedNullableMethodCallback,
        ).build(),
      ),
      {
        for (final assignment in named)
          assignment.targetConstructorParam!.param.name: ValueAssignmentBuilder(
            mapperConfig: mapperConfig,
            mapping: mapping,
            assignment: assignment,
            usedNullableMethodCallback: usedNullableMethodCallback,
          ).build(),
      },
    );
  }

  Expression _mapSetterFields({
    required List<String> alreadyMapped,
    required Map<String, PropertyAccessorElement> sourceFields,
    required Expression constructorExpression,
  }) {
    final targetSetters = mapping.target.getAllSetters();

    final potentialSetterFields = sourceFields.keys.where((field) => !alreadyMapped.contains(field)).toList();
    final fields = potentialSetterFields
        .map((key) => sourceFields[key])
        .whereNotNull()
        // Use only those that match.
        .where((accessor) => targetSetters.any((targetAccessor) => targetAccessor.displayName == accessor.displayName))
        // Skip ignored fields.
        .where((accessor) => !mapping.fieldShouldBeIgnored(accessor.displayName))
        .toList();

    if (fields.isEmpty) {
      return constructorExpression;
    }

    final targetClassGetters = mapping.target.getAllGetters();

    var cascadedAssignments = constructorExpression;
    for (final sourceField in fields) {
      final targetField = targetClassGetters.firstWhere((field) => field.displayName == sourceField.displayName);

      // Assign result.X = model.X
      cascadedAssignments = cascadedAssignments.cascade(sourceField.displayName).assign(
            ValueAssignmentBuilder(
              mapperConfig: mapperConfig,
              mapping: mapping,
              assignment: SourceAssignment(
                sourceField: sourceField,
                targetField: targetField,
                typeMapping: mapping,
                config: mapperConfig,
              ),
              usedNullableMethodCallback: usedNullableMethodCallback,
            ).build(),
          );
    }

    return cascadedAssignments;
  }

  /// Returns all public fields (instance or static) that have a getter.
  Map<String, PropertyAccessorElement> _getAllReadableFields({
    required InterfaceType classType,
  }) {
    final fieldsWithGetter = classType.getAllGetters();

    return {
      for (final field in fieldsWithGetter) field.name: field,
    };
  }

  /// Tries to find best constructor for mapping.
  ///
  /// Returns a constructor with the most parameter count.
  /// Prefer non factory constructors over factory ones.
  ConstructorElement _findBestConstructor(InterfaceType classType, {String? forcedConstructor}) {
    if (forcedConstructor != null) {
      final selectedConstructor = classType.constructors.firstWhereOrNull((c) => c.name == forcedConstructor);
      if (selectedConstructor != null) return selectedConstructor;

      log.warning(
        "Couldn't find constructor '$forcedConstructor', fall-backing to using the most fitted one instead.",
      );
    }

    final allConstructors = classType.constructors.where((c) => !c.isPrivate);

    // Sort constructors by number of parameters, descending.
    int sortConstructors(ConstructorElement a, ConstructorElement b) =>
        -a.parameters.length.compareTo(b.parameters.length);

    final nonFactoryConstructors = allConstructors.where((c) => !c.isFactory).sorted(sortConstructors);
    final factoryConstructors =
        allConstructors.where((c) => c.isFactory && c.name != 'fromJson').sorted(sortConstructors);

    // Prefers non factory constructors over factory ones.
    return [...nonFactoryConstructors, ...factoryConstructors].first;
  }

  Code _whenModelIsNullHandling() {
    final ifConditionExpression = refer('model').equalTo(literalNull);

    if (nullable) {
      final ifBodyExpression = mapping.hasWhenNullDefault() ? mapping.whenSourceIsNullExpression! : literalNull;

      // Generates code like:
      //
      // if (model == null) {
      //   return whenSourceIsNullExpression; // When whenSourceIsNullExpression is set.
      //   return null; // Otherwise.
      // }
      return ifConditionExpression.ifStatement2(ifBody: ifBodyExpression.returned.statement).code;
    }

    final ifBodyExpression = mapping.hasWhenNullDefault()
        ? mapping.whenSourceIsNullExpression!.returned
        : refer('Exception').newInstance([
            refer(
              "r'Mapping $mapping failed because ${mapping.source} was null, and no default value was provided. '\n"
              "r'Consider setting the whenSourceIsNull parameter on the MapType<${mapping.source}, ${mapping.target}> to handle null values during mapping.'",
            ),
          ]).thrown;

    // Generates code like:
    //
    // if (model == null) {
    //   return whenSourceIsNullExpression; // When whenSourceIsNullExpression is set.
    //   throw Exception('Mapping UserDto -> User when null but no default value provided!'); // Otherwise.
    // }
    return ifConditionExpression.ifStatement2(ifBody: ifBodyExpression.statement).code;
  }
}
