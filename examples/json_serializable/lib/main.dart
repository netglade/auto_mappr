import 'package:examples_json_serializable/serializable.dart';

void main() {
  final mappr = Mappr();
  const dto = UserDto(firstName: 'Ada', lastName: 'Lovelace');
  final converted = mappr.convert<UserDto, User>(dto);

  // ignore: avoid_print
  print(converted);
}
