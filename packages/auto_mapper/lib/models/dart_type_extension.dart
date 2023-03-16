import 'package:analyzer/dart/element/type.dart';

extension DartTypeExtension on DartType {
  bool get isPrimitiveType =>
      isDartCoreNum || isDartCoreInt || isDartCoreDouble || isDartCoreString || isDartCoreBool || isDartCoreEnum;

  bool isSameExceptNullability(DartType other) {
    final thisName = element?.name;
    final otherName = other.element?.name;

    // TODO: check library?

    return thisName == otherName;
  }
}
