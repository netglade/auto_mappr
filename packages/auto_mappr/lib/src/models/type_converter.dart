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

  bool _isConverterSubtype(DartType self, DartType other, _ConversionRole role) {
    // Same type.
    if (self == other) return true;

    // A converter with a non-nullable source cannot handle a nullable source value
    if (role == _ConversionRole.source && self.isNotNullable && other.isNullable) return false;

    // A converter with a nullable target cannot convert to a target that is non-nullable
    if (role == _ConversionRole.target && self.isNullable && other.isNotNullable) return false;

    // Other must be subtype of self.
    //
    // When [self] is Object, it is always success.
    final nonNullSelf = self.element!.library!.typeSystem.promoteToNonNull(self);
    final nonNullOther = other.element!.library!.typeSystem.promoteToNonNull(other);
    return self.element?.library?.typeSystem.leastUpperBound(nonNullSelf, nonNullOther) == nonNullSelf;
  }
}

enum _ConversionRole {
  source,
  target,
}
