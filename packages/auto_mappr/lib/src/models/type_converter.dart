import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:equatable/equatable.dart';

class TypeConverter extends Equatable {
  final DartType source;
  final DartType target;
  final ExecutableElement2 converter;

  @override
  List<Object?> get props => [source, target, converter];

  const TypeConverter({required this.source, required this.target, required this.converter});

  @override
  String toString() {
    final sourceX = source.getDisplayString();
    final targetX = target.getDisplayString();

    return 'typeConverter $sourceX -> $targetX';
  }

  bool canBeUsed({required DartType mappingSource, required DartType mappingTarget}) {
    return _isConverterSubtype(source, mappingSource, _ConversionRole.source) &&
        _isConverterSubtype(target, mappingTarget, _ConversionRole.target);
  }

  bool canBeUsedNullable({required DartType mappingSource, required DartType mappingTarget}) {
    // ignore: avoid-inverted-boolean-checks, this is better
    if (!(mappingSource.isNullable && mappingTarget.isNullable)) return false;

    return canBeUsed(
      // ignore: avoid-non-null-assertion, we expect this to be non-null
      mappingSource: mappingSource.element3!.library2!.typeSystem.promoteToNonNull(mappingSource),
      mappingTarget: target.isNullable
          ? mappingTarget
          // ignore: avoid-non-null-assertion, we expect this to be non-null
          : mappingTarget.element3!.library2!.typeSystem.promoteToNonNull(mappingTarget),
    );
  }

  bool _isConverterSubtype(DartType converterType, DartType fieldType, _ConversionRole role) {
    // Both types are dynamic, allow.
    if (converterType is DynamicType && fieldType is DynamicType) return true;

    // One of the types is dynamic, deny.
    if (converterType is DynamicType != fieldType is DynamicType) return false;

    // Same type, allow.
    if (converterType == fieldType) return true;

    // A TypeConverter with a non-nullable source converterType cannot handle a nullable source field
    if (role == _ConversionRole.source && converterType.isNotNullable && fieldType.isNullable) return false;

    // A TypeConverter with a nullable target converterType cannot handle a non-nullable target field
    if (role == _ConversionRole.target && converterType.isNullable && fieldType.isNotNullable) return false;

    // fieldType must be subtype of converterType.
    //
    // When [converterType] is Object, it is always success.
    // ignore: avoid-non-null-assertion, we expect this to be non-null
    final nonNullConverterType = converterType.element3!.library2!.typeSystem.promoteToNonNull(converterType);
    // ignore: avoid-non-null-assertion, we expect this to be non-null
    final nonNullFieldType = fieldType.element3!.library2!.typeSystem.promoteToNonNull(fieldType);

    return converterType.element3?.library2?.typeSystem.leastUpperBound(nonNullConverterType, nonNullFieldType) ==
        nonNullConverterType;
  }
}

enum _ConversionRole { source, target }
