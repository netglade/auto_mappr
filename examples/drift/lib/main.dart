import 'package:auto_mappr_drift_example/db.dart';
import 'package:auto_mappr_drift_example/mappr.dart';

void main() {
  final mappr = Mappr();

  const todo = Todo(id: 1, title: 'todo', content: 'Improve code');

  final todoItem = mappr.convert<Todo, TodoItem>(todo);

  // ignore: avoid_print
  print(todoItem);
}
