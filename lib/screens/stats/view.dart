import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_practice/screens/home/view_model.dart';

class StatsScreen extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
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
}
