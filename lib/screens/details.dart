import 'package:flutter/material.dart';
import 'package:todo_practice/model/todo.dart';

class DetailsScreen extends StatefulWidget {
  final Todo todo;
  DetailsScreen({this.todo});
  @override
  _DetailsScreenState createState() => _DetailsScreenState(todo: todo);
}

class _DetailsScreenState extends State<DetailsScreen> {
  Map<String, dynamic> _form;
  final _formKey = GlobalKey<FormState>();

  _DetailsScreenState({Todo todo}) : _form = todo.toJson();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete), onPressed: null)
        ],
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                initialValue: _form['title'] ?? '',
                onChanged: _onChange('title'),
                // onSaved: _onSave('title'),
                decoration: InputDecoration(hintText: 'What needs to be done?'),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                initialValue: _form['description'] ?? '',
                onChanged: _onChange('description'),
                decoration: InputDecoration(hintText: 'Additional Notes...'),
                maxLines: 4,
              )
            ],
          )),
    );
  }

  Function _onChange(String key) {
    void onChange(dynamic value) {
      setState(() {
        _form[key] = value;
      });
    }

    return onChange;
  }
}
