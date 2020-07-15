import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';
import 'package:todo_practice/providers/todo_list_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/foundation.dart';

part 'view.g.dart';

@hwidget
Widget statsScreen(BuildContext context) {
  TodoListProvider model = Provider.of<TodoListProvider>(context);
  int activeCount = model.activeCount;
  int completedCount = model.completedCount;
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Completed Todos'),
        Text('$completedCount'),
        Text('Active Count'),
        Text('$activeCount')
      ],
    ),
  );
}
