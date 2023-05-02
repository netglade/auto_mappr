import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/extensions/element_extension.dart';
import 'package:auto_mappr/src/models/auto_mappr_config.dart';
import 'package:code_builder/code_builder.dart';

extension DartTypeExtension on DartType {
  bool get isPrimitiveType =>
      isDartCoreNum ||
      isDartCoreInt ||
      isDartCoreDouble ||
      isDartCoreString ||
      isDartCoreBool ||
      isDartCoreEnum ||
      isDartCoreSymbol;

  /// Checks if this type is assignable to the given [other] type.
  bool isAssignableTo(DartType other) {
    // Not the same type of type.
    if ((this is InterfaceType) ^ (other is InterfaceType)) {
      return false;
    }

    // TODO(generics): somehow compare if generics are the same?
    // if (this is InterfaceType) {
    //   // Same types, not considering the type arguments.
    //   return element!.thisOrAncestorMatching((p0) => p0 == other.element) != null;
    // }
    final typeSystem = element!.library!.typeSystem;

    return typeSystem.isAssignableTo(
      typeSystem.promoteToNonNull(this),
      typeSystem.promoteToNonNull(other),
    );
  }

  Expression defaultIterableExpression({
    required AutoMapprConfig config,
  }) {
    final itemType = (this as ParameterizedType).typeArguments.first;

    if (isDartCoreSet) {
      return literalSet(
        {},
        refer(
          itemType.getDisplayStringWithLibraryAlias(
            config: config,
            withNullability: true,
          ),
        ),
      );
    }

    return literalList(
      [],
      refer(
        itemType.getDisplayStringWithLibraryAlias(
          config: config,
          withNullability: true,
        ),
      ),
    );
  }

  String getDisplayStringWithLibraryAlias({
    required AutoMapprConfig config,
    bool withNullability = false,
  }) {
    final alias = element!.getLibraryAlias(config: config);
    final connectionString = alias.trim().isEmpty ? '' : '.';
    final typeName = element!.name;
    final buffer = StringBuffer('$alias$connectionString$typeName');

    if (this is ParameterizedType && (this as ParameterizedType).typeArguments.isNotEmpty) {
      final arguments = (this as ParameterizedType)
          .typeArguments
          .map<String>(
            (argument) => argument.getDisplayStringWithLibraryAlias(
              withNullability: withNullability,
              config: config,
            ),
          )
          .join(',');
      buffer.write('<$arguments>');
    }

    // Nullability
    if (withNullability && nullabilitySuffix == NullabilitySuffix.question) {
      buffer.write('?');
    }

    return buffer.toString();
  }

  String toConvertMethodName({
    required bool withNullability,
    required AutoMapprConfig config,
  }) {
    final libraryAlias = element!.getLibraryAlias(config: config);
    final connectionString = libraryAlias.trim().isEmpty ? '' : '_';
    final typeName = element!.name;
    final buffer = StringBuffer()..write('$libraryAlias$connectionString$typeName');

    if (this is ParameterizedType && (this as ParameterizedType).typeArguments.isNotEmpty) {
      final arguments = (this as ParameterizedType)
          .typeArguments
          .map<String>(
            (argument) => argument.toConvertMethodName(
              withNullability: withNullability,
              config: config,
            ),
          )
          .join(r'$');
      buffer.write('\$$arguments');
    }

    // Nullability
    if (withNullability && nullabilitySuffix == NullabilitySuffix.question) {
      buffer.write('?');
    }

    return buffer.toString();
  }
}
