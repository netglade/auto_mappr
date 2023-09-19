import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'module_gama.auto_mappr.dart';

@AutoMappr([MapType<GamaDto, Gama>()])
class MapprGama extends $MapprGama {
  const MapprGama();
}

class GamaDto {
  final int value;

  const GamaDto(this.value);
}

class Gama with EquatableMixin {
  final int value;

  @override
  List<Object?> get props => [value];

  const Gama(this.value);
}
