import 'package:analyzer/dart/element/element.dart';
import 'package:auto_mappr/src/models/auto_mappr_config.dart';

extension ElementExtension on Element {
  String getLibraryAlias({
    required AutoMapprConfig config,
  }) {
    var alias = '';

    if (!(library?.isInSdk ?? false)) {
      final libraryUri = source?.uri.toString();
      final contains = config.libraryUriToAlias.containsKey(libraryUri);

      if (contains) {
        alias = config.libraryUriToAlias[libraryUri]!;
      }
    }

    return alias;
  }
}
