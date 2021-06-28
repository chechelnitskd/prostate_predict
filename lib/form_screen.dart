import 'package:flutter/material.dart';

//hey guys
class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prostate Risk Calculator")),
      body: Container(
        margin: EdgeInsets.all(24),
      ),
    );
  }
}
