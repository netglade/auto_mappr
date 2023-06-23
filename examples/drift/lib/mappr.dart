import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:examples_drift/db.dart';

part 'mappr.g.dart';

class TodoItem {
  final int id;
  final String title;

  TodoItem({
    required this.id,
    required this.title,
  });
}

// `Todo` class comes from Drift
@AutoMappr([MapType<Todo, TodoItem>()])
class Mappr extends $Mappr {}
