import 'package:flutter/material.dart';
import 'package:prostate_predict/calculations.dart';
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
                "${applyStaticModel()}%", //getAge()
                // can I do getAge() if I have it in the MyCustomFormState class?
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
