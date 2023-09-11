import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
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
    return _isConverterSubtype(source, mappingSource) && _isConverterSubtype(target, mappingTarget);
  }

  bool _isConverterSubtype(DartType self, DartType other) {
    // Same type.
    if (self == other) return true;

    // Other must be subtype of self.
    //
    // When [self] is Object, it is always success.
    return self.element?.library?.typeSystem.leastUpperBound(self, other) == self;
  }
}
