import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

part 'mapping_to_target.g.dart';

@AutoMappr([
  MapType<OneDto, One>(),
])
class Mappr extends $Mappr {}

// ignore: must_be_immutable, for testing
class One extends Equatable {
  final int usingConstructor1;
  final String usingConstructor2;
  bool withoutConstructor1 = false;
  double withoutConstructor2 = 0;
  int withoutConstructor3 = 0;

  @override
  List<Object?> get props => [
        usingConstructor1,
        usingConstructor2,
        withoutConstructor1,
        withoutConstructor2,
        withoutConstructor3,
      ];

  One({
    required this.usingConstructor1,
    required this.usingConstructor2,
  });
}

class OneDto {
  final int usingConstructor1;
  final String usingConstructor2;
  final bool withoutConstructor1;
  final double withoutConstructor2;
  final int withoutConstructor3;

  OneDto({
    required this.usingConstructor1,
    required this.usingConstructor2,
    required this.withoutConstructor1,
    required this.withoutConstructor2,
    required this.withoutConstructor3,
  });
}
