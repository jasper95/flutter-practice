import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_practice/datamodels/todo.dart';
import 'package:todo_practice/screens/todo_form/view_model.dart';

enum TodoFormView { add, details }

class TodoFormScreen extends ViewModelBuilderWidget<TodoFormViewModel> {
  final _formKey = GlobalKey<FormState>();

  final TodoFormView view;
  final Todo todo;
  TodoFormScreen({this.view, this.todo});

  @override
  Widget builder(BuildContext context, TodoFormViewModel model, _) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                initialValue: model.form['title'],
                onChanged: model.onChange('title'),
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                initialValue: model.form['description'],
                onChanged: model.onChange('description'),
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 4,
              ),
              if (view == TodoFormView.details)
                Checkbox(
                    value: model.form['isCompleted'] ?? false,
                    onChanged: model.onChange('isCompleted'))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onValidate(context, model),
        child: Icon(Icons.save),
      ),
    );
  }

  String _getTitle() {
    switch (view) {
      case TodoFormView.add:
        return 'Add Todo';
        break;
      case TodoFormView.details:
        return 'Details';
      default:
        return '';
    }
  }

  void _onValidate(BuildContext context, TodoFormViewModel model) {
    final form = _formKey.currentState;
    if (form.validate()) {
      switch (view) {
        case TodoFormView.add:
          model.addTodo(todo);
          break;
        case TodoFormView.details:
          model.updateTodo(todo);
          break;
        default:
      }
      Navigator.of(context).pop();
    }
  }

  @override
  void onViewModelReady(TodoFormViewModel model) {
    model.initialise(todo);
  }

  @override
  TodoFormViewModel viewModelBuilder(BuildContext context) =>
      TodoFormViewModel();
}
