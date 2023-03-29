import 'package:analyzer/dart/element/element.dart';

extension PropertyAccessorElementExtension on PropertyAccessorElement {
  bool get isWritable => isPublic && isSetter && !isStatic;

  bool get isReadable => isPublic && isGetter;
}
