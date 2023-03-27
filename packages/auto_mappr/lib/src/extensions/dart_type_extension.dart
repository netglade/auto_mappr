import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

extension DartTypeExtension on DartType {
  bool get isPrimitiveType =>
      isDartCoreNum ||
      isDartCoreInt ||
      isDartCoreDouble ||
      isDartCoreString ||
      isDartCoreBool ||
      isDartCoreEnum ||
      isDartCoreSymbol;

  bool isSameExceptNullability(DartType other) {
    final thisName = element?.name;
    final otherName = other.element?.name;
    final isSameName = thisName == otherName;

    final thisLibrary = element?.library?.identifier;
    final otherLibrary = other.element?.library?.identifier;
    final isSameLibrary = thisLibrary == otherLibrary;

    return isSameName && isSameLibrary;
  }

  Expression defaultListLikeExpression() {
    final itemType = (this as ParameterizedType).typeArguments.first;

    if (isDartCoreList) {
      return literalList([], refer(itemType.getDisplayString(withNullability: true)));
    }

    // set
    return literalSet({}, refer(itemType.getDisplayString(withNullability: true)));
  }
}
