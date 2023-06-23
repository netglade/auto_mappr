import 'package:examples_injectable/getit.dart';
import 'package:examples_injectable/mappr.dart';

void main() {
  configureDependencies();
  final instance = getIt<Mappr>();
  final dto = UserDto(id: 1, name: 'joe');
  final user = instance.convert<UserDto, User>(dto);

  // ignore: avoid_print
  print(user.name);
}
