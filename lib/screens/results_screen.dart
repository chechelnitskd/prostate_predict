import 'package:flutter/material.dart';
import 'form_screen.dart';

class ResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Spacer(flex: 3),
              Text(
                "Score",
              ),
              Spacer(),
              Text(
                "${10}%", //getAge()
              ),
              ElevatedButton(
                child: Text("test"),
                onPressed: () {
                  Navigator.pop(context);}),
              Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  }
}
