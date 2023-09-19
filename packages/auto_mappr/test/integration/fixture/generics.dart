import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'generics.auto_mappr.dart';

@AutoMappr([
  // simple
  MapType<With<num, num>, With<num, num>>(),
  MapType<With<Object, Object>, With<Object, Object>>(),
  MapType<With<int, AlphaDto<num>>, With<int, Alpha<num>>>(),
  MapType<With<String, int>, Without>(),
  MapType<With<String, int>, With<String, int>>(),
  MapType<Without, With<String, int>>(),
  // nested
  MapType<AlphaDto<num>, Alpha<num>>(),
  MapType<AlphaDto<int>, Alpha<int>>(),
  MapType<AlphaDto<String>, Alpha<String>>(),
  // collections
  MapType<ListHolder<int, AlphaDto<num>>, ListHolder<int, Alpha<num>>>(),
  MapType<SetHolder<String>, SetHolder<String>>(),
  MapType<IterableHolder<String, int>, IterableHolder<String, int>>(),
  MapType<MapHolder<String, int, bool>, MapHolder<String, int, bool>>(),
])
class Mappr extends $Mappr {
  const Mappr();
}

class AlphaDto<T> {
  final With<T, T> first;
  final int second;

  const AlphaDto(this.first, this.second);
}

class Alpha<T> extends Equatable {
  final With<T, T> first;
  final int second;

  @override
  List<Object?> get props => [first, second];

  const Alpha(this.first, this.second);
}

class With<A, B> extends Equatable {
  final A first;
  final B second;

  @override
  List<Object?> get props => [first, second];

  const With({required this.first, required this.second});
}

class Without extends Equatable {
  final String first;
  final int second;

  @override
  List<Object?> get props => [first, second];

  const Without({required this.first, required this.second});
}

// collections

class ListHolder<A, B> extends Equatable {
  final List<With<A, B>> values;

  @override
  List<Object?> get props => [values];

  const ListHolder(this.values);
}

class SetHolder<A> extends Equatable {
  final Set<With<A, A>> values;

  @override
  List<Object?> get props => [values];

  const SetHolder(this.values);
}

class IterableHolder<A, B> extends Equatable {
  final Iterable<With<A, B>> values;

  @override
  List<Object?> get props => [values];

  const IterableHolder(this.values);
}

class MapHolder<A, B, C> extends Equatable {
  final Map<A, With<B, C>> values;

  @override
  List<Object?> get props => [values];

  const MapHolder(this.values);
}
