import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo_practice/model/todo.dart';
import 'package:todo_practice/model/todo_list.dart';

class AddTodoScreen extends StatefulWidget {
  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _form = new Map();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
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
                onSaved: _onSave('title'),
                decoration: InputDecoration(hintText: 'What needs to be done?'),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: _onSave('description'),
                decoration: InputDecoration(hintText: 'Additional Notes...'),
                maxLines: 4,
              )
            ],
          ),
        ),
      ),
      floatingActionButton:
          ScopedModelDescendant<TodoListModel>(builder: (_, __, model) {
        return FloatingActionButton(
          onPressed: () => _onValidate(context, model),
          child: Icon(Icons.add),
        );
      }),
    );
  }

  Function _onSave(String key) {
    void save(dynamic value) {
      _form[key] = value;
    }

    return save;
  }

  void _onValidate(BuildContext context, TodoListModel model) {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _form['isCompleted'] = false;
      model.addTodo(Todo.fromJson(_form));
      Navigator.of(context).pushNamed('/');
    }
  }
}
