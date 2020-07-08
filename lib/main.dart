import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo_practice/model/todo_list.dart';
import 'package:todo_practice/screens/add_todo.dart';
import 'package:todo_practice/screens/home.dart';

void main() {
  runApp(MyApp());
}

TodoListModel todoListModel = TodoListModel();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<TodoListModel>(
        model: todoListModel,
        child: MaterialApp(
          title: 'Title',
          initialRoute: '/',
          routes: {
            '/': (context) => HomeScreen(),
            '/new': (context) => AddTodoScreen(),
          },
        ));
  }
}
