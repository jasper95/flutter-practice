import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';
import 'package:todo_practice/datamodels/todo.dart';
import 'package:todo_practice/providers/todo_list_provider.dart';
import 'package:flutter/foundation.dart';

part 'view.g.dart';

enum TodoFormView { add, details }

@hwidget
Widget todoFormScreen(BuildContext context, {Todo todo, TodoFormView view}) {
  final form = useState(todo.toJson());
  TodoListProvider model = Provider.of<TodoListProvider>(context);
  final fields = form.value;
  print('$fields');
  Function _onChange(String formKey) {
    return (value) => form.value[formKey] = value;
  }

  return Scaffold(
    appBar: AppBar(
      title: Text(_getTitle(view)),
    ),
    body: Form(
      // key: _formKey,
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
              initialValue: fields['title'],
              onChanged: _onChange('title'),
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              initialValue: fields['description'],
              onChanged: _onChange('description'),
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 4,
            ),
            if (view == TodoFormView.details)
              Checkbox(
                  value: fields['isCompleted'] ?? false,
                  onChanged: _onChange('isCompleted'))
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

String _getTitle(TodoFormView view) {
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

void _onValidate(BuildContext context, TodoListProvider model) {
  // final form = _formKey.currentState;
  // if (form.validate()) {
  //   switch (view) {
  //     case TodoFormView.add:
  //       model.addTodo(todo);
  //       break;
  //     case TodoFormView.details:
  //       model.updateTodo(todo);
  //       break;
  //     default:
  //   }
  //   Navigator.of(context).pop();
  // }
}
