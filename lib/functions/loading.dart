import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
//import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/cupertino.dart';
import '../data/user_data.dart';

class Loading {

  Future loadMyModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/dog_cat_labels.txt",
    );
  }

  applyModelOnImage(File file) async {
    var res = await Tflite.runModelOnImage(
        path: file.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5
    );
    if (res == null) {
      print("Apply Model Failed");
    } else {
      String str = res[0]['label'];
      // not sure what name does
      String name = str.substring(2);
      var confidence = (res[0]['confidence']*100.0).toString().substring(0,2) + "%";
      return [str, name, confidence];
    }

  }

  Future getImageFromGallery(ImagePicker picker, File? image, bool isImageLoaded) async {
    var tempStore = await picker.pickImage(source: ImageSource.gallery);

    if (tempStore == null) {
      print("no image loaded\nImage null? ${image == null}");
      return;
    } else {
      isImageLoaded = true;
      image = File(tempStore.path);
      applyModelOnImage(image);
    }
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