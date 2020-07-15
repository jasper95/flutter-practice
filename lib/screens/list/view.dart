import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_practice/datamodels/todo.dart';
import 'package:todo_practice/screens/home/view_model.dart';

class TodoList extends ViewModelWidget<HomeViewModel> {
  final Key key;
  TodoList({this.key});

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    List<Todo> list = model.filteredList;

    if (model.isBusy) {
      return Center(
        child: Text('Loading...'),
      );
    }
    if (list.isEmpty) {
      return Center(
        child: Text('No records'),
      );
    }
    return ListView.builder(
      itemBuilder: (_, index) {
        final Todo todo = list[index];
        return Dismissible(
            onDismissed: (_) => model.removeTodo(todo),
            key: Key(todo.id),
            child: ListTile(
              key: Key(todo.id),
              leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (_) => _onCheckTodo(todo, model)),
              title: Text(todo.title),
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => onRemoveTodo(todo, model)),
              subtitle: Text(todo.description ?? ''),
              onTap: () =>
                  Navigator.pushNamed(context, '/edit', arguments: todo),
            ));
      },
      itemCount: list.length,
    );
  }

  void _onCheckTodo(Todo todo, HomeViewModel model) {
    model.updateTodo(todo.copy(isCompleted: !todo.isCompleted));
  }

  void onRemoveTodo(Todo todo, HomeViewModel model) {
    model.removeTodo(todo);
  }
}
