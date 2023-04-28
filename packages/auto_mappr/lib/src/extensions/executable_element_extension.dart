import 'package:analyzer/dart/element/element.dart';

extension ExecutableElementExtension on ExecutableElement {
  String get referCallString => isStatic &&
          // A top-level function is static but the enclosing element has no
          // display name. This could result in the expression being
          // `.someFunction()` which is invalid. Therefore, we only add the
          // enclosing element's display name if it is not empty.
          enclosingElement.displayName != ''
      ? '${enclosingElement.displayName}.$displayName'
      : displayName;
}
