import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

/// Annotates class which will be used as base for generated mappr.
class AutoMappr {
  /// List of mapprs.
  final List<MapType<Object?, Object?>> mappers;

  /// List of [TypeConverter]s.
  final List<TypeConverter<Object?, Object?>> types;

  /// Constructs AutoMap.
  const AutoMappr(this.mappers, {this.types = const []});
}
