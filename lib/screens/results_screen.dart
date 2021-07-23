import 'package:flutter/material.dart';
import 'dart:math';
//import 'package:prostate_predict/screens/form_screen.dart';
import 'package:prostate_predict/calculations.dart';
import 'form_screen.dart';
import 'package:provider/provider.dart';
import '../user_data.dart';
import 'package:tflite/tflite.dart';


// is it better to getAge() here? or just use resultsScreen to print stuff out?
class ResultsScreen extends StatefulWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {

  //maybe implement as a dictionary
  int? age;
  int? psa;
/*  int? tStage;
  int? gradeGroup;
  int? treatmentType;
  int? ppcBiopsy;
  int? brca;
  int? comorbidity;*/
  //for testing below:
  int tStage = 1; // only between 1 and 4
  int gradeGroup = 1;
  int treatmentType = 0;
  double ppcBiopsy = 0;
  int brca = 1; // 1 for true, 0 for false
  int comorbidity =  0;

  bool setAllFactors(BuildContext context) {
    age = Provider.of<UserData>(context, listen: false).getAge();
    psa = Provider.of<UserData>(context, listen: false).getPSA();
    if (age == null || psa == null) {
      return false;
    } else {
      return true;
    }
  }

  // this ends up kind of being the same result as having it inside the build
  // function for now, because we build this every time we update the input
  @override
  void initState() {
    super.initState();
    // the .then part means that the init function waits until the model is
    // loaded before doing the first set state
    loadMyModel().then((value) {
      setState(() {});
    });
  }

  // when is this called?
  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }


  @override
  Widget build(BuildContext context) {
    //maybe throw error instead of else
    //FIX THIS
    // this doesn't work: if (setAllFactors(context) && age != null && psa != null) {
    if (setAllFactors(context)) {
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
                //"${100 - (log(getAgeFactor() + getPSA()) * 10)}%",
                "${applyStaticModel(yrs: 15, age: age, psa: psa, tStage: tStage,
                                      gradeGroup: gradeGroup, treatmentType: treatmentType,
                                      ppcBiopsy: ppcBiopsy, brca: brca, comorbidity: comorbidity)}%", //getAge()
                // can I do getAge() if I have it in the MyCustomFormState class?
                style: TextStyle(fontSize: 80),
              ),
              ElevatedButton(
                child: Text("Re-Enter Data"),
                onPressed: () {
                  Navigator.pop(context);}),
              Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  } else {
    throw("error");
    }
  }
}
