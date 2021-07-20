//import 'package:flutter/material.dart';
import 'dart:math';
import 'screens/form_screen.dart';
import 'package:tflite/tflite.dart';
import 'package:provider/provider.dart';
import 'package:meta/meta.dart';
import 'user_data.dart';

/*int age = getAge();
int psa = getPSA();
int tStage = getTStage();
int gradeGroup = getGradeGroup();
int treatmentType = getTreatmentType();
int ppcBiopsy = getPPCBiopsy();
int brca = getBRCA();
int comorbidity = getComorbidity();*/

// FOR TESTING ONLY!
int age = 50;
int psa = 5;
int tStage = 1; // only between 1 and 4
int gradeGroup = 1;
int treatmentType = 0;
double ppcBiopsy = 0;
int brca = 1; // 1 for true, 0 for false
int comorbidity = 0;

calcTStageFactor(var tStage) {
  switch (tStage) {
    case 2:
      {
        return .1614922;
      }
    case 3:
      {
        return .39767881;
      }
    case 4:
      {
        return .6330977;
      }
    default:
      {
        return 0;
      }
  }
}

calcGradeGroupFactor(var gradeGroup) {
  switch (gradeGroup) {
    case 2:
      {
        return .2791641;
      }
    case 3:
      {
        return .5464889;
      }
    case 4:
      {
        return .7411321;
      }
    case 5:
      {
        return 1.367963;
      }
    default:
      {
        return 0;
      }
  }
}

calcBRCAFactor(var brca) {
  return (brca == 1) ? 0.956 : 0;
}

calcComorbidityFactor(var comorbidity) {
  return (comorbidity == 1) ? 0.6382002 : 0;
}

calcTreatmentFactor(var treatmentType) {
  switch (treatmentType) {
    case 1:
      {
        // radical treatment
        return -.6837094;
      }
    case 3:
      {
        // androgen deprivation therapy
        return .9084921;
      }
    default:
      {
        return 0;
      }
  }
}

//FIX THIS
applyStaticModel(
    {required int yrs,
    required int? age,
    required int? psa,
    required int tStage,
    required int gradeGroup,
    required int treatmentType,
    required double ppcBiopsy,
    required int brca,
    required int comorbidity}) {
  if (age == null || psa == null) {
    throw ("NULL!");
  }

  int yrsAsDays = (yrs * 365) + (yrs % 4);

  double piNPCM =
      0.1226666 * (age - 69.87427439) + calcComorbidityFactor(comorbidity);

  double NPCM = 1 -
      exp(-1 *
          exp(piNPCM) *
          exp(-12.4841 +
              1.32274 * (log(yrsAsDays)) +
              2.90e-12 * pow(yrsAsDays, 3)));

  double piPCSM = 0.0026005 * ((pow((age / 10), 3) - 341.155151)) +
      0.185959 * (log((psa + 1) / 100) + 1.636423432) +
      calcTStageFactor(tStage) +
      calcGradeGroupFactor(gradeGroup) +
      calcTreatmentFactor(treatmentType) +
      calcBRCAFactor(brca) +
      1.890134 * (sqrt((ppcBiopsy + 0.1811159) / 100) - .649019);
  // this is v1.1 of the calculator; lower ppcBiopsy increases survival more

  double PCSM = 1 -
      exp(-1 *
          exp(piPCSM) *
          exp(-16.40532 +
              1.653947 * (log(yrsAsDays)) +
              1.89e-12 * pow(yrsAsDays, 3)));

  double PCSurvival = 1 - PCSM;
  double OtherSurvival = 1 - NPCM;

  //print("years as days: $yrsAsDays");
  //print("piNPCM: $piNPCM\nNPCM: $NPCM\npiPCSM: $piPCSM\nPCSM: $PCSM\n");
  //print("PCSurvival: $PCSurvival\nOtherSurvival: $OtherSurvival\nOverall Survival: ${PCSurvival * OtherSurvival * 100}");

  return (PCSurvival * OtherSurvival * 100).toStringAsFixed(2);
}

loadMyModel() async {
  await Tflite.loadModel(
    model: "assets/model_unquant.tflite",
    labels: "assets/labels.txt",
  );
  print("Loaded");
}
/*
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
