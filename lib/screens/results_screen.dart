import 'package:flutter/material.dart';
import 'dart:math';
//import 'package:prostate_predict/screens/form_screen.dart';
import 'package:prostate_predict/calculations.dart';
import 'form_screen.dart';


// is it better to getAge() here? or just use resultsScreen to print stuff out?

class ResultsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    loadMyModel();
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
                //"${100 - (log(getAgeFactor() + getPSA()) * 10)}%",
                "${applyStaticModel(15)}%", //getAge()
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
