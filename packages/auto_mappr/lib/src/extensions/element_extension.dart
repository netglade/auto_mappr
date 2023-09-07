import 'package:analyzer/dart/element/element.dart';
import 'package:auto_mappr/src/models/auto_mappr_config.dart';

extension ElementExtension on Element {
  /// Returns an library alias with [postfix] (usually '.'),
  /// or empty string if no alias detected.
  @Deprecated('use EmitterHelper.current.typeReferenceEmitted instead')
  String getLibraryAlias({
    required AutoMapprConfig config,
    String postfix = '.',
  }) {
    final libraryUri = source?.uri.toString();
    final contains = config.libraryUriToAlias.containsKey(libraryUri);

    return contains ? '${config.libraryUriToAlias[libraryUri]!}$postfix' : '';
  }
}
