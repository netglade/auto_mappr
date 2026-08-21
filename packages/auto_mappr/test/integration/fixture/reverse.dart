import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'reverse.auto_mappr.dart';

@AutoMappr([
  MapType<PrimitiveDto, Primitive>(reverse: true),
  MapType<UserDto, User>(reverse: true),
  MapType<AddressDto, Address>(reverse: true),
  MapType<AddressDto, SpecialAddress>(
    fields: [
      Field('specialStreet', from: 'street'),
      Field('specialCity', from: 'city'),
    ],
    reverse: true,
  ),
])
class Mappr extends $Mappr {
  const Mappr();
}

// Primitive

class Primitive with EquatableMixin {
  final int number;
  final String string;

  @override
  List<Object?> get props => [number, string];

  const Primitive({required this.number, required this.string});
}

class PrimitiveDto with EquatableMixin {
  final int number;
  final String string;

  @override
  List<Object?> get props => [number, string];

  const PrimitiveDto({required this.number, required this.string});
}

// User

class User with EquatableMixin {
  final int id;
  final String name;
  final Address address;

  @override
  List<Object?> get props => [id, name, address];

  const User({required this.id, required this.name, required this.address});
}

class UserDto with EquatableMixin {
  final int id;
  final String name;
  final AddressDto address;

  @override
  List<Object?> get props => [id, name, address];

  const UserDto(this.id, {required this.name, required this.address});
}

class Address with EquatableMixin {
  final String street;
  final String city;

  @override
  List<Object?> get props => [street, city];

  const Address({required this.street, required this.city});
}

class AddressDto with EquatableMixin {
  final String street;
  final String city;

  @override
  List<Object?> get props => [street, city];

  const AddressDto({required this.street, required this.city});
}

class SpecialAddress with EquatableMixin {
  final String specialStreet;
  final String specialCity;

  @override
  List<Object?> get props => [specialStreet, specialCity];

  const SpecialAddress({required this.specialStreet, required this.specialCity});
}
