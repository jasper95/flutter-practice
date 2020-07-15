import 'package:stacked/stacked.dart';
import 'package:todo_practice/datamodels/todo.dart';
import 'package:todo_practice/locator.dart';
import 'package:todo_practice/services/todo_list.dart';

class TodoFormViewModel extends BaseViewModel {
  TodoListService _todoListService = locator<TodoListService>();

  get updateTodo => _todoListService.updateTodo;

  get addTodo => _todoListService.addTodo;

  Map<String, dynamic> _form;
  get form => _form;

  void initialise(Todo todo) {
    _form = todo.toJson();
    notifyListeners();
  }

  Function onChange(String key) {
    void change(dynamic value) {
      form[key] = value;
      notifyListeners();
    }

    return change;
  }
}
