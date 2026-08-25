import 'package:examples_drift/db.dart';
import 'package:examples_drift/mappr.dart';

void main() {
  final mappr = Mappr();

  const todo = Todo(id: 1, title: 'todo', content: 'Improve code');

  final todoItem = mappr.convert<Todo, TodoItem>(todo);

  // Every field of the companion is wrapped in `Value` by the boxing function.
  final companion = mappr.convert<TodoItem, TodosCompanion>(todoItem);

  // And unwrapped again by the unboxing function.
  final backToItem = mappr.convert<TodosCompanion, TodoItem>(companion);

  // ignore: avoid_print
  print(todoItem);
  // ignore: avoid_print
  print(companion);
  // ignore: avoid_print
  print(backToItem);
}
