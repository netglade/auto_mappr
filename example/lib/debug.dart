import 'package:auto_mapper_annotation/auto_mapper.dart';
import 'package:equatable/equatable.dart';

part 'debug.g.dart';

@AutoMapper([
  MapType<TestDto, Test>(
    constructor: 'asasd',
  ),
])
class Mapper extends $Mapper {}

// ignore: must_be_immutable, for testing
class Test extends Equatable {
  int? a;
  int? b;
  int? c;

  Test(this.a, this.b, this.c);

  Test.alpha(this.a);

  Test.beta(this.b);

  Test.gama(this.c);

  @override
  List<Object?> get props => [a, b, c];
}

class TestDto {
  int a;
  int b;
  int c;

  TestDto(this.a, this.b, this.c);
}
