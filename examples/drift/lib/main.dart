import 'package:examples_drift/db.dart';
import 'package:examples_drift/mappr.dart';

void main() {
  final mappr = Mappr();

  const todo = Todo(id: 1, title: 'todo', content: 'Improve code');

  final todoItem = mappr.convert<Todo, TodoItem>(todo);

  // ignore: avoid_print
  print(todoItem);
}
