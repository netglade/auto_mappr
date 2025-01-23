import 'package:analyzer/dart/element/element.dart';

extension ExecutableElementExtension on ExecutableElement {
  // For top-level functions `isStatic` is true
  // but the enclosing element has no display name.
  // This could result in the expression being `.someFunction()` which is invalid.
  // Therefore, we only add the enclosing element's display name if it is not empty.
  String get referCallString =>
      isStatic && enclosingElement3.displayName != '' ? '${enclosingElement3.displayName}.$displayName' : displayName;
}
