import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
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
  // factory
  MapType<TestFactoryDto, TestFactoryNotSelected>(),
  MapType<TestFactoryDto, TestFactorySelected>(),
])
class Mappr extends $Mappr {
  const Mappr();
}

class FinalTarget with EquatableMixin {
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

class NonFinalTarget with EquatableMixin {
  int? a;
  int? b;
  int? c;

  @override
  List<Object?> get props => [a, b, c];

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

  const TestEmptyDto(this.a, this.b, this.c);
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

  const TestBetaDto(this.a, this.b, this.c);
}

class TestGamaDto {
  final int a;
  final int b;
  final int c;

  const TestGamaDto(this.a, this.b, this.c);
}

class TestNonsenseDto {
  final int a;
  final int b;
  final int c;

  const TestNonsenseDto(this.a, this.b, this.c);
}

// Factory selection

class TestFactoryNotSelected with EquatableMixin {
  final int a;
  final int b;
  final int c;

  @override
  List<Object?> get props => [a, b, c];

  TestFactoryNotSelected()
      : a = 1,
        b = 2,
        c = 3;

  TestFactoryNotSelected.one({required this.a})
      : b = 4,
        c = 5;

  TestFactoryNotSelected.two({required this.a, required this.b}) : c = 5;

  const TestFactoryNotSelected.three({
    required this.a,
    required this.b,
    required this.c,
  });

  factory TestFactoryNotSelected.factory({
    required int a,
    required int b,
    required int c,
    // ignore: avoid_unused_constructor_parameters, for test
    required int d,
    // ignore: avoid_unused_constructor_parameters, for test
    required int e,
  }) =>
      TestFactoryNotSelected.three(a: a, b: b, c: c);
}

class TestFactorySelected with EquatableMixin {
  final int a;
  final int b;
  final int c;
  final int d;

  @override
  List<Object?> get props => [a, b, c, d];

  TestFactorySelected._one({
    required this.a,
    required this.b,
    required this.c,
  }) : d = 1;

  TestFactorySelected._two({
    required this.a,
    required this.b,
    required this.c,
  }) : d = 2;

  TestFactorySelected._three({
    required this.a,
    required this.b,
    required this.c,
  }) : d = 3;

  factory TestFactorySelected.alpha({
    required int a,
    required int b,
    required int c,
    // ignore: avoid_unused_constructor_parameters, for test
    required int d,
  }) =>
      TestFactorySelected._one(a: a, b: b, c: c);

  factory TestFactorySelected.fromJson({
    required int a,
    required int b,
    required int c,
    // ignore: avoid_unused_constructor_parameters, for test
    required int d,
    // ignore: avoid_unused_constructor_parameters, for test
    required int e,
  }) =>
      TestFactorySelected._three(a: a, b: b, c: c);

  factory TestFactorySelected.beta({
    required int a,
    required int b,
    required int c,
  }) =>
      TestFactorySelected._two(a: a, b: b, c: c);
}

class TestFactoryDto {
  final int a;
  final int b;
  final int c;
  final int d;

  const TestFactoryDto({
    required this.a,
    required this.b,
    required this.c,
    required this.d,
  });
}
