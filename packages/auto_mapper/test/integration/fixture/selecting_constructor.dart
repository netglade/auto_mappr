import 'package:auto_mapper_annotation/auto_mapper.dart';
import 'package:equatable/equatable.dart';

part 'selecting_constructor.g.dart';

@AutoMapper(mappers: [
  // empty
  AutoMap<TestEmptyDto, FinalTarget>(),
  AutoMap<TestEmptyDto, NonFinalTarget>(),
  // alpha
  AutoMap<TestAlphaDto, FinalTarget>(constructor: 'alpha'),
  AutoMap<TestAlphaDto, NonFinalTarget>(constructor: 'alpha'),
  // beta
  AutoMap<TestBetaDto, FinalTarget>(constructor: 'beta'),
  AutoMap<TestBetaDto, NonFinalTarget>(constructor: 'beta'),
  // gama
  AutoMap<TestGamaDto, FinalTarget>(constructor: 'gama'),
  AutoMap<TestGamaDto, NonFinalTarget>(constructor: 'gama'),
  // nonsense
  AutoMap<TestNonsenseDto, FinalTarget>(constructor: 'testtesttest'),
  AutoMap<TestNonsenseDto, NonFinalTarget>(constructor: 'testtesttest'),
])
class Mapper extends $Mapper {}

class FinalTarget extends Equatable {
  final int? a;
  final int? b;
  final int? c;

  @override
  List<Object?> get props => [a, b, c];

  FinalTarget(this.a, this.b, this.c);

  FinalTarget.alpha(this.a)
      : b = null,
        c = null;

  FinalTarget.beta(this.b)
      : a = null,
        c = null;

  FinalTarget.gama(this.c)
      : a = null,
        b = null;
}

class NonFinalTarget {
  int? a;
  int? b;
  int? c;

  NonFinalTarget(this.a, this.b, this.c);

  NonFinalTarget.alpha(this.a)
      : b = null,
        c = null;

  NonFinalTarget.beta(this.b)
      : a = null,
        c = null;

  NonFinalTarget.gama(this.c)
      : a = null,
        b = null;
}

class TestEmptyDto {
  final int a;
  final int b;
  final int c;

  TestEmptyDto(this.a, this.b, this.c);
}

class TestAlphaDto {
  int a;
  int b;
  int c;

  TestAlphaDto(this.a, this.b, this.c);
}

class TestBetaDto {
  final int a;
  final int b;
  final int c;

  TestBetaDto(this.a, this.b, this.c);
}

class TestGamaDto {
  final int a;
  final int b;
  final int c;

  TestGamaDto(this.a, this.b, this.c);
}

class TestNonsenseDto {
  final int a;
  final int b;
  final int c;

  TestNonsenseDto(this.a, this.b, this.c);
}
