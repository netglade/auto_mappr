import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'includes/module_gama.dart';
// import 'includes/module_alpha.dart' as alpha_feature;

part 'includes.g.dart';

@AutoMappr([MapType<GroupDto, Group>()], includes: [MapprGama()])
class MapprGroup extends $MapprGroup {
  const MapprGroup();
}

class GroupDto {
  // final AlphaDto alpha;
  // final BetaDto beta;
  final GamaDto gama;

  const GroupDto(this.gama);
}

class Group with EquatableMixin {
  // final Alpha alpha;
  // final Beta beta;
  final Gama gama;

  @override
  List<Object?> get props => [gama];

  const Group(this.gama);
}
