import 'package:flutter/material.dart';
import 'package:todo_practice/locator.dart';
import 'package:todo_practice/logger.dart';
import 'package:todo_practice/datamodels/todo.dart';
import 'package:todo_practice/providers/providers.dart';
import 'package:todo_practice/screens/home/view.dart';
import 'package:todo_practice/screens/login.dart';
import 'package:todo_practice/screens/splash/view.dart';
import 'package:todo_practice/screens/todo_form/view.dart';

void main() {
  setupLogger();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Providers(
        child: MaterialApp(
      title: 'Title',
      initialRoute: '/',
      routes: {
        '/splash': (context) => HomeScreen(),
        '/': (_) => Splash(),
        '/login': (context) => LoginScreen(),
        '/new': (context) =>
            TodoFormScreen(view: TodoFormView.add, todo: Todo()),
        '/edit': (context) => TodoFormScreen(
            view: TodoFormView.details,
            todo: ModalRoute.of(context).settings.arguments),
      },
    ));
  }
}
