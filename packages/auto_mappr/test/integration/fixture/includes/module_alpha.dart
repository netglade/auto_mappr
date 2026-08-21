import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'module_alpha.auto_mappr.dart';
import 'module_beta.dart';

@AutoMappr([MapType<AlphaDto, Alpha>()], includes: [MapprBeta()])
class MapprAlpha extends $MapprAlpha {
  const MapprAlpha();
}

class AlphaDto {
  final int value;

  const AlphaDto(this.value);
}

class Alpha with EquatableMixin {
  final int value;

  @override
  List<Object?> get props => [value];

  const Alpha(this.value);
}
