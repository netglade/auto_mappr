import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';

extension DartTypeExtension on DartType {
  bool get isPrimitiveType =>
      isDartCoreNum ||
      isDartCoreInt ||
      isDartCoreDouble ||
      isDartCoreString ||
      isDartCoreBool ||
      isDartCoreEnum ||
      isDartCoreSymbol;

  /// Is special variant of integer.
  ///
  /// See `Uint8List, Uint16List, Uint32List,Uint64List`.
  bool get isSpecializedListType {
    final thisType = this;
    if (thisType is! InterfaceType) return false;

    return thisType.interfaces.any((i) => i.getDisplayString(withNullability: false) == 'List<int>');
  }

  DartType get genericParameterTypeOrThis => (this as ParameterizedType).typeArguments.firstOrNull ?? this;

  /// Checks name, generics, library
  /// and nullability if [withNullability] is not set.
  bool isSame(
    DartType other, {
    bool withNullability = false,
  }) {
    // Not the same type of type.
    if ((this is InterfaceType) ^ (other is InterfaceType)) {
      return false;
    }

    // TODO(generics): somehow compare if generics are the same?
    // if (this is InterfaceType) {
    //   // Same types, not considering the type arguments.
    //   return element!.thisOrAncestorMatching((p0) => p0 == other.element) != null;
    // }

    // Name matches.
    final thisName = getDisplayString(withNullability: withNullability);
    final otherName = other.getDisplayString(withNullability: withNullability);
    final isSameName = thisName == otherName;

    // Library matches.
    final thisLibrary = element?.library?.identifier;
    final otherLibrary = other.element?.library?.identifier;
    final isSameLibrary = thisLibrary == otherLibrary;

    final isSameExceptNullability = isSameName && isSameLibrary;

    if (withNullability) {
      return isSameExceptNullability;
    }

    // Nullability matches.
    final thisNullability = nullabilitySuffix == NullabilitySuffix.star;
    final otherNullability = other.nullabilitySuffix == NullabilitySuffix.star;
    final isSameNullability = thisNullability == otherNullability;

    return isSameExceptNullability && isSameNullability;
  }

  Expression defaultIterableExpression() {
    final itemType = (this as ParameterizedType).typeArguments.firstOrNull ?? this;

    if (isDartCoreList) {
      return literalList([], refer(itemType.getDisplayString(withNullability: true)));
    }

    // set
    return literalSet({}, refer(itemType.getDisplayString(withNullability: true)));
  }

  String toConvertMethodName({
    required bool withNullability,
  }) {
    final buffer = StringBuffer()..write(element!.name);

    if (this is ParameterizedType && (this as ParameterizedType).typeArguments.isNotEmpty) {
      final arguments = (this as ParameterizedType)
          .typeArguments
          .map<String>((argument) => argument.toConvertMethodName(withNullability: withNullability))
          .join(r'$');
      buffer.write('\$$arguments');
    }

    // Nullability
    if (withNullability && nullabilitySuffix == NullabilitySuffix.star) {
      buffer.write('?');
    }

    return buffer.toString();
  }
}
