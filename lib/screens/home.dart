import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo_practice/model/todo_list.dart';
import 'package:todo_practice/screens/list.dart';
import 'package:todo_practice/screens/stats.dart';

enum HomeView { list, stats }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeView currentScreen = HomeView.list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      bottomNavigationBar: _buildBottomNav(context),
      floatingActionButton: _buildFloatingAction(context),
      body: _getCurrentTab(),
    );
  }

  Widget _getCurrentTab() {
    switch (currentScreen) {
      case HomeView.list:
        return TodoList();
      case HomeView.stats:
        return StatsScreen();
      default:
        return TodoList();
    }
  }

  Widget _buildAppbar(BuildContext context) {
    return AppBar(
      title: Text('Todo App'),
      actions: <Widget>[
        ScopedModelDescendant<TodoListModel>(
          builder: (context, child, model) {
            return PopupMenuButton<VisibilityFilter>(
                initialValue: model.currentFilter,
                icon: Icon(Icons.filter_list),
                onSelected: (value) => _onSelectFilter(context, value),
                itemBuilder: (_) {
                  return [
                    PopupMenuItem<VisibilityFilter>(
                        child: Text('Show All'), value: VisibilityFilter.all),
                    PopupMenuItem<VisibilityFilter>(
                        child: Text('Show Active'),
                        value: VisibilityFilter.active),
                    PopupMenuItem<VisibilityFilter>(
                        child: Text('Show Completed'),
                        value: VisibilityFilter.completed)
                  ];
                });
          },
        ),
        PopupMenuButton<TodoListAction>(
            icon: Icon(Icons.more_horiz),
            onSelected: (value) => _onSelectAction(context, value),
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

  Widget _buildFloatingAction(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.of(context).pushNamed('/new'),
      child: Icon(Icons.add),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    List<NavItem> items = [
      NavItem(icon: Icons.list, label: 'Todos', view: HomeView.list),
      NavItem(icon: Icons.star, label: 'Stats', view: HomeView.stats)
    ];
    BottomNavigationBarItem _buildNavItem(NavItem nav) {
      return BottomNavigationBarItem(
          icon: IconButton(
            icon: Icon(nav.icon),
            onPressed: _onChangeTab(nav.view),
          ),
          title: Text(nav.label));
    }

    return BottomNavigationBar(
        currentIndex: HomeView.values.indexOf(currentScreen),
        items: items.map(_buildNavItem).toList());
  }

  Function _onChangeTab(HomeView view) {
    void changeTab() {
      setState(() {
        currentScreen = view;
      });
    }

    return changeTab;
  }

  void _onSelectFilter(BuildContext context, VisibilityFilter filter) {
    TodoListModel model = TodoListModel.of(context);
    model.setCurrentFilter(filter);
  }

  void _onSelectAction(BuildContext context, TodoListAction action) {
    TodoListModel model = TodoListModel.of(context);
    model.doBulkAction(action);
  }
}

class NavItem {
  final IconData icon;
  final String label;
  final HomeView view;
  NavItem({this.icon, this.label, this.view});
}
