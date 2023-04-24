import 'package:auto_mappr_example/mappr.dart';

void main() {
  final mappr = Mappr();

  final dto = UserDto(id: 1, xname: 'user');
  final user = mappr.convert<UserDto, User>(dto);

  // ignore: avoid_print, for example purposes
  print(user);
}
