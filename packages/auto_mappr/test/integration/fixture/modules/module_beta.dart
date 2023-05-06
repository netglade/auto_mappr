import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'module_gama.dart';

part 'module_beta.g.dart';

@AutoMappr(
  [
    MapType<BetaDto, Beta>(),
  ],
  modules: [
    MapprGama(),
  ],
)
class MapprBeta extends $MapprBeta {
  const MapprBeta();
}

class BetaDto {
  final int value;

  const BetaDto(this.value);
}

class Beta with EquatableMixin {
  final int value;

  @override
  List<Object?> get props => [value];

  const Beta(this.value);
}
