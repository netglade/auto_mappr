import 'package:analyzer/dart/element/element.dart';

extension FieldElementExtension on FieldElement {
  bool get isWritable => isPublic && !isFinal && !isStatic && setter != null;

  bool get isReadable => isPublic && getter != null;
}
