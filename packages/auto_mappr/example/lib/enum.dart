import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';

part 'enum.g.dart';

enum UserType { student, admin, parent }

enum PersonType { student, admin, parent, employee }

enum Vehicle implements Comparable<Vehicle> {
  car(tires: 4, passengers: 5, carbonPerKilometer: 400),
  bus(tires: 6, passengers: 50, carbonPerKilometer: 800),
  bicycle(tires: 2, passengers: 1, carbonPerKilometer: 0);

  const Vehicle({
    required this.tires,
    required this.passengers,
    required this.carbonPerKilometer,
    this.impostor = false,
  });

  final int tires;
  final int passengers;
  final int carbonPerKilometer;

  final bool impostor;

  int get carbonFootprint => (carbonPerKilometer / passengers).round();

  bool get isTwoWheeled => this == Vehicle.bicycle;

  @override
  int compareTo(Vehicle other) => carbonFootprint - other.carbonFootprint;
}

enum VehicleX implements Comparable<VehicleX> {
  car(tires: 4, passengers: 5, carbonPerKilometer: 400),
  bus(tires: 6, passengers: 50, carbonPerKilometer: 800),
  bicycle(tires: 2, passengers: 1, carbonPerKilometer: 0),
  impostor(tires: 42, passengers: 42, carbonPerKilometer: 42);

  const VehicleX({
    required this.tires,
    required this.passengers,
    required this.carbonPerKilometer,
  });

  final int tires;
  final int passengers;
  final int carbonPerKilometer;

  int get carbonFootprint => (carbonPerKilometer / passengers).round();

  bool get isTwoWheeled => this == VehicleX.bicycle;

  @override
  int compareTo(VehicleX other) => carbonFootprint - other.carbonFootprint;
}

@AutoMappr([
  MapType<UserType, PersonType>(),
  MapType<Vehicle, Vehicle>(),
  MapType<Vehicle, VehicleX>(),
  // MapType<VehicleX, Vehicle>(), // cannot be generated, not a subset
])
class Mappr extends $Mappr {}
