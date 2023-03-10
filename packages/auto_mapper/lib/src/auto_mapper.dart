//ignore_for_file: avoid-dynamic

/// Annotates class which will be used as base for genereted mapper.
class AutoMapper {
  ///
  final List<AutoMap<dynamic, dynamic>> mappers;

  /// Constructs AutoMapper.
  const AutoMapper({
    this.mappers = const [],
  });
}

/// Const for AutoMapper annotation.
// ignore: prefer-static-class, it is annotation
const mapper = AutoMapper();

/// Configured mapping from SOURCE to TARGET.
class AutoMap<SOURCE, TARGET> {
  /// Reverse mapping will be generated as well (from TARGET to SOURCE).
  ///
  /// Note that if concrete mapping from TARGET -> SOURCE is configured, reverse flag is ignored.
  final bool reverse;

  /// Configuration for TARGET's members.
  final List<MapMember<SOURCE>> mappings;

  /// Constructs mapping.
  const AutoMap({
    this.reverse = false,
    this.mappings = const [],
  });
}

/// Mapping configuration for concrete member of target class.
class MapMember<SOURCE> {
  /// Which member is mapped.
  ///
  /// It should be either name of TARGET's field OR name of TARGET's constructor.
  final String member;

  /// Custom function mapping for given [member].
  final dynamic Function(SOURCE from)? target;

  /// Given [member] should be ignored.
  ///
  /// Note that if [member] is required (or non-nullable) it is considered as error.
  final bool ignore;

  /// Constructs member mapping.
  const MapMember({
    required this.member,
    this.target,
    this.ignore = false,
  });
}
