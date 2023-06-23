import 'package:auto_mappr_annotation/src/auto_mappr_interface.dart';
import 'package:auto_mappr_annotation/src/map_type.dart';

/// Annotates class which will be used as base for generated mappr.
class AutoMappr {
  /// List of mapprs.
  final List<MapType<Object?, Object?>> mappers;

  /// List of other AutoMappr classes to use as modules.
  ///
  /// When current mappr cannot convert source to target,
  /// it lets modules in order try to convert it instead.
  final List<AutoMapprInterface>? modules;

  /// Constructs AutoMappr.
  const AutoMappr(this.mappers, {this.modules});
}
