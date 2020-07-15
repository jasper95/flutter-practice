import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_practice/providers/todo_list_provider.dart';

class Providers extends StatelessWidget {
  final Widget child;
  Providers({this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TodoListProvider())],
      child: child,
    );
  }
}
