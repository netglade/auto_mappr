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

  bool get isDynamic {
    return this is DynamicType;
  }

  /// Is special variant of integer list.
  ///
  /// See `[Uint8List], [Uint16List], [Uint32List], [Uint64List]`.
  bool get isSpecializedIntListType {
    final thisType = this;
    if (thisType is! InterfaceType) return false;

    return thisType.allSupertypes.any((i) => i.getDisplayString() == 'List<int>');
  }

  DartType get genericParameterTypeOrSelf => (this as ParameterizedType).typeArguments.firstOrNull ?? this;

  /// Checks name, generics, library.
  bool isSame(DartType? other) {
    if (other == null) return false;

    // Not the same type of type.
    if ((this is InterfaceType) ^ (other is InterfaceType)) {
      return false;
    }

    // Name matches.
    // ignore: deprecated_member_use, avoid-deprecated-usage, without this it does not work - we have to fix this later
    final thisName = getDisplayString(withNullability: false);
    // ignore: deprecated_member_use, avoid-deprecated-usage, without this it does not work - we have to fix this later
    final otherName = other.getDisplayString(withNullability: false);
    final isSameName = thisName == otherName;

    // Library matches.
    final thisLibrary = element?.library?.uri.toString();
    final otherLibrary = other.element?.library?.uri.toString();
    final isSameLibrary = thisLibrary == otherLibrary;

    return isSameName && isSameLibrary;
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
