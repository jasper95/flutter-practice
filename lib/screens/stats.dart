import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo_practice/model/todo_list.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TodoListModel>(builder: (_, __, model) {
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
    });
  }
}
