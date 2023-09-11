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
          (converter) => converter.canBeUsed(
            mappingSource: source,
            mappingTarget: target,
          ),
        ) !=
        null;
  }

  @override
  Expression buildAssignment() {
    final converter = assignment.typeConverters
        // ignore: avoid-unsafe-collection-methods, checked by [canAssign]
        .firstWhere((c) => c.canBeUsed(mappingSource: source, mappingTarget: target));

    // Call.
    if (convertMethodArgument case final methodArgument?) {
      final targetRefer = EmitterHelper.current.typeRefer(type: target);

      return EmitterHelper.current
          .refer(converter.converter.referCallString, converter.converter.library.identifier)
          .call([methodArgument]).asA(targetRefer);
    }

    final sourceEmitted = EmitterHelper.current.typeReferEmitted(type: source);
    final targetEmitted = EmitterHelper.current.typeReferEmitted(type: target);

    // Tear-off.
    return EmitterHelper.current
        .refer(converter.converter.referCallString, converter.converter.library.identifier)
        .asA(refer('$targetEmitted Function($sourceEmitted)'));
  }
}
