import 'package:examples_example/equatable.dart';

void main() {
  final dto = UserDto(id: 123, name: 'Peter', age: 42);
  final mappr = Mappr();
  final output = mappr.convert<UserDto, User>(dto);

  // ignore: avoid_print, for example purposes
  print(output);
}
