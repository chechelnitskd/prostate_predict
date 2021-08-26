import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:flutter/cupertino.dart';
import '../functions/loading.dart';
import 'data_constants.dart';
import 'database_helpers.dart';

class UserHistory extends ChangeNotifier {

  int numRisksCalculated = 0;
  int totalRiskOptions = 3;

  bool risk1Calculated = false;
  bool risk2Calculated = false;
  bool risk3Calculated = false;

  int getNumRisksCalc() => numRisksCalculated;
  int getTotalRisks() => totalRiskOptions;
  double getPercent() => (1.0 * numRisksCalculated) / totalRiskOptions;

  //not sure if making them ? is the best way
  int? id;
  String? riskType;
  double? riskScore;
  int? date;

  UserHistory();
  //this.id, this.word, this.frequency

  // convenience constructor to create a Word object
  UserHistory.fromMap(Map<String, dynamic> map) {
    this.id = map[columnId];
    this.riskType = map[columnRiskType];
    this.riskScore = map[columnRiskScore];
    //this.date = map[columnDate];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnRiskType: riskType,
      columnRiskScore: riskScore,
      //columnDate: date,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
  read() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    // TODO: make the rowID update?
    int rowId = 1;
    UserHistory entry = await helper.queryEntry(rowId);
    if (entry.id == null) {
      print('read row $rowId: empty');
    } else {
      print('read row $rowId: ${entry.riskType} ${entry.riskScore}');
    }
  }

  save(String riskType, double riskScore) async {
    UserHistory entry = UserHistory();
    entry.riskType = riskType;
    entry.riskScore = riskScore;
    entry.date = DateTime.now().millisecondsSinceEpoch;
    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.insert(entry);
    entry.id = id;
    print('inserted row: $id');
  }

  printAll() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    List<UserHistory> history = await helper.queryAllHistory();
    for (var i = 0; i < history.length; i++) {
      print("ID: ${history[i].id}, Word: ${history[i].riskType}\n");
    }
    print("done");
  }
}

class UserHealthData extends ChangeNotifier {

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