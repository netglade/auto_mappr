import 'package:auto_mappr_freezed_example/freezed_example.dart';

void main() {
  final union = UserInfo(loginIdentifier: 'user', email: 'test@email.com', updatedAt: DateTime.now());
  final mappr = Mappr();
  final output = mappr.convert<UserInfo, UserInfoCompanion>(union);

  // ignore: avoid_print, for example purposes
  print('Type: ${output.runtimeType}');
}
