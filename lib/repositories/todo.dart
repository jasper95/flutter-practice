import 'package:injectable/injectable.dart';
import 'package:todo_practice/datamodels/todo.dart';
import 'package:todo_practice/shared/base_repository.dart';

@lazySingleton
class TodoRepository extends BaseRepository<Todo, TodoAdapter> {
  final String key = 'todos';
  final String listRoute = '/todos';
  TodoRepository() : super(adapter: TodoAdapter());

  @override
  Todo fromJson(Map<String, dynamic> data) {
    return Todo.fromJson(data);
  }
}
