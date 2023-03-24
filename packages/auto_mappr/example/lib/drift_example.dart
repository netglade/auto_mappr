import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:auto_mappr_example/data.dart';

part 'drift_example.g.dart';

class TodoCategoryTarget {
  final int id;
  final String name;

  const TodoCategoryTarget({required this.id, required this.name});
}

@AutoMappr([MapType<TodoCategory, TodoCategoryTarget>()])
class Mappr extends $Mappr {}
