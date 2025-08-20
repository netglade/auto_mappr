import 'package:examples_freezed/freezed_example.dart';

void main() {
  final union = UserInfoUnion(loginIdentifier: 'user', email: 'test@email.com', updatedAt: DateTime.now());
  final mappr = Mappr();
  final output = mappr.convert<UserInfoUnion, UserInfoCompanion>(union);

  // ignore: avoid_print, for example purposes
  print('Type: ${output.runtimeType}');
}
