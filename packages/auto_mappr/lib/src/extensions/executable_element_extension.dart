import 'package:analyzer/dart/element/element.dart';

extension ExecutableElementExtension on ExecutableElement {
  // Constructors are referred to by the class name, followed by the constructor name for named constructors.
  // The unnamed constructor is named `new`, so neither `name` nor `displayName` (`ClassName.new`) can be used directly.
  //
  // For top-level functions `isStatic` is true
  // but the enclosing element has no display name.
  // This could result in the expression being `.someFunction()` which is invalid.
  // Therefore, we only add the enclosing element's display name if it is not empty.
  String get referCallString => switch (this) {
    ConstructorElement(:final enclosingElement, name: null || 'new') => enclosingElement.displayName,
    ConstructorElement(:final enclosingElement, :final name?) => '${enclosingElement.displayName}.$name',
    // ignore: avoid-non-null-assertion, ok here
    _ when isStatic && enclosingElement?.displayName != '' => '${enclosingElement!.displayName}.$displayName',
    _ => displayName,
  };
}
