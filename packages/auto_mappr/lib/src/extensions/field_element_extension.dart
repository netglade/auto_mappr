import 'package:analyzer/dart/element/element.dart';

extension FieldElementExtension on FieldElement {
  @Deprecated('')
  bool get isWritable => isPublic && !isFinal && !isStatic && setter != null;

  @Deprecated('')
  bool get isReadable => isPublic && getter != null;
}
