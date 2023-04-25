import 'package:auto_mappr_injectable_example/getit.dart';
import 'package:auto_mappr_injectable_example/mappr.dart';

void main() {
  configureDependencies();
  final instance = getIt<Mappr>();
  final dto = UserDto(id: 1, name: 'joe');
  final user = instance.convert<UserDto, User>(dto);

  // ignore: avoid_print
  print(user.name);
}
