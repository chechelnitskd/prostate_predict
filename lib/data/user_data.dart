import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:flutter/cupertino.dart';

class UserData extends ChangeNotifier {

  Map<String, dynamic> psaData =
  {"age" : 0,
  "psa" : 0,
  "tStage" : 1,
  "gradeGroup" : 1,
  "treatmentType" : 0,
  "ppcBiopsy" : 0,
  "brca" : 0,
  "comorbidity" : 0};


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


  List<HealthDataPoint> _healthDataList = [];

  Future fetchData() async {
    /// Get everything from midnight until now
    DateTime startDate = DateTime(2020, 11, 07, 0, 0, 0);
    DateTime endDate = DateTime(2025, 11, 07, 23, 59, 59);

    HealthFactory health = HealthFactory();

    /// Define the types to get.
    List<HealthDataType> types = [
      HealthDataType.STEPS,
      HealthDataType.WEIGHT,
      HealthDataType.HEIGHT,
      HealthDataType.BLOOD_GLUCOSE,
      HealthDataType.DISTANCE_WALKING_RUNNING,
    ];

    //setState(() => _state = AppState.FETCHING_DATA);

    /// You MUST request access to the data types before reading them
    bool accessWasGranted = await health.requestAuthorization(types);

    int steps = 0;

    if (accessWasGranted) {
      try {
        /// Fetch new data
        List<HealthDataPoint> healthData =
        await health.getHealthDataFromTypes(startDate, endDate, types);

        /// Save all the new data points
        _healthDataList.addAll(healthData);
      } catch (e) {
        print("Caught exception in getHealthDataFromTypes: $e");
      }

      /// Filter out duplicates
      _healthDataList = HealthFactory.removeDuplicates(_healthDataList);

      /// Print the results
      _healthDataList.forEach((x) {
        print("Data point: $x");
        steps += x.value.round();
      });

      print("Steps: $steps");

      /// Update the UI to display the results
      /*setState(() {
        _state =
        _healthDataList.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
      });*/
    } else {
      print("Authorization not granted");
      //setState(() => _state = AppState.DATA_NOT_FETCHED);
    }
  }
}