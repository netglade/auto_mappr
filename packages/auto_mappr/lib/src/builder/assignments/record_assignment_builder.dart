import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:auto_mappr/src/builder/assignments/assignment_builder_base.dart';
import 'package:auto_mappr/src/builder/assignments/nested_object_mixin.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';

class RecordAssignmentBuilder extends AssignmentBuilderBase with NestedObjectMixin {
  const RecordAssignmentBuilder({
    required super.assignment,
    required super.mapperConfig,
    required super.mapping,
    required super.usedNullableMethodCallback,
  });

  @override
  bool canAssign() {
    log.warning(
        'RECORD ASSIGNMENT CHECK ${assignment.targetType is RecordType} ... ${assignment.sourceType is RecordType} /// $assignment');
    return assignment.canAssignRecord();
  }

  @override
  Expression buildAssignment() {
    log.warning('RECORD ASSIGNMENT');
    final sourceType = assignment.sourceType!;
    final targetType = assignment.targetType;

    // final sourceNullable = sourceType.nullabilitySuffix == NullabilitySuffix.question;
    // final targetNullable = targetType.nullabilitySuffix == NullabilitySuffix.question;

    // ignore: avoid-unrelated-type-casts, it's ok and handled by canAssign
    final sourceRecordType = sourceType as RecordType;
    // ignore: avoid-unrelated-type-casts, it's ok and handled by canAssign
    final targetRecordType = targetType as RecordType;

    // Positional fields check.
    final sourcePositional = sourceRecordType.positionalFieldTypes;
    final targetPositional = targetRecordType.positionalFieldTypes;
    if (sourcePositional.length != targetPositional.length) {
      throw InvalidGenerationSourceError(
        'Positional source and target fields length mismatch for source ${sourceType} and target ${targetType}',
      );
    }

    // Named fields check.
    final sourceNamed = sourceRecordType.namedFieldTypes;
    final targetNamed = targetRecordType.namedFieldTypes;
    for (final field in targetNamed.entries) {
      print('!!! ${field.key} = ${field.value}');
    }

    // NAMED - check target has all source's named, if target is nullable it might not

    // --- ASSIGN MAP ---

    // -- RETURN --

    // TODO(records): return positional and named as code
    return const CodeExpression(Code('(1, 2, 3, alpha: 4, beta: 5)'));

    // ----------------

    // final shouldFilterNullInSource = sourceRecordType.nullabilitySuffix == NullabilitySuffix.question &&
    //     targetRecordType.nullabilitySuffix != NullabilitySuffix.question;

    // final assignNestedObject = (!targetRecordType.isPrimitiveType && !targetRecordType.isSpecializedListType) &&
    //     (!targetRecordType.isSame(sourceRecordType));

    // // When [sourceIterableType] is nullable and [targetIterableType] is not, remove null values.
    // final sourceIterableExpression = refer('model').property(assignment.sourceField!.name).maybeWhereIterableNotNull(
    //       condition: shouldFilterNullInSource,
    //       isOnNullable: sourceNullable,
    //     );

    // final defaultIterableValueExpression = targetType.defaultIterableExpression(config: mapperConfig);

    // if (assignNestedObject) {
    //   return sourceIterableExpression
    //       // Map complex nested types.
    //       .maybeNullSafeProperty('map', isOnNullable: sourceNullable)
    //       .call(
    //         [_nestedMapCallForIterable(assignment)],
    //         {},
    //         [
    //           refer(
    //             targetRecordType.getDisplayStringWithLibraryAlias(
    //               withNullability: true,
    //               config: mapperConfig,
    //             ),
    //           ),
    //         ],
    //       )
    //       // Call toList, toSet or nothing.
    //       // isOnNullable is false, because if map() was called, the value is non-null
    //       .maybeToIterableCall(
    //         source: sourceType,
    //         target: targetType,
    //         forceCast: true, //map was used so we want force toIterable() call
    //         isOnNullable: false,
    //       )
    //       // When [sourceNullable], use default value.
    //       .maybeIfNullThen(defaultIterableValueExpression, isOnNullable: sourceNullable && !targetNullable);
    // }

    // return sourceIterableExpression
    //     .maybeToIterableCall(
    //       source: sourceType,
    //       target: targetType,
    //       forceCast: shouldFilterNullInSource, // if whereNotNull was used -> we want to force toIterable() call
    //       isOnNullable: !targetNullable && sourceNullable,
    //     )
    //     .maybeIfNullThen(
    //       defaultIterableValueExpression,
    //       isOnNullable: !targetNullable && sourceNullable,
    //     );
  }

  // Expression _nestedMapCallForIterable(SourceAssignment assignment) {
  //   final targetListType = assignment.targetType.genericParameterTypeOrSelf;
  //   final sourceListType = assignment.sourceType!.genericParameterTypeOrSelf;

  //   return assignNestedObject(
  //     assignment: assignment,
  //     source: sourceListType,
  //     target: targetListType,
  //   );
  // }
}
