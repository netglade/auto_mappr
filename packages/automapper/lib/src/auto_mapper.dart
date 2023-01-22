class AutoMapper {
  final bool useEquatable;
  final List<AutoMap> mappers;

  const AutoMapper({
    this.useEquatable = false,
    this.mappers = const [],
  });
}

const mapper = AutoMapper();

class AutoMap<SOURCE, TARGET> {
  /// Reverse mapping will be generated as well
  final bool reverse;
  final List<MapMember<SOURCE>> mappings;

  const AutoMap({
    this.reverse = false,
    this.mappings = const [],
  });
}

class MapMember<SOURCE> {
  final String member;
  final dynamic Function(SOURCE from)? target;
  final bool ignore;

  const MapMember({
    required this.member,
    this.target,
    this.ignore = false,
  });
}

// class ForMember<SOURCE> {
//   final dynamic Function(SOURCE) from;
// //  final MemberMapping Function<MEMBER>(MemberOption<MEMBER>) opt;

//   const ForMember(this.from);
// }

// Type _typeOf<X>() => X;

// abstract class BaseMemberOption<M, SOURCE, TARGET> {
//   final SOURCE source;
//   final TARGET target;

//   BaseMemberOption({
//     required this.source,
//     required this.target,
//   });

//   MemberMapping<M, SOURCE, TARGET> ignore() => MemberMapping(ignore: true, source: source, target: target);
// }

// class SourceMemberOption<M, SOURCE, TARGET> extends BaseMemberOption<M, SOURCE, TARGET> {
//   SourceMemberOption({required super.source, required super.target});
// }

// class TargetMemberOption<M, SOURCE, TARGET> extends BaseMemberOption<M, SOURCE, TARGET> {
//   TargetMemberOption({required super.source, required super.target});

//   MemberMapping<M, SOURCE, TARGET> mapFrom(M Function(SOURCE obj) from) => MemberMapping(
//         ignore: false,
//         customMapping: () => from(source),
//         source: source,
//         target: target,
//       );

//   MemberMapping<M, SOURCE, TARGET> map(M Function() from) => MemberMapping(
//         ignore: false,
//         customMapping: from,
//         source: source,
//         target: target,
//       );
// }

// class MemberMapping<M, SOURCE, TARGET> {
//   final SOURCE source;
//   final TARGET target;
//   final bool ignore;
//   final dynamic Function()? customMapping;

//   dynamic map(M input, dynamic target) {
//     if (ignore) return;
//   }

//   const MemberMapping({
//     required this.source,
//     required this.target,
//     required this.ignore,
//     this.customMapping,
//   });
// }

// // class MemberMappingConfig<M, SOURCE, TARGET> {
// //   final ForMember<SOURCE> member;
// //   final MemberMapping<M, SOURCE, TARGET> mapping;

// //   MemberMappingConfig({
// //     required this.member,
// //     required this.mapping,
// //   });
// // }

// typedef SourceOptionsMemberMappingFn<M, SOURCE, TARGET> = MemberMapping<M, SOURCE, TARGET> Function(
//     SourceMemberOption<M, SOURCE, TARGET> opt);

// typedef TargetOptionsMemberMappingFn<M, SOURCE, TARGET> = MemberMapping<M, SOURCE, TARGET> Function(
//     TargetMemberOption<M, SOURCE, TARGET> opt);

// /** SOURCE -> TARGET
//  *  From SOURCE we can configure
//  *    - IGNORE
//  *  For TARGET 
//  *    - IGNORE
//  *    - MAP_FROM (SOURCE)
//  */

// /// Main class for configuring mapping
// class AutoMapConfigBuilder<SOURCE, TARGET> {
//   final SOURCE sourceObject;
//   //final TARGET targetObject;

// //  final Map<String, dynamic> _from = {};
//   final Map<String, dynamic> _mapping = {};

//   AutoMapConfigBuilder(this.sourceObject);

//   // void from<M>(String from, SourceOptionsMemberMappingFn<M, SOURCE, TARGET> opt) {
//   //   _from[from] = opt;
//   // }

//   void forMember<M>(String member, TargetOptionsMemberMappingFn<M, SOURCE, TARGET> opt) {
//     _mapping[member] = opt;
//   }

//   // MemberMapping<M, SOURCE, TARGET>? processMember<M>(M member){

//   // }

//   void build(SOURCE source) {}
// }
