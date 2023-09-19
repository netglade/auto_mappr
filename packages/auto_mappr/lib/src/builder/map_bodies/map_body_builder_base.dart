import 'package:auto_mappr/src/models/auto_mappr_config.dart';
import 'package:auto_mappr/src/models/type_mapping.dart';
import 'package:code_builder/code_builder.dart';

abstract class MapBodyBuilderBase {
  final AutoMapprConfig mapperConfig;
  final TypeMapping mapping;

  final void Function(TypeMapping? mapping)? usedNullableMethodCallback;

  const MapBodyBuilderBase({
    required this.mapperConfig,
    required this.mapping,
    required this.usedNullableMethodCallback,
  });

  Code build();

  bool canProcess();
}
