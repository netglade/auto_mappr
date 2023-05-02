import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

/// Annotates class which will be used as base for generated mappr.
class AutoMappr {
  /// List of mapprs.
  final List<MapType<Object?, Object?>> mappers;

  /// Configure type mappings.
  ///
  /// Accepts a list of `Target Function(Source)` functions
  /// and or a [TypeConverter] instances.
  final List<Object> types;

  /// Constructs AutoMap.
  const AutoMappr(this.mappers, {this.types = const []});
}
