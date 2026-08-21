import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'delegates.auto_mappr.dart';
import 'delegates/module_alpha.dart';

@AutoMappr([MapType<GroupDto, Group>()], delegates: [MapprAlpha()])
class MapprGroup extends $MapprGroup {
  const MapprGroup();
}

class GroupDto {
  final int value;

  const GroupDto(this.value);
}

class Group with EquatableMixin {
  final int value;

  @override
  List<Object?> get props => [value];

  const Group(this.value);
}
