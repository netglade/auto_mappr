import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'module_beta.auto_mappr.dart';
import 'module_gama.dart';

@AutoMappr([MapType<BetaDto, Beta>()], delegates: [MapprGama()])
class MapprBeta extends $MapprBeta {
  const MapprBeta();
}

class BetaDto {
  final int? value;

  const BetaDto(this.value);
}

class Beta with EquatableMixin {
  final int value;

  @override
  List<Object?> get props => [value];

  const Beta(this.value);
}
