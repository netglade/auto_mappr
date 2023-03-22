import 'package:analyzer/dart/element/element.dart';

extension ExecutableElementExtension on ExecutableElement {
  String get referCallString => isStatic ? '${enclosingElement.displayName}.$displayName' : displayName;
}
