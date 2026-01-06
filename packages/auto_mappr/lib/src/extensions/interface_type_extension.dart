import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

extension InterfaceTypeExtension on InterfaceType {
  Iterable<PropertyAccessorElement> getAllGetters() {
    return [
      ...getters,
      for (final superType in allSupertypes) ...superType.getters,
    ].where((accessor) => accessor.isPublic);
  }

  Iterable<PropertyAccessorElement> getAllSetters() {
    return [
      ...setters,
      for (final superType in allSupertypes) ...superType.setters,
    ].where((accessor) => accessor.isPublic && !accessor.isStatic);
  }
}
