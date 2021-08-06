import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:flutter/cupertino.dart';
import '../functions/loading.dart';

class UserData extends ChangeNotifier {

  List<HealthDataPoint> _healthDataList = [];

  Map<String, dynamic> psaData =
  {"age" : 0,
  "psa" : 0,
  "tStage" : 1,
  "gradeGroup" : 1,
  "treatmentType" : 0,
  "ppcBiopsy" : 0,
  "brca" : 0,
  "comorbidity" : 0};

  setList(List<HealthDataPoint> healthDataList) {
    _healthDataList = healthDataList;
    notifyListeners();
  }
  getList() => _healthDataList;

  getAge() => psaData['age'];
  setAge(int newAge) {
    psaData['age'] = newAge;
    notifyListeners();
  }

  getPSA() => psaData['psa'];
  setPSA(int newPSA) {
    psaData['psa'] = newPSA;
    notifyListeners();
  }

  getTStage() => psaData['tStage'];
  setTStage(int newTStage) {
    psaData['tStage'] = newTStage;
    notifyListeners();
  }

  getGradeGroup() => psaData['gradeGroup'];
  setGradeGroup(int newGG) {
    psaData['gradeGroup'] = newGG;
    notifyListeners();
  }

  getTreatmentType() => psaData['treatmentType'];
  setTreatmentType(int newTreatment) {
    psaData['treatmentType'] = newTreatment;
    notifyListeners();
  }

  getPPCBiopsy() => psaData['ppcBiopsy'];
  setPPCBiopsy(int newPPC) {
    psaData['ppcBiopsy'] = newPPC;
    notifyListeners();
  }

  getBRCA() => psaData['brca'];
  setBRCA(int newBR) {
    psaData['brca'] = newBR;
    notifyListeners();
  }

  getComorbidity() => psaData['comorbidity'];
  setComorbidity(int newCom) {
    psaData['comorbidity'] = newCom;
    notifyListeners();
  }



}