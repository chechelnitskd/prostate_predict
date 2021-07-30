import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
//import 'package:prostate_predict/screens/form_screen.dart';
import 'package:prostate_predict/calculations.dart';
import 'form_screen.dart';
import 'package:provider/provider.dart';
import '../user_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// is it better to getAge() here? or just use resultsScreen to print stuff out
class ResultsScreen extends StatefulWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen>
    with TickerProviderStateMixin {
  late List<charts.Series<Pollution, String>> _seriesData;
  late List<charts.Series<Risk, int>> _seriesLineData;
  late TabController _tabController;
  //maybe implement as a dictionary
  int? age;
  int? psa;
/*  int? tStage;
  int? gradeGroup;
  int? treatmentType;
  int? ppcBiopsy;
  int? brca;
  int? comorbidity;*/
  //for testing below:
  int tStage = 1; // only between 1 and 4
  int gradeGroup = 1;
  int treatmentType = 0;
  double ppcBiopsy = 0;
  int brca = 1; // 1 for true, 0 for false
  int comorbidity = 0;

  //come back to this
  _generateData() {
    var linesalesdata = [
      new Risk(
          1,
          double.parse(applyStaticModel(
                  yrs: 1,
                  age: 65,
                  psa: 12,
                  tStage: tStage,
                  gradeGroup: gradeGroup,
                  treatmentType: treatmentType,
                  ppcBiopsy: ppcBiopsy,
                  brca: brca,
                  comorbidity: comorbidity))
              .round()),
      new Risk(
          5,
          double.parse(applyStaticModel(
                  yrs: 5,
                  age: 65,
                  psa: 12,
                  tStage: tStage,
                  gradeGroup: gradeGroup,
                  treatmentType: treatmentType,
                  ppcBiopsy: ppcBiopsy,
                  brca: brca,
                  comorbidity: comorbidity))
              .round()),
      new Risk(
          10,
          double.parse(applyStaticModel(
                  yrs: 10,
                  age: 65,
                  psa: 12,
                  tStage: tStage,
                  gradeGroup: gradeGroup,
                  treatmentType: treatmentType,
                  ppcBiopsy: ppcBiopsy,
                  brca: brca,
                  comorbidity: comorbidity))
              .round()),
      new Risk(
          15,
          double.parse(applyStaticModel(
                  yrs: 15,
                  age: 65,
                  psa: 12,
                  tStage: tStage,
                  gradeGroup: gradeGroup,
                  treatmentType: treatmentType,
                  ppcBiopsy: ppcBiopsy,
                  brca: brca,
                  comorbidity: comorbidity))
              .round()),
      new Risk(
          20,
          double.parse(applyStaticModel(
                  yrs: 20,
                  age: 65,
                  psa: 12,
                  tStage: tStage,
                  gradeGroup: gradeGroup,
                  treatmentType: treatmentType,
                  ppcBiopsy: ppcBiopsy,
                  brca: brca,
                  comorbidity: comorbidity))
              .round()),
      new Risk(
          25,
          double.parse(applyStaticModel(
                  yrs: 25,
                  age: 65,
                  psa: 12,
                  tStage: tStage,
                  gradeGroup: gradeGroup,
                  treatmentType: treatmentType,
                  ppcBiopsy: ppcBiopsy,
                  brca: brca,
                  comorbidity: comorbidity))
              .round()),
    ];

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Air Pollution',
        data: linesalesdata,
        domainFn: (Risk sales, _) => sales.yearval,
        measureFn: (Risk sales, _) => sales.percent,
      ),
    );
  }

  bool setAllFactors(BuildContext context) {
    age = Provider.of<UserData>(context, listen: false).getAge();
    psa = Provider.of<UserData>(context, listen: false).getPSA();
    if (age == null || psa == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesData = <charts.Series<Pollution, String>>[];
    _seriesLineData = <charts.Series<Risk, int>>[];
    _tabController = TabController(length: 2, vsync: this);
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    loadMyModel();
    if (setAllFactors(context)) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff1976d2),
          //backgroundColor: Color(0xff308e1c),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Color(0xff9962D0),
            tabs: [
              Tab(
                icon: Icon(CupertinoIcons.checkmark_alt),
              ),
              Tab(icon: Icon(CupertinoIcons.add)),
            ],
          ),
          title: Text('Flutter Charts'),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: Center(
                    child: Column(
                  children: [
                    Spacer(flex: 3),
                    Text(
                      "15 year risk",
                    ),
                    Spacer(),
                    Text(
                      //"${100 - (log(getAgeFactor() + getPSA()) * 10)}%",
                      "${applyStaticModel(yrs: 15, age: age, psa: psa, tStage: tStage, gradeGroup: gradeGroup, treatmentType: treatmentType, ppcBiopsy: ppcBiopsy, brca: brca, comorbidity: comorbidity)}%", //getAge()
                      // can I do getAge() if I have it in the MyCustomFormState class?
                      style: TextStyle(fontSize: 80),
                    ),
                    ElevatedButton(
                        child: Text("Re-Enter Data"),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    Spacer(flex: 3),
                  ],
                )),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Risk over time',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: charts.LineChart(_seriesLineData,
                            defaultRenderer: new charts.LineRendererConfig(
                                includeArea: true, stacked: true),
                            animate: true,
                            animationDuration: Duration(seconds: 5),
                            behaviors: [
                              new charts.ChartTitle('Years',
                                  behaviorPosition:
                                      charts.BehaviorPosition.bottom,
                                  titleOutsideJustification: charts
                                      .OutsideJustification.middleDrawArea),
                              new charts.ChartTitle('Percent',
                                  behaviorPosition:
                                      charts.BehaviorPosition.start,
                                  titleOutsideJustification: charts
                                      .OutsideJustification.middleDrawArea),
                              new charts.ChartTitle(
                                '',
                                behaviorPosition: charts.BehaviorPosition.end,
                                titleOutsideJustification:
                                    charts.OutsideJustification.middleDrawArea,
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      throw ("error");
    }
  }
}

class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.year, this.place, this.quantity);
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class Risk {
  int yearval;
  int percent;

  Risk(this.yearval, this.percent);
}
