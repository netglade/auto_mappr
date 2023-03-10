//ignore_for_file: prefer-match-file-name

import 'package:analyzer/dart/element/type.dart';

extension DartTypeExtension on DartType {
  bool get isSimpleType =>
      isDartCoreBool ||
      isDartCoreDouble ||
      isDartCoreInt ||
      isDartCoreString ||
      isDartCoreInt ||
      isDartCoreString ||
      isDartCoreNum;

  bool isSameExceptNullability(DartType other) {
    final thisName = element?.name;
    final otherName = other.element?.name;

    return thisName == otherName;
  }
}
