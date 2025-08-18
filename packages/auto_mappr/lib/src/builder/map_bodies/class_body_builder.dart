import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/builder/map_bodies/map_body_builder_base.dart';
import 'package:auto_mappr/src/builder/value_assignment_builder.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:auto_mappr/src/extensions/interface_type_extension.dart';
import 'package:auto_mappr/src/helpers/emitter_helper.dart';
import 'package:auto_mappr/src/models/source_assignment.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart' show Code, Expression;
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';

class ClassBodyBuilder extends MapBodyBuilderBase {
  const ClassBodyBuilder({
    required super.mapperConfig,
    required super.mapping,
    required super.onUsedNullableMethodCallback,
  });

  @override
  Code build() {
    final sourceFields = _getAllReadableFields(classType: mapping.source);

    // Name of the source field names which can be mapped into constructor field
    final mappedSourceFieldNames = <String>[];

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

    return constructorWithSetters.returned.statement;
  }

  @override
  bool canProcess() {
    return !mapping.isEnumMapping;
  }

  /// Returns all public fields (instance or static) that have a getter.
  Map<String, PropertyAccessorElement2> _getAllReadableFields({
    required InterfaceType classType,
  }) {
    final fieldsWithGetter = classType.getAllGetters();

    // Preserve only the *first* occurrence of a field with the same name.
    // This ensures we always keep the most specific (subclass) getter,
    // instead of overwriting it with a version coming from a superclass.
    final result = <String, PropertyAccessorElement2>{};
    for (final field in fieldsWithGetter) {
      // ignore: avoid-non-null-assertion, has name
      final name = field.name3!;
      if (!result.containsKey(name)) {
        result[name] = field;
      }
    }

    return result;
  }

