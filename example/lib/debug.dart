import 'package:auto_mapper_annotation/auto_mapper.dart';

part 'debug.g.dart';

@AutoMapper(
  mappers: [
    AutoMap<FirstEnumDto, FirstEnum>(),
    AutoMap<SecondEnumDto, SecondEnum>(mappings: [
      MapMember(member: 'a', rename: 'alpha'),
      MapMember(member: 'b', rename: 'beta'),
      MapMember(member: 'c', rename: 'gama'),
    ]),
  ],
)
class Mapper extends $Mapper {}

enum FirstEnum { alpha, beta, gama }

enum FirstEnumDto { alpha, beta, gama }

enum SecondEnum { a, b, c }

enum SecondEnumDto { alpha, beta, gama }
