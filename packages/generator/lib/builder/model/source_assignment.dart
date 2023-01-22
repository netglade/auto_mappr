import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:automapper_generator/builder/model/extensions.dart';

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

  NullabilitySuffix get targetNullability =>
      targetField?.type.nullabilitySuffix ?? targetConstructorParam!.param.type.nullabilitySuffix;

  SourceAssignment({
    required this.sourceField,
    required this.targetField,
    this.targetConstructorParam,
    this.memberMapping,
  });

  DartType get _targetType => targetConstructorParam?.param.type ?? targetField!.type;

  bool shouldAssignList() {
    // The source can be mapped to the target, if the source is mapable object and the target is listLike.
    return _isCoreListLike(_targetType) && _isMapable(sourceField!.type);
  }

  bool shouldAssignComplextObject() => !_targetType.isSimpleType;

  bool _isCoreListLike(DartType type) {
    return type.isDartCoreList || type.isDartCoreSet || type.isDartCoreIterable;
  }

  bool _isMapable(DartType type) {
    if (_isCoreListLike(type)) {
      return true;
    }

    if (type is! InterfaceType) {
      return false;
    }
    return type.allSupertypes.any(_isCoreListLike);
  }
}
