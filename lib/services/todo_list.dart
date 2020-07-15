import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_practice/datamodels/todo.dart';
import 'package:logging/logging.dart';
import 'package:todo_practice/locator.dart';
import 'package:todo_practice/repositories/todo.dart';

enum VisibilityFilter { all, active, completed }
enum TodoListAction { clearCompleted, markAllIncomplete }

@lazySingleton
class TodoListService with ReactiveServiceMixin {
  List<Todo> list = [];
  VisibilityFilter currentFilter = VisibilityFilter.all;
  TodoRepository _todoRepository = locator<TodoRepository>();
  final Logger _log = Logger('TodoListService');

  TodoListService() {
    listenToReactiveValues([list, currentFilter]);
  }

  fetchList() async {
    try {
      list = await _todoRepository.fetch();
    } catch (err) {}
  }

  addTodo(Todo todo) {
    _log.info('addTodo | $todo');
    list = [...list, todo];
  }

  updateTodo(Todo todo) {
    list = list.map((e) => e.id == todo.id ? todo : e).toList();
  }

  removeTodo(Todo todo) {
    list = list.where((element) => element.id != todo.id).toList();
  }

  setCurrentFilter(VisibilityFilter filter) {
    currentFilter = filter;
  }

  List<Todo> get filteredList {
    return list.where((element) {
      switch (currentFilter) {
        case VisibilityFilter.completed:
          return element.isCompleted;
        case VisibilityFilter.active:
          return !element.isCompleted;
        default:
          return true;
      }
    }).toList();
  }

  int get completedCount {
    return list.where((element) => element.isCompleted).toList().length;
  }

  int get activeCount {
    return list.where((element) => !element.isCompleted).toList().length;
  }

  doBulkAction(TodoListAction action) {
    switch (action) {
      case TodoListAction.markAllIncomplete:
        list = list.map((element) => element.copy(isCompleted: false)).toList();
        break;
      case TodoListAction.clearCompleted:
        list = list.where((element) => !element.isCompleted).toList();
        break;
      default:
    }
  }
}
