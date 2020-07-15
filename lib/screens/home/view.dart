import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';
import 'package:todo_practice/providers/todo_list_provider.dart';
import 'package:todo_practice/screens/list/view.dart';
import 'package:todo_practice/screens/stats/view.dart';
import 'package:todo_practice/services/todo_list.dart';
import 'package:flutter/foundation.dart';

part 'view.g.dart';

@hwidget
Widget homeScreen(BuildContext context) {
  TodoListProvider model = Provider.of<TodoListProvider>(context);
  useEffect(() {
    Future.microtask(() => model.fetchList());
  }, []);
  return Scaffold(
    appBar: _buildAppbar(context, model),
    bottomNavigationBar: _buildBottomNav(context, model),
    floatingActionButton: _buildFloatingAction(context),
    body: PageTransitionSwitcher(
      duration: const Duration(milliseconds: 300),
      reverse: model.reverse,
      transitionBuilder: (
        Widget child,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return SharedAxisTransition(
          child: child,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
        );
      },
      child: _getCurrentTab(model.currentIndex),
    ),
  );
}

Widget _buildAppbar(BuildContext context, TodoListProvider model) {
  return AppBar(
    title: Text('Todo App'),
    actions: <Widget>[
      PopupMenuButton<VisibilityFilter>(
          initialValue: model.currentFilter,
          icon: Icon(Icons.filter_list),
          onSelected: model.setCurrentFilter,
          itemBuilder: (_) {
            return [
              PopupMenuItem<VisibilityFilter>(
                  child: Text('Show All'), value: VisibilityFilter.all),
              PopupMenuItem<VisibilityFilter>(
                  child: Text('Show Active'), value: VisibilityFilter.active),
              PopupMenuItem<VisibilityFilter>(
                  child: Text('Show Completed'),
                  value: VisibilityFilter.completed)
            ];
          }),
      PopupMenuButton<TodoListAction>(
          icon: Icon(Icons.more_horiz),
          onSelected: model.doBulkAction,
          itemBuilder: (_) {
            return [
              PopupMenuItem(
                  child: Text('Mark all incomplete'),
                  value: TodoListAction.markAllIncomplete),
              PopupMenuItem(
                  child: Text('Clear Completed'),
                  value: TodoListAction.clearCompleted),
            ];
          }),
    ],
  );
}

Widget _buildBottomNav(BuildContext context, TodoListProvider model) {
  List<NavItem> items = [
    NavItem(icon: Icons.list, label: 'Todos'),
    NavItem(icon: Icons.star, label: 'Stats')
  ];
  BottomNavigationBarItem _buildNavItem(NavItem nav) {
    return BottomNavigationBarItem(
        icon: Icon(nav.icon), title: Text(nav.label));
  }

  return BottomNavigationBar(
      onTap: model.setIndex,
      currentIndex: model.currentIndex,
      items: items.map(_buildNavItem).toList());
}

dynamic _getCurrentTab(int index) {
  switch (index) {
    case 0:
      return TodoListScreen();
    case 1:
      return StatsScreen();
    default:
      return TodoListScreen();
  }
}

Widget _buildFloatingAction(BuildContext context) {
  return FloatingActionButton(
    onPressed: () => Navigator.of(context).pushNamed('/new'),
    child: Icon(Icons.add),
  );
}

class NavItem {
  final IconData icon;
  final String label;
  NavItem({this.icon, this.label});
}
