import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';
import 'package:todo_practice/datamodels/todo.dart';
import 'package:todo_practice/providers/todo_list_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'view.g.dart';

@hwidget
Widget todoListScreen(BuildContext context) {
  TodoListProvider model = Provider.of<TodoListProvider>(context);
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
            onTap: () => Navigator.pushNamed(context, '/edit', arguments: todo),
          ));
    },
    itemCount: list.length,
  );
}

void _onCheckTodo(Todo todo, TodoListProvider model) {
  model.updateTodo(todo.copy(isCompleted: !todo.isCompleted));
}

void onRemoveTodo(Todo todo, TodoListProvider model) {
  model.removeTodo(todo);
}
