import 'package:auto_mappr_annotation/src/auto_mappr_interface.dart';
import 'package:auto_mappr_annotation/src/map_type.dart';
import 'package:auto_mappr_annotation/src/type_converter.dart';

/// Annotates class which will be used as base for generated mappr.
final class AutoMappr {
  /// List of mapprs.
  final List<MapType<Object, Object>> mappers;

  /// List of type converters.
  final List<TypeConverter<Object?, Object?>> converters;

  /// List of mapprs that should be included to this mappr.
  ///
  /// Imagine copy-pasting mappings from included mappr to this one.
  final List<AutoMapprInterface> includes;

  /// List of mapprs used as delegates.
  ///
  /// When current mappr cannot convert source to target,
  /// it lets modules in order try to convert it instead.
  final List<AutoMapprInterface> delegates;

  /// Constructs AutoMappr.
  const AutoMappr(
    this.mappers, {
    this.converters = const [],
    this.includes = const [],
    this.delegates = const [],
  });
}
