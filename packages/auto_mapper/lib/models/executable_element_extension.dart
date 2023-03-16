import 'package:analyzer/dart/element/element.dart';

extension ExecutableElementExtension on ExecutableElement {
  // Eg. when static class is used => Static.mapFrom()
  bool get hasStaticProxy => enclosingElement.displayName.isNotEmpty;

  String get referCallString => hasStaticProxy ? '${enclosingElement.displayName}.${displayName}' : displayName;
}
