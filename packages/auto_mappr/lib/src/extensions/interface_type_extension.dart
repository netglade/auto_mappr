import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/extensions/property_accessor_element_extension.dart';

extension InterfaceTypeExtension on InterfaceType {
  Iterable<PropertyAccessorElement> getGettersWithTypes() {
    return accessors.where((accessor) => accessor.isReadable);
  }

  Iterable<PropertyAccessorElement> getSettersWithTypes() {
    return accessors.where((accessor) => accessor.isWritable);
  }
}
