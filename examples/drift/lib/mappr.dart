import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:examples_drift/db.dart';

import 'package:examples_drift/mappr.auto_mappr.dart';

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
