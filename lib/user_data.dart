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
