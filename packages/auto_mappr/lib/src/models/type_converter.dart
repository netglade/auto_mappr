import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:equatable/equatable.dart';

class TypeConverter extends Equatable {
  final DartType source;
  final DartType target;
  final ExecutableElement converter;

  @override
  List<Object?> get props => [source, target, converter];

  const TypeConverter({
    required this.source,
    required this.target,
    required this.converter,
  });

  @override
  String toString() {
    final sourceX = source.getDisplayString(withNullability: true);
    final targetX = target.getDisplayString(withNullability: true);

    return 'typeConverter $sourceX -> $targetX';
  }

  bool canBeUsed({
    required DartType mappingSource,
    required DartType mappingTarget,
  }) {
    return _isConverterSubtype(source, mappingSource, _ConversionRole.source) &&
        _isConverterSubtype(target, mappingTarget, _ConversionRole.target);
  }

  bool canBeUsedNullable({
    required DartType mappingSource,
    required DartType mappingTarget,
  }) {
    if(!(mappingSource.isNullable && mappingTarget.isNullable)) return false;

    return canBeUsed(
      mappingSource: mappingSource.element!.library!.typeSystem.promoteToNonNull(mappingSource),
      mappingTarget: mappingTarget.element!.library!.typeSystem.promoteToNonNull(mappingTarget),
    );
  }

  bool _isConverterSubtype(DartType converterType, DartType fieldType, _ConversionRole role) {
    // Same type.
    if (converterType == fieldType) return true;

    // A TypeConverter with a non-nullable source converterType cannot handle a nullable source field
    if (role == _ConversionRole.source && converterType.isNotNullable && fieldType.isNullable) return false;

    // A TypeConverter with a nullable target converterType cannot handle a non-nullable target field
    if (role == _ConversionRole.target && converterType.isNullable && fieldType.isNotNullable) return false;

    // fieldType must be subtype of converterType.
    //
    // When [converterType] is Object, it is always success.
    final nonNullConverterType = converterType.element!.library!.typeSystem.promoteToNonNull(converterType);
    final nonNullFieldType = fieldType.element!.library!.typeSystem.promoteToNonNull(fieldType);

    return converterType.element?.library?.typeSystem.leastUpperBound(nonNullConverterType, nonNullFieldType) ==
        nonNullConverterType;
  }
}

enum _ConversionRole {
  source,
  target,
}
