import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:todo_practice/providers/startup_provider.dart';

part 'view.g.dart';

@hwidget
Widget splash(BuildContext context) {
  StartupProvider model = Provider.of<StartupProvider>(context);
  // final snapshot = useStream(model.stream);
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[LinearProgressIndicator(value: 1), Text('wew')],
      ),
    ),
  );
}
