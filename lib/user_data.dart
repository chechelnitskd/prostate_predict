import 'package:flutter/cupertino.dart';

class UserData extends ChangeNotifier {
  int? age;
  int? psa;
  int? tStage;
  int? gradeGroup;
  int? treatmentType;
  int? ppcBiopsy;
  int? brca;
  int? comorbidity;

  //int age = 0;
  // int psa = 0;
  // int tStage = 1;
  // int gradeGroup = 1;
  // int treatmentType = 0;
  // int ppcBiopsy = 0;
  // int brca = 0;
//  int comorbidity = 0;

  getAge() => age;
  setAge(int newAge) {
    age = newAge;
    notifyListeners();
  }

  getPSA() => psa;
  setPSA(int newPSA) {
    psa = newPSA;
    notifyListeners();
  }

  getTStage() => tStage;
  setTStage(int newTStage) {
    tStage = newTStage;
    notifyListeners();
  }

  getGradeGroup() => gradeGroup;
  setGradeGroup(int newGG) {
    gradeGroup = newGG;
    notifyListeners();
  }

  getTreatmentType() => treatmentType;
  setTreatmentType(int newTreatment) {
    treatmentType = newTreatment;
    notifyListeners();
  }

  getPPCBiopsy() => ppcBiopsy;
  setPPCBiopsy(int newPPC) {
    ppcBiopsy = newPPC;
    notifyListeners();
  }

  getBRCA() => brca;
  setBRCA(int newBR) {
    brca = newBR;
    notifyListeners();
  }

  getComorbidity() => comorbidity;
  setComorbidity(int newCom) {
    comorbidity = newCom;
    notifyListeners();
  }
}
