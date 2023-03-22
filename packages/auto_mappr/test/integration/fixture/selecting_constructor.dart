import 'package:auto_mappr_annotation/auto_mappr.dart';
import 'package:equatable/equatable.dart';

part 'selecting_constructor.g.dart';

@AutoMappr([
  // empty
  MapType<TestEmptyDto, FinalTarget>(),
  MapType<TestEmptyDto, NonFinalTarget>(),
  // alpha
  MapType<TestAlphaDto, FinalTarget>(constructor: 'alpha'),
  MapType<TestAlphaDto, NonFinalTarget>(constructor: 'alpha'),
  // beta
  MapType<TestBetaDto, FinalTarget>(constructor: 'beta'),
  MapType<TestBetaDto, NonFinalTarget>(constructor: 'beta'),
  // gama
  MapType<TestGamaDto, FinalTarget>(constructor: 'gama'),
  MapType<TestGamaDto, NonFinalTarget>(constructor: 'gama'),
  // nonsense
  MapType<TestNonsenseDto, FinalTarget>(constructor: 'testtesttest'),
  MapType<TestNonsenseDto, NonFinalTarget>(constructor: 'testtesttest'),
])
class Mapper extends $Mapper {}

class FinalTarget extends Equatable {
  final int? a;
  final int? b;
  final int? c;

  @override
  List<Object?> get props => [a, b, c];

  const FinalTarget(this.a, this.b, this.c);

  const FinalTarget.alpha(this.a)
      : b = null,
        c = null;

  const FinalTarget.beta(this.b)
      : a = null,
        c = null;

  const FinalTarget.gama(this.c)
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
