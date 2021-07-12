import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:prostate_predict/screens/home_screen.dart';
import 'package:prostate_predict/screens/form_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Prostate Cancer Risk Calculator';
    return MaterialApp(
      title: appTitle,
      home: HomeScreen(),
    );
  }
}
