import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/helpers/emitter_helper.dart';
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

  bool get isNullable {
    return nullabilitySuffix == NullabilitySuffix.question;
  }

  bool get isNotNullable {
    return !isNullable;
  }

  /// Is special variant of integer list.
  ///
  /// See `[Uint8List], [Uint16List], [Uint32List], [Uint64List]`.
  bool get isSpecializedIntListType {
    final thisType = this;
    if (thisType is! InterfaceType) return false;

    // ignore: deprecated_member_use, for now use this - w/o this it fails
    return thisType.allSupertypes.any((i) => i.getDisplayString(withNullability: false) == 'List<int>');
  }

  DartType get genericParameterTypeOrSelf => (this as ParameterizedType).typeArguments.firstOrNull ?? this;

  /// Checks name, generics, library
  /// and nullability if [withNullability] is not set.
  bool isSame(DartType? other, {bool withNullability = false}) {
    if (other == null) return false;

    // Not the same type of type.
    if ((this is InterfaceType) ^ (other is InterfaceType)) {
      return false;
    }

    // Name matches.
    // ignore: deprecated_member_use, for now use this - w/o this it fails
    final thisName = getDisplayString(withNullability: withNullability);
    // ignore: deprecated_member_use, for now use this - w/o this it fails
    final otherName = other.getDisplayString(withNullability: withNullability);
    final isSameName = thisName == otherName;

    // Library matches.
    final thisLibrary = element3?.library2?.identifier;
    final otherLibrary = other.element3?.library2?.identifier;
    final isSameLibrary = thisLibrary == otherLibrary;

    final isSameExceptNullability = isSameName && isSameLibrary;

    if (!withNullability) {
      return isSameExceptNullability;
    }

    // Nullability matches.
    final thisNullability = isNullable;
    final otherNullability = other.isNullable;
    final isSameNullability = thisNullability == otherNullability;

    return isSameExceptNullability && isSameNullability;
  }

  Expression defaultIterableExpression() {
    final itemType = genericParameterTypeOrSelf;

    return isDartCoreSet
        ? literalSet({}, EmitterHelper.current.typeRefer(type: itemType))
        : literalList([], EmitterHelper.current.typeRefer(type: itemType));
  }

  String toConvertMethodName() {
    final emittedThis = EmitterHelper.current
        .typeReferEmitted(type: this)
        .replaceAll(' ', '')
        .replaceAll('?', '')
        .replaceAll('.', r'$')
        .replaceAll(',', r'_$')
        .replaceAll('<', r'$')
        .replaceAll('>', r'$');
    final buffer = StringBuffer()..write(emittedThis);

    return buffer.toString();
  }
}
