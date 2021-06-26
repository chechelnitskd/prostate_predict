import 'package:prostate_predict/form_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hey guys',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: FormScreen(),
    );
  }
}
