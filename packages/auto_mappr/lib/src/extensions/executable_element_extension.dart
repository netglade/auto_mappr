import 'package:analyzer/dart/element/element.dart';

extension ExecutableElementExtension on ExecutableElement {
  String get referCallString => isStatic &&
          // A top-level function may be static but does not have a display name.
          enclosingElement.displayName != ''
      ? '${enclosingElement.displayName}.$displayName'
      : displayName;
}
