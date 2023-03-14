import 'package:auto_mapper_example/debug.dart';

void main() {
  final dto = TestDto(1, 2, 3);

  Mapper mapper = Mapper();

  final output = mapper.convert<TestDto, Test>(dto);

  print(output);
}
