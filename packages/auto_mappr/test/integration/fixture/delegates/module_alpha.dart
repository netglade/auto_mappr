import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'module_beta.dart';

part 'module_alpha.g.dart';

@AutoMappr([MapType<AlphaDto, Alpha>()], delegates: [MapprBeta()])
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
