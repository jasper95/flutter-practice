import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo_practice/model/todo.dart';
import 'package:todo_practice/model/todo_list.dart';
import 'package:todo_practice/screens/details.dart';

class TodoList extends StatelessWidget {
  final Key key;
  TodoList({this.key});
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TodoListModel>(
        builder: (context, child, model) {
      List<Todo> list = model.filteredList;
      return ListView.builder(
        itemBuilder: (_, index) {
          return ListTile(
            key: Key(list[index].id),
            leading: Checkbox(
                value: list[index].isCompleted,
                onChanged: (_) => _onCheckTodo(list[index], model)),
            title: Text(list[index].title),
            trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => onRemoveTodo(list[index], model)),
            subtitle: Text(list[index].description),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(todo: list[index]),
              ),
            ),
          );
        },
        itemCount: list.length,
      );
    });
  }

  void _onCheckTodo(Todo todo, TodoListModel model) {
    model.updateTodo(todo.copy(isCompleted: !todo.isCompleted));
  }

  void onRemoveTodo(Todo todo, TodoListModel model) {
    model.removeTodo(todo);
  }
}
