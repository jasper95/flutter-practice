import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_practice/screens/home/view_model.dart';
import 'package:todo_practice/screens/list/view.dart';
import 'package:todo_practice/screens/stats/view.dart';
import 'package:todo_practice/services/todo_list.dart';

class HomeScreen extends ViewModelBuilderWidget<HomeViewModel> {
  @override
  Widget builder(BuildContext context, HomeViewModel model, Widget child) {
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

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  get createNewModelOnInsert => false;

  @override
  void onViewModelReady(HomeViewModel model) {
    model.initialise();
  }

  Widget _getCurrentTab(int index) {
    switch (index) {
      case 0:
        return TodoList();
      case 1:
        return StatsScreen();
      default:
        return TodoList();
    }
  }

  Widget _buildAppbar(BuildContext context, HomeViewModel model) {
    return AppBar(
      title: Text('Todo App'),
      actions: <Widget>[
        PopupMenuButton<VisibilityFilter>(
            initialValue: model.currentFilter,
            icon: Icon(Icons.filter_list),
            onSelected: (value) => _onSelectFilter(context, value),
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

  Widget _buildBottomNav(BuildContext context, HomeViewModel model) {
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

  void _onSelectFilter(BuildContext context, VisibilityFilter filter) {
    TodoListService model =
        Provider.of<TodoListService>(context, listen: false);
    model.setCurrentFilter(filter);
  }

  void _onSelectAction(BuildContext context, TodoListAction action) {
    TodoListService model =
        Provider.of<TodoListService>(context, listen: false);
    model.doBulkAction(action);
  }
}

class NavItem {
  final IconData icon;
  final String label;
  NavItem({this.icon, this.label});
}
