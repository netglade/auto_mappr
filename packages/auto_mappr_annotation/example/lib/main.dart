import 'package:auto_mappr_annotation/auto_mappr.dart';
import 'package:equatable/equatable.dart';

part 'main.g.dart';

@AutoMappr([
  MapType<UserDto, User>(),
])
class Mapper extends $Mapper {}

class User extends Equatable {
  final int age;
  final String username;

  @override
  List<Object?> get props => [username, age];

  const User({
    required this.age,
    required this.username,
  });
}

class UserDto {
  final int age;
  final String username;

  const UserDto(this.age, this.username);
}

void main() {
  const dto = UserDto(21, 'Peter');
  final mapper = Mapper();
  final output = mapper.convert<UserDto, User>(dto);

  // ignore: avoid_print, for example purposes
  print(output);
}
