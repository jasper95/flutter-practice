import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo_practice/model/todo.dart';

enum VisibilityFilter { all, active, completed }
enum TodoListAction { clearCompleted, markAllIncomplete }

class TodoListModel extends Model {
  List<Todo> list = [];
  VisibilityFilter currentFilter = VisibilityFilter.all;

  addTodo(Todo todo) {
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

  static TodoListModel of(BuildContext context) =>
      ScopedModel.of<TodoListModel>(context, rebuildOnChange: false);
}
