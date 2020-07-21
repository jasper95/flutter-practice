import 'package:flutter/material.dart';
// import 'package:todo_practice/locator.dart';
// import 'package:todo_practice/repositories/todo.dart';

class StartupProvider extends ChangeNotifier {
  // TodoRepository _todoRepository = locator<TodoRepository>();
  // Stream<LoadingInfo> get stream async* {
  //   yield LoadingInfo(desc: 'Initializing...', percent: 20);
  //   await Future.delayed(const Duration(seconds: 3));
  //   yield LoadingInfo(desc: 'Initializing2...', percent: 20);
  //   // // print('wew');
  //   // yield LoadingInfo(desc: 'Loading stuff..', percent: 50);
  //   // await _todoRepository.init();
  //   // yield LoadingInfo(desc: 'Loading repository', percent: 20);
  // }
}

class LoadingInfo {
  final String desc;
  final double percent;
  LoadingInfo({this.desc, this.percent});
}
