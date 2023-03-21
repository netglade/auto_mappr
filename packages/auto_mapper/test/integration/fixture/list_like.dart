import 'package:auto_mapper_annotation/auto_mapper.dart';
import 'package:equatable/equatable.dart';

part 'list_like.g.dart';

@AutoMapper([
  // From List
  MapType<ListHolder, ListHolder>(),
  MapType<ListHolder, SetHolder>(),
  MapType<ListHolder, IterableHolder>(),
  // From Set
  MapType<SetHolder, ListHolder>(),
  MapType<SetHolder, SetHolder>(),
  MapType<SetHolder, IterableHolder>(),
  // From Iterable
  MapType<IterableHolder, ListHolder>(),
  MapType<IterableHolder, SetHolder>(),
  MapType<IterableHolder, IterableHolder>(),
])
class Mapper extends $Mapper {}

class ListHolder extends Equatable {
  final List<int> value;

  @override
  List<Object?> get props => [value];

  const ListHolder(this.value);
}

class SetHolder extends Equatable {
  final Set<int> value;

  @override
  List<Object?> get props => [value];

  const SetHolder(this.value);
}

class IterableHolder extends Equatable {
  final Iterable<int> value;

  @override
  List<Object?> get props => [value];

  const IterableHolder(this.value);
}
