import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_practice/services/authentication.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Map<String, dynamic> _form = new Map();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                onChanged: _onChange('email'),
                decoration: InputDecoration(
                    labelText: 'Email', icon: Icon(Icons.email)),
              ),
              TextFormField(
                onChanged: _onChange('password'),
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password', icon: Icon(Icons.lock)),
              ),
              RaisedButton(
                onPressed: () => _onLogin(context),
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.white,
                color: Colors.blue,
                child: new Text(
                  "Login",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Function _onChange(String key) {
    void onChange(dynamic value) {
      _form[key] = value;
    }

    return onChange;
  }

  void _onLogin(BuildContext context) {
    AuthenticationService authService =
        Provider.of<AuthenticationService>(context, listen: false);
    authService.login(_form);
  }
}
