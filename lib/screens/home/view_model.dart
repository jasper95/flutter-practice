import 'package:stacked/stacked.dart';
import 'package:todo_practice/locator.dart';
import 'package:todo_practice/services/todo_list.dart';

class HomeViewModel extends IndexTrackingViewModel {
  TodoListService _todoListService = locator<TodoListService>();

  get filteredList => _todoListService.filteredList;

  get updateTodo => _todoListService.updateTodo;

  get removeTodo => _todoListService.removeTodo;

  get activeCount => _todoListService.activeCount;

  get completedCount => _todoListService.completedCount;

  get currentFilter => _todoListService.currentFilter;

  void initialise() async {
    setBusy(true);
    await _todoListService.fetchList();
    setBusy(false);
  }
}
