import 'package:flutter/material.dart';
import 'dart:math';
import 'package:prostate_predict/screens/form_screen.dart';

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
                "10 year risk",
              ),
              Spacer(),
              Text(
                "${100 - (log(getAgeFactor() + getPSA()) * 10)}%",
              ),
              Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  }
}
