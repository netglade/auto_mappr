//ignore_for_file: prefer-match-file-name

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mapper_generator/models/extensions.dart';
import 'package:code_builder/code_builder.dart';

import '../../models/auto_map_part.dart';

class ConstructorAssignment {
  final ParameterElement param;
  final int? position;

  bool get isNamed => param.isNamed;

  ConstructorAssignment({
    required this.param,
    this.position,
  });
}

class SourceAssignment {
  final FieldElement? sourceField;
  final ConstructorAssignment? targetConstructorParam;
  final FieldElement? targetField;
  final MemberMapping? memberMapping;

  bool get shouldBeIgnored => memberMapping?.ignore ?? false;

  NullabilitySuffix get targetNullability => targetType.nullabilitySuffix;

  DartType get targetType => targetConstructorParam?.param.type ?? targetField!.type;

  String get targetName => targetConstructorParam?.param.displayName ?? targetField!.displayName;

  SourceAssignment({
    required this.sourceField,
    required this.targetField,
    this.targetConstructorParam,
    this.memberMapping,
  });

  //todo (tests)
  bool shouldAssignList() {
    // The source can be mapped to the target, if the source is mappable object and the target is listLike.
    return _isCoreListLike(targetType) && _isMappable(sourceField!.type);
  }

  bool shouldAssignComplextObject() => !targetType.isSimpleType;

  @override
  String toString() {
    final targetTypeName = targetType.getDisplayString(withNullability: true);
    final sourceName = sourceField?.getDisplayString(withNullability: true);

    return '$sourceName -> $targetTypeName $targetName';
  }

  Expression getDefaultValue() {
    if (targetType.isDartCoreList) return refer('[]');
    if (targetType.isDartCoreSet || targetType.isDartCoreMap) return refer('{}');

    return refer('null');
  }

  bool _isCoreListLike(DartType type) {
    return type.isDartCoreList || type.isDartCoreSet || type.isDartCoreIterable;
  }

  bool _isMappable(DartType type) {
    if (_isCoreListLike(type)) {
      return true;
    }

    if (type is! InterfaceType) {
      return false;
    }

    return type.allSupertypes.any(_isCoreListLike);
  }
}
