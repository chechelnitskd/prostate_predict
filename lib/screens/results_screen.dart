import 'package:flutter/material.dart';
import 'package:prostate_predict/form_screen.dart';

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
                "${getPSA()}",
              ),
              Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  }
}
