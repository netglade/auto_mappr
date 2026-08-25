import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:drift/drift.dart';
import 'package:examples_drift/db.dart';

import 'package:examples_drift/mappr.auto_mappr.dart';

/// Wraps a value into drift's `Value`.
Value<T> box<T>(T value) => Value(value);

/// Unwraps a value from drift's `Value`.
T unbox<T>(Value<T> value) => value.value;

class TodoItem {
  final int id;
  final String title;
  final String content;
  final int? category;

  TodoItem({
    required this.id,
    required this.title,
    required this.content,
    this.category,
  });

  @override
  String toString() => 'TodoItem($id, $title, $content, $category)';
}

@AutoMappr([
  // `Todo` is Drift's row class, so its fields are plain values.
  MapType<Todo, TodoItem>(),
  // `TodosCompanion` wraps every field in `Value`, so boxing does it for us.
  // The reverse mapping unwraps them again using `unboxing`.
  MapType<TodoItem, TodosCompanion>(boxing: box, unboxing: unbox, reverse: true),
])
class Mappr extends $Mappr {}
