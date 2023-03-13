//ignore_for_file: prefer-match-file-name

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

extension DartTypeExtension on DartType {
  bool get isPrimitiveType =>
      isDartCoreNum || isDartCoreInt || isDartCoreDouble || isDartCoreString || isDartCoreBool || isDartCoreEnum;

  bool isSameExceptNullability(DartType other) {
    final thisName = element?.name;
    final otherName = other.element?.name;

    return thisName == otherName;
  }
}

extension ExecutableElementExtension on ExecutableElement {
  // Eg. when static class is used => Static.mapFrom()
  bool get hasStaticProxy => enclosingElement.displayName.isNotEmpty;

  String get referCallString => hasStaticProxy ? '${enclosingElement.displayName}.${displayName}' : displayName;
}
