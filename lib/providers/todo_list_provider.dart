import 'package:stacked/stacked.dart';
import 'package:todo_practice/datamodels/todo.dart';
import 'package:todo_practice/locator.dart';
import 'package:todo_practice/repositories/todo.dart';
import 'package:todo_practice/services/todo_list.dart';
import 'package:logging/logging.dart';

class TodoListProvider extends IndexTrackingViewModel {
  List<Todo> list = [];
  VisibilityFilter currentFilter = VisibilityFilter.all;
  TodoRepository _todoRepository = locator<TodoRepository>();
  final Logger _log = Logger('TodoListProvider');

  fetchList() async {
    try {
      setBusy(true);
      list = await _todoRepository.fetch();
    } catch (err) {}
    setBusy(false);
  }

  addTodo(Todo todo) {
    _log.info('addTodo | $todo');
    list = [...list, todo];
    notifyListeners();
  }

  updateTodo(Todo todo) {
    list = list.map((e) => e.id == todo.id ? todo : e).toList();
    notifyListeners();
  }

  removeTodo(Todo todo) {
    list = list.where((element) => element.id != todo.id).toList();
    notifyListeners();
  }

  setCurrentFilter(VisibilityFilter filter) {
    currentFilter = filter;
    notifyListeners();
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
    notifyListeners();
  }
}
