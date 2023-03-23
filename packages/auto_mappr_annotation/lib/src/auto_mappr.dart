import 'package:auto_mappr_annotation/src/map_type.dart';

/// Annotates class which will be used as base for generated mappr.
class AutoMappr {
  /// List of mapprs.
  final List<MapType<Object?, Object?>> mapprs;

  /// Constructs AutoMap.
  const AutoMappr(this.mapprs);
}
