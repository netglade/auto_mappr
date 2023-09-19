import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'convert_iterable.auto_mappr.dart';

@AutoMappr([
  MapType<UserDto, User>(),
  MapType<UserWithDefaultDto, User>(
    whenSourceIsNull: User(
      userName: 'defaultUserName',
      age: 666,
      address: Address(street: 'defaultStreet', city: 'defaultCity', country: 'defaultCountry'),
    ),
  ),
  MapType<AddressDto, Address>(),
])
class Mappr extends $Mappr {
  const Mappr();
}

class User with EquatableMixin {
  final String userName;
  final int age;
  final Address address;

  @override
  List<Object?> get props => [userName, age, address];

  const User({
    required this.userName,
    required this.age,
    required this.address,
  });
}

class UserDto {
  final String userName;
  final int age;
  final AddressDto address;

  const UserDto({
    required this.userName,
    required this.age,
    required this.address,
  });
}

class UserWithDefaultDto {
  final String userName;
  final int age;
  final AddressDto address;

  const UserWithDefaultDto({
    required this.userName,
    required this.age,
    required this.address,
  });
}

class Address with EquatableMixin {
  final String street;
  final String city;
  final String country;

  @override
  List<Object?> get props => [street, city, country];

  const Address({
    required this.street,
    required this.city,
    required this.country,
  });
}

class AddressDto {
  final String street;
  final String city;
  final String country;

  const AddressDto({
    required this.street,
    required this.city,
    required this.country,
  });
}
