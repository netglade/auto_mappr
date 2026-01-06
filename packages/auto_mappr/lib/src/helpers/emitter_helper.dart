import 'dart:async';

import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/extensions/dart_type_extension.dart';
import 'package:code_builder/code_builder.dart' as cb;
import 'package:path/path.dart' as p;

/// Helper class for emitting and package import uri resolution.
class EmitterHelper {
  /// Global emitter so we can emit on the fly and all imports are preserved.
  final cb.DartEmitter emitter = cb.DartEmitter(
    allocator: cb.Allocator.simplePrefixing(),
    orderDirectives: true,
    useNullSafetySyntax: true,
  );

  final Uri? fileWithAnnotation;

  static Symbol get zoneSymbol => #autoMapprEmitter;
  static EmitterHelper get current => Zone.current[zoneSymbol] as EmitterHelper;

  EmitterHelper({required this.fileWithAnnotation});

  /// `refer` that is processed by helper.
  cb.Reference refer(String symbol, String? url) {
    final importUrl =
        // TODO(module): can we check whether the url is from THIS package and therefore we can use relative, also in current project test must be relative
        // type.isPrimitiveType || type.isDartCoreObject
        //     ? _resolveAssetImport(libraryPath)
        //     :
        _relative(url, fileWithAnnotation);

    return cb.refer(symbol, importUrl);
  }

  /// `refer` that is emitted to String using [emitter].
  String referEmitted(String symbol, [String? url]) {
    // ignore: avoid-default-tostring, should be ok
    return refer(symbol, url).accept(emitter).toString();
  }

  /// [typeRefer] that is also emitted to String using [emitter].
  String typeReferEmitted({
    required DartType? type,
    // Uri? targetFile,
    bool withNullabilitySuffix = true,
  }) {
    if (type == null) {
      return '???';
    }

    // ignore: avoid-default-tostring, should be ok
    return '${typeRefer(type: type, withNullabilitySuffix: withNullabilitySuffix).accept(emitter)}';
  }

  /// Produces a reference to [type] with an import alias prefix.
  /// When [fileWithAnnotation] is also set, import is relative.
  ///
  /// Inspired by injectable.
  cb.Reference typeRefer({required DartType type, bool withNullabilitySuffix = true}) {
    final libraryPath = type.element?.library?.uri.toString();
    final importUrl = type.isPrimitiveType || type.isDartCoreObject
        ? _resolveAssetImport(libraryPath)
        : _relative(libraryPath, fileWithAnnotation);

    return cb.TypeReference((reference) {
      reference
        ..symbol = type.element?.name
        ..url = importUrl
        ..isNullable = withNullabilitySuffix && type.isNullable;

      if (type is ParameterizedType && type.typeArguments.isNotEmpty) {
        reference.types.addAll(
          // ignore: avoid-recursive-calls, it's handled
          type.typeArguments.map((e) => typeRefer(type: e)),
        );
      }
    });
  }

  String? _relative(String? path, Uri? to) {
    if (path == null || to == null) {
      return null;
    }

    final fileUri = Uri.parse(path);

    if (fileUri.scheme == 'dart') {
      return 'dart:${fileUri.path}';
    }

    if (fileUri.scheme == 'package') {
      return path;
    }

    if (fileUri.scheme == 'asset') {
      // Something like ['auto_mappr', 'lib', 'src', 'models', 'model.dart']
      final pathSegments = fileUri.pathSegments;

      // * In lib/
      // If it points to lib folder,
      // we can convert to package uri.
      // ? We want to do this, because package imports are preferred for files in lib/,
      // ? since people can configure to build generated files to different places.
      if (pathSegments.elementAtOrNull(1) == 'lib') {
        // ignore: avoid-unsafe-collection-methods, it's guaranteed to have at least 2 elements,
        final packageName = pathSegments.first;
        final filePath = pathSegments.sublist(2).join('/');

        return 'package:$packageName/$filePath';
      }

      // * Not in lib/
      // If it points to other directory than lib/,
      // we cannot safely use package import.
      //
      // In such cases,
      // use relative imports from the file with annotation.
      //
      // ? This might happen in test/, bin/, example/ folders.
      final packageName = pathSegments.firstOrNull;
      final toPackageName = to.pathSegments.firstOrNull;

      if (packageName == toPackageName) {
        final relativePath = p.posix.relative(fileUri.path, from: to.path).replaceFirst('../', '');

        // If it is the same file, return only the file name.
        if (relativePath == '.') {
          return pathSegments.lastOrNull;
        }

        return relativePath;
      }
    }

    return path;
  }

  String? _resolveAssetImport(String? path) {
    if (path == null) {
      return null;
    }

    final fileUri = Uri.parse(path);
    if (fileUri.scheme == 'asset') {
      return '/${fileUri.path}';
    }

    return path;
  }
}
