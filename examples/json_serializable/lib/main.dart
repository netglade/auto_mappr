import 'package:auto_mappr_json_example/serializable.dart';

void main() {
  final mappr = Mappr();
  const dto = UserDto(firstName: 'Ada', lastName: 'Lovelace');
  final converted = mappr.convert<UserDto, User>(dto);

  // ignore: avoid_print
  print(converted);
}
