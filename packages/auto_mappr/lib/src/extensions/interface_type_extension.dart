import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/extensions/property_accessor_element_extension.dart';

extension InterfaceTypeExtension on InterfaceType {
  Iterable<PropertyAccessorElement> getAllGetters() {
    return [
      ...accessors,
      for (final superType in allSupertypes)
        ...superType.accessors,
    ].where((accessor) => accessor.isReadable);
  }

  Iterable<PropertyAccessorElement> getAllSetters() {
    return [
      ...accessors,
      for (final superType in allSupertypes)
        ...superType.accessors,
    ].where((accessor) => accessor.isWritable);
  }
}