  Expression _processConstructorMapping({
    required List<String> mappedSourceFieldNames,
    required Map<String, PropertyAccessorElement2> sourceFields,
  }) {
    final mappedTargetConstructorParams = <SourceAssignment>[];
    final notMappedTargetParameters = <SourceAssignment>[];

    final targetConstructor = _findBestConstructor(mapping.target, forcedConstructor: mapping.constructor);

    if (targetConstructor == null) {
      throw InvalidGenerationSourceError(
        'There is no target constructor in ${mapping.target}. ($mapping)',
      );
    }

    final targetClassGetters = mapping.target.getAllGetters();

    // Map constructor parameters
    for (var i = 0; i < targetConstructor.formalParameters.length; i++) {
      final param = targetConstructor.formalParameters.elementAtOrNull(i);

      if (param == null) continue;

      final paramPosition = param.isPositional ? i : null;
      final constructorAssignment = ConstructorAssignment(param: param, position: paramPosition);
      final constructorParamCorrespondsWithClassField =
          targetClassGetters.any((field) => field.displayName == param.displayName);

      // ignore: avoid-non-null-assertion, must not be empty
      final fieldMapping = mapping.tryGetFieldMapping(param.name3!);

      // Handles renaming.
      final from = fieldMapping?.from;
      final sourceFieldName = from ?? param.name3;

      // Custom mapping has precedence.
      if (fieldMapping?.hasCustomMapping() ?? false) {
        final targetField = targetClassGetters.firstWhereOrNull((f) => f.displayName == fieldMapping?.field);

        if (!constructorParamCorrespondsWithClassField && param.displayName == fieldMapping?.field) {
          final sourceAssignment = SourceAssignment(
            sourceField: sourceFields[sourceFieldName],
            targetField: null,
            targetConstructorParam: constructorAssignment,
            fieldMapping: fieldMapping,
            typeConverters: mapping.typeConverters,
          );

          mappedTargetConstructorParams.add(sourceAssignment);
          // ignore: avoid-non-null-assertion, must not be empty
          mappedSourceFieldNames.add(param.name3!);

          continue;
        }

        if (targetField == null) {
          continue;
        }

        if (mapping.fieldShouldBeIgnored(targetField.displayName)) {
          _assertParamFieldCanBeIgnored(param, targetField);
        }

        final sourceAssignment = SourceAssignment(
          sourceField: null,
          targetField: targetField,
          targetConstructorParam: constructorAssignment,
          fieldMapping: fieldMapping,
          typeConverters: mapping.typeConverters,
        );

        mappedTargetConstructorParams.add(sourceAssignment);
        // ignore: avoid-non-null-assertion, must not be empty
        mappedSourceFieldNames.add(param.name3!);
      }
      // Source field has the same name as target parameter or is renamed using [from].
      else if (sourceFields.containsKey(sourceFieldName)) {
        final sourceField = sourceFields[sourceFieldName]!;

        if (!constructorParamCorrespondsWithClassField && param.displayName == fieldMapping?.field) {
          final sourceAssignment = SourceAssignment(
            sourceField: sourceFields[sourceFieldName],
            targetField: null,
            targetConstructorParam: constructorAssignment,
            fieldMapping: fieldMapping,
            typeConverters: mapping.typeConverters,
          );

          mappedTargetConstructorParams.add(sourceAssignment);
          // ignore: avoid-non-null-assertion, must not be empty
          mappedSourceFieldNames.add(param.name3!);

          continue;
        }

        final targetField = from == null
            // find target field based on matching source field
            ? targetClassGetters.firstWhereOrNull((field) => field.displayName == sourceField.displayName)
            // support custom field rename mapping
            : targetClassGetters.firstWhereOrNull((field) => field.displayName == fieldMapping?.field);

        if (targetField == null) continue;

        if (mapping.fieldShouldBeIgnored(targetField.displayName)) {
          _assertParamFieldCanBeIgnored(param, sourceField);
        }

        final sourceAssignment = SourceAssignment(
          sourceField: sourceFields[sourceFieldName],
          targetField: targetField,
          targetConstructorParam: constructorAssignment,
          fieldMapping: fieldMapping,
          typeConverters: mapping.typeConverters,
        );

        mappedTargetConstructorParams.add(sourceAssignment);
        // ignore: avoid-non-null-assertion, must not be empty
        mappedSourceFieldNames.add(param.name3!);
      } else {
        // If not mapped constructor param is optional - skip it
        if (param.isOptional) continue;

        final targetField = targetClassGetters.firstWhereOrNull((field) => field.displayName == param.displayName);

        if (targetField == null && fieldMapping == null) {
          throw InvalidGenerationSourceError(
            "Can't find mapping for target's constructor parameter: ${param.displayName}. Parameter is required and no mapping or target's class field not found. ($mapping)",
          );
        }

        notMappedTargetParameters.add(
          SourceAssignment(
            sourceField: null,
            targetField: targetField,
            fieldMapping: fieldMapping,
            targetConstructorParam: constructorAssignment,
            typeConverters: mapping.typeConverters,
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
      ...notMappedTargetParameters.where((element) => element.targetConstructorParam?.isNamed ?? false),
    ];

    // Mapped fields into constructor - positional and named
    return _mapConstructor(
      targetConstructor,
      positional: positionalParameters,
      named: namedParameters,
    );
  }

  void _assertParamFieldCanBeIgnored(FormalParameterElement param, PropertyAccessorElement2 sourceField) {
    final sourceFieldName = sourceField.displayString2();
    if (param.isPositional && param.type.isNotNullable) {
      throw InvalidGenerationSourceError(
        "Can't ignore field '$sourceFieldName' as it is positional not-nullable parameter. ($mapping)",
      );
    }

    if (param.isRequiredNamed && param.type.isNotNullable) {
      throw InvalidGenerationSourceError(
        "Can't ignore field '$sourceFieldName' as it is required named not-nullable parameter. ($mapping)",
      );
    }
  }

  Expression _mapSetterFields({
    required List<String> alreadyMapped,
    required Map<String, PropertyAccessorElement2> sourceFields,
    required Expression constructorExpression,
  }) {
    final targetSetters = mapping.target.getAllSetters();

    // Select only those who has not been mapped yet.
    final potentialSetterFields = sourceFields.keys.where((field) {
      final fieldMapping = mapping.tryGetFieldMappingFromFrom(field);
      final from = fieldMapping?.field;

      // If the field has a rename, check that.
      if (from != null) {
        return !alreadyMapped.contains(from);
      }

      // Or check it direclty.
      return !alreadyMapped.contains(field);
    }).toList();

    final notMappedSourceFields = potentialSetterFields
        .map((sourceKey) => sourceFields[sourceKey])
        .nonNulls
        // Use only those that match.
        .where((accessor) {
          // ignore: avoid-non-null-assertion, must not be empty
          final fieldMapping = mapping.tryGetFieldMappingFromFrom(accessor.name3!);
          final from = fieldMapping?.field;

          return
              // Contains rename.
              from != null ||
                  // Or matches directly.
                  targetSetters.any((targetAccessor) => targetAccessor.displayName == accessor.displayName);
        })
        // Skip ignored fields.
        .where((accessor) => !mapping.fieldShouldBeIgnored(accessor.displayName))
        .toList();

    if (notMappedSourceFields.isEmpty) {
      return constructorExpression;
    }

    final targetClassGetters = mapping.target.getAllGetters();

    var cascadedAssignments = constructorExpression;

    for (final sourceField in notMappedSourceFields) {
      // Is there a rename?
      // ignore: avoid-non-null-assertion, must not be empty
      final fieldMapping = mapping.tryGetFieldMappingFromFrom(sourceField.name3!);
      final from = fieldMapping?.field;

      // Rename or original field name.
      // ignore: avoid-non-null-assertion, must not be empty
      final sourceFieldName = from ?? sourceField.name3!;
      final targetField = targetClassGetters.firstWhereOrNull((field) => field.displayName == sourceFieldName);

      // final targetField = targetClassSetters.firstWhereOrNull((field) => field.displayName == sourceField.displayName);
      if (targetField == null) continue;

      // Assign result.X = model.X
      cascadedAssignments = cascadedAssignments.cascade(sourceFieldName).assign(
            ValueAssignmentBuilder(
              mapperConfig: mapperConfig,
              mapping: mapping,
              assignment: SourceAssignment(
                sourceField: sourceField,
                targetField: targetField,
                typeConverters: mapping.typeConverters,
              ),
              onUsedNullableMethodCallback: onUsedNullableMethodCallback,
            ).build(),
          );
    }

    return cascadedAssignments;
  }

  /// Tries to find best constructor for mapping.
  ///
  /// Returns a constructor with the most parameter count.
  /// Prefer non factory constructors over factory ones.
  ConstructorElement2? _findBestConstructor(InterfaceType classType, {String? forcedConstructor}) {
    if (forcedConstructor != null) {
      final selectedConstructor = classType.constructors2.firstWhereOrNull((c) => c.name3 == forcedConstructor);
      if (selectedConstructor != null) return selectedConstructor;

      log.warning(
        "Couldn't find constructor '$forcedConstructor', fall-backing to using the most fitted one instead. ($mapping)",
      );
    }

    final allConstructors = classType.constructors2.where((c) => !c.isPrivate);

    // Sort constructors by number of parameters, descending.
    // ignore: avoid-local-functions, better to keep local here
    int sortConstructors(ConstructorElement2 a, ConstructorElement2 b) =>
        -a.formalParameters.length.compareTo(b.formalParameters.length);

    final nonFactoryConstructors = allConstructors.where((c) => !c.isFactory).sorted(sortConstructors);
    final factoryConstructors =
        allConstructors.where((c) => c.isFactory && c.name3 != 'fromJson').sorted(sortConstructors);

    // Prefers non factory constructors over factory ones.
    return [...nonFactoryConstructors, ...factoryConstructors].firstOrNull;
  }

  Expression _mapConstructor(
    ConstructorElement2 targetConstructor, {
    required List<SourceAssignment> positional,
    required List<SourceAssignment> named,
  }) {
    final constructorName = targetConstructor.displayName;

    return EmitterHelper.current.refer(constructorName, targetConstructor.library2.uri.toString()).newInstance(
      positional.map(
        (assignment) => ValueAssignmentBuilder(
          mapperConfig: mapperConfig,
          mapping: mapping,
          assignment: assignment,
          onUsedNullableMethodCallback: onUsedNullableMethodCallback,
        ).build(),
      ),
      {
        for (final assignment in named)
          // ignore: avoid-non-null-assertion, must not be empty
          assignment.targetConstructorParam!.param.name3!: ValueAssignmentBuilder(
            mapperConfig: mapperConfig,
            mapping: mapping,
            assignment: assignment,
            onUsedNullableMethodCallback: onUsedNullableMethodCallback,
          ).build(),
      },
    );
  }

  void _assertNotMappedConstructorParameters(Iterable<FormalParameterElement> notMapped) {
    for (final param in notMapped) {
      if (param.isPositional && param.type.isNotNullable) {
        throw InvalidGenerationSourceError(
          "Can't generate mapping $mapping as there is non mapped not-nullable positional parameter '${param.displayName}'. ($mapping)",
        );
      }

      if (param.isRequiredNamed && param.type.isNotNullable) {
        if (param.type.isDartCoreList) return;
        throw InvalidGenerationSourceError(
          "Can't generate mapping $mapping as there is non mapped not-nullable required named parameter '${param.displayName}'. ($mapping)",
        );
      }
    }
  }
}
