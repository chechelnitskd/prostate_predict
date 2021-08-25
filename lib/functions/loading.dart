import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:tflite/tflite.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/cupertino.dart';
import '../data/user_data.dart';

class Loading {

  Future loadMyModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/dog_cat_labels.txt",
    );
  }

  //List<HealthDataPoint> _healthDataList = [];

  //get healthDataList => _healthDataList;

  Future fetchDataLoading() async {
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

    /// You MUST request access to the data types before reading them
    bool accessWasGranted = await health.requestAuthorization(types);

    if (accessWasGranted) {
      try {
        /// Fetch new data
        List<HealthDataPoint> healthData =
        await health.getHealthDataFromTypes(startDate, endDate, types);

        /// Save all the new data points
        //_healthDataList.addAll(healthData);
        return HealthFactory.removeDuplicates(healthData);
      } catch (e) {
        print("Caught exception in getHealthDataFromTypes: $e");
      }

      /// Filter out duplicates
      //_healthDataList = HealthFactory.removeDuplicates(_healthDataList);

      print("yay");

    } else {
      print("Authorization not granted");
    }
  }

}