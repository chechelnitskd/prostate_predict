import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:flutter/cupertino.dart';
import 'package:prostate_predict/widgets/homepage_widgets.dart';
import '../functions/loading.dart';
import 'data_constants.dart';
import 'database_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends ChangeNotifier {
  int numRisksCalculated = 0;
  int totalRiskOptions = 3;

  bool PCRiskCalculated = false;
  bool SCRiskCalculated = false;
  void initPCRiskSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(prostateCancer, PCRiskCalculated);
    notifyListeners();
  }

  void updatePCRiskSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    bool temp = PCRiskCalculated;
    PCRiskCalculated = (prefs.getBool(prostateCancer) ?? false);
    // not sure if notifyListeners waits - i think it does
    if (temp == false && PCRiskCalculated == true) {
      numRisksCalculated += 1;
    }
    notifyListeners();
  }

  void initSCRiskSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(skinCancer, SCRiskCalculated);
    notifyListeners();
  }

  void updateSCRiskSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    bool temp = SCRiskCalculated;
    SCRiskCalculated = (prefs.getBool(skinCancer) ?? false);
    // not sure if notifyListeners waits - i think it does
    if (temp == false && SCRiskCalculated == true) {
      numRisksCalculated += 1;
    }
    notifyListeners();
  }

  bool getPCRiskCalculated() => PCRiskCalculated;
  bool getSCRiskCalculated() => SCRiskCalculated;
  int getNumRisksCalc() => numRisksCalculated;
  int getTotalRisks() => totalRiskOptions;
  double getPercent() => (1.0 * numRisksCalculated) / totalRiskOptions;

}
class UserHistory extends ChangeNotifier {

  //not sure if making them ? is the best way
  int? id;
  RiskCalculatorType? riskType;
  double? riskScore;
  int? date;

  UserHistory();
  //this.id, this.word, this.frequency

  // convenience constructor to create a UserHistory object
  UserHistory.fromMap(Map<String, dynamic> map) {
    this.id = map[columnId];
    this.riskScore = map[columnRiskScore];
    if (map[columnRiskType] == prostateCancer) {
      this.riskType = RiskCalculatorType.PROSTATE_CALCULATOR;
    } else if (map[columnRiskType] == skinCancer) {
      this.riskType = RiskCalculatorType.SKIN_CANCER;
    }
    //this.date = map[columnDate];
  }

  // convenience method to create a Map from this UserHistory object
  Map<String, dynamic> toMap() {
    String riskTypeString =
      riskType == RiskCalculatorType.PROSTATE_CALCULATOR ?
      prostateCancer :
      skinCancer;

    var map = <String, dynamic>{
      columnRiskType: riskTypeString,
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

  save(RiskCalculatorType riskType, double riskScore) async {
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