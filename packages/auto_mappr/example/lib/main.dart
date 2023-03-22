import 'package:auto_mapper_example/equatable.dart';

void main() {
  final dto = UserDto(id: 123, name: 'Peter', age: 42);
  final mapper = Mapper();
  final output = mapper.convert<UserDto, User>(dto);

  // ignore: avoid_print, for example purposes
  print(output);
}
