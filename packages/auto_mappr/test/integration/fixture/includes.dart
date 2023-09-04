import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'includes/module_alpha.dart' as alpha_feature;

import 'includes.auto_mappr.dart';

@AutoMappr([MapType<GroupDto, Group>()], includes: [alpha_feature.MapprAlpha()])
class MapprGroup extends $MapprGroup {
  const MapprGroup();
}

class GroupDto {
  final alpha_feature.AlphaDto alpha;
  // final BetaDto beta;
  // final GamaDto gama;

  const GroupDto(this.alpha);
}

class Group with EquatableMixin {
  final alpha_feature.Alpha alpha;
  // final Beta beta;
  // final Gama gama;

  @override
  List<Object?> get props => [alpha];

  const Group(this.alpha);
}
