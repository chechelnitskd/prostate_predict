//import 'package:flutter/material.dart';
import 'dart:math';
import 'screens/form_screen.dart';

int age = getAge();
int psa = getPSA();

applyStaticModel() {
  return
    (100 - (10 * log(0.003 * (pow((age / 10), 3) - 341.16)
          + (0.186 * (log(psa + (1 / 100))) + 1.636)))).toStringAsFixed(2);
}

/*
loadMyModel() async {
  await Tflite.loadModel(
    model: "assets/model_unquant.tflite",
    labels: "assets/labels.txt",
  );
  print("Loaded");
}

applyModelOnImage(File file) async {
  var res = await Tflite.runModelOnImage(
      path: file.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5
  );

  setState(() {
    _result = res;
    String str = _result![0]['label'];
    _name = str.substring(2);
    _confidence = (_result![0]['confidence']*100.0).toString().substring(0,2) + "%";
  });
}
*/


//class Model {
//  String age;
//  String PSA;

//  Model({this.age, this.PSA});

// this below uses age and psa as factors to calculate risk
//100 - (10 * log(0.003 * (pow((age / 10), 3) - 341.16) + (0.186 * (log(PSA + (1 / 100))) + 1.636)))
// print(int.parse(_ageController.text) +
//                     int.parse(_psaController.text));
//}
