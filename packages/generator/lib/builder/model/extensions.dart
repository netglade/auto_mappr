import 'package:analyzer/dart/element/type.dart';

extension DartTypeExtension on DartType {
  bool get isSimpleType =>
      isDartCoreBool ||
      isDartCoreDouble ||
      isDartCoreInt ||
      isDartCoreString ||
      isDartCoreInt ||
      isDartCoreString ||
      isDartCoreNum;
}
