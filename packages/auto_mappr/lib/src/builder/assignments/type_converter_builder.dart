import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/builder/assignments/assignment_builder_base.dart';
import 'package:auto_mappr/src/extensions/executable_element_extension.dart';
import 'package:auto_mappr/src/helpers/emitter_helper.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';

class TypeConverterBuilder extends AssignmentBuilderBase {
  final Expression? convertMethodArgument;
  final DartType source;
  final DartType target;

  const TypeConverterBuilder({
    required super.assignment,
    required super.mapperConfig,
    required super.mapping,
    required super.usedNullableMethodCallback,
    required this.convertMethodArgument,
    required this.source,
    required this.target,
  });

  @override
  bool canAssign() {
    return assignment.typeConverters.firstWhereOrNull(
          (converter) =>
              converter.canBeUsed(
                mappingSource: source,
                mappingTarget: target,
              ) ||
              converter.canBeUsedNullable(
                mappingSource: source,
                mappingTarget: target,
              ),
        ) !=
        null;
  }

  @override
  Expression buildAssignment() {
    // ignore: avoid-unsafe-collection-methods, checked by [canAssign]
    final converter = assignment.typeConverters.firstWhere(
      (c) => c.canBeUsed(mappingSource: source, mappingTarget: target),
      // ignore: avoid-unsafe-collection-methods, checked by [canAssign]
      orElse: () => assignment.typeConverters.firstWhere(
        (c) => c.canBeUsedNullable(
          mappingSource: source,
          mappingTarget: target,
        ),
      ),
    );

    // Call.
    if (convertMethodArgument case final methodArgument?) {
      final targetRefer = EmitterHelper.current.typeRefer(type: target);

      if (converter.canBeUsed(mappingSource: source, mappingTarget: target)) {
        return EmitterHelper.current
            .refer(
          converter.converter.referCallString,
          converter.converter.library.identifier,
        )
            .call([methodArgument]).asA(targetRefer);
      }

      return methodArgument.equalTo(literalNull).conditional(
            literalNull,
            EmitterHelper.current
                .refer(
              converter.converter.referCallString,
              converter.converter.library.identifier,
            )
                .call([methodArgument.nullChecked]).asA(targetRefer),
          );
    }

    final sourceEmitted = EmitterHelper.current.typeReferEmitted(type: source);
    final targetEmitted = EmitterHelper.current.typeReferEmitted(type: target);

    // Tear-off.
    return EmitterHelper.current
        .refer(
          converter.converter.referCallString,
          converter.converter.library.identifier,
        )
        .asA(refer('$targetEmitted Function($sourceEmitted)'));
  }
}
