import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
//import 'package:prostate_predict/screens/form_screen.dart';
import 'package:prostate_predict/calculations.dart';
import 'form_screen.dart';
import 'package:provider/provider.dart';
import '../user_data.dart';
import 'package:tflite/tflite.dart';
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
  late List<charts.Series<Sales, int>> _seriesLineData;
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

  _generateData() {
    var data1 = [
      new Pollution(1980, 'USA', 30),
      new Pollution(1980, 'Asia', 40),
      new Pollution(1980, 'Europe', 10),
    ];
    var data2 = [
      new Pollution(1985, 'USA', 100),
      new Pollution(1980, 'Asia', 150),
      new Pollution(1985, 'Europe', 80),
    ];
    var data3 = [
      new Pollution(1985, 'USA', 200),
      new Pollution(1980, 'Asia', 300),
      new Pollution(1985, 'Europe', 180),
    ];

    var linesalesdata = [
      new Sales(0, 45),
      new Sales(1, 56),
      new Sales(2, 55),
      new Sales(3, 60),
      new Sales(4, 61),
      new Sales(5, 70),
    ];
    var linesalesdata1 = [
      new Sales(0, 35),
      new Sales(1, 46),
      new Sales(2, 45),
      new Sales(3, 50),
      new Sales(4, 51),
      new Sales(5, 60),
    ];

    var linesalesdata2 = [
      new Sales(0, 20),
      new Sales(1, 24),
      new Sales(2, 25),
      new Sales(3, 40),
      new Sales(4, 45),
      new Sales(5, 60),
    ];

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2017',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2018',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff109618)),
      ),
    );

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Air Pollution',
        data: linesalesdata,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
        id: 'Air Pollution',
        data: linesalesdata1,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        id: 'Air Pollution',
        data: linesalesdata2,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
  }

  bool setAllFactors(BuildContext context) {
    age = Provider.of<UserData>(context, listen: false).getAge();
    psa = Provider.of<UserData>(context, listen: false).getPSA();
    if (age == null || psa == null) {
      print("did not set -- input null");
      return false;
    } else {
      return true;
    }
  }

  // see if we can return it just as a double rather than a string
  String calculateRisk(int year) {
    return
      (applyStaticModel(yrs: year, age: age, psa: psa, tStage: tStage,
          gradeGroup: gradeGroup, treatmentType: treatmentType,
          ppcBiopsy: ppcBiopsy, brca: brca, comorbidity: comorbidity)
      * 100)
          .toStringAsFixed(2);
  }

  // IGNORE THIS FOR NOW!
 /* Widget _riskNumbersView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
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
                        "${calculateRisk(15)}%",
                        style: TextStyle(fontSize: 80),
                      ),
                      ElevatedButton(
                          child: Text("Re-Enter Data"),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      Spacer(flex: 3),
                    ],
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  } */


  // this ends up kind of being the same result as having it inside the build
  // function for now, because we build this every time we update the input
  @override
  void initState() {
    super.initState();
    _seriesData = <charts.Series<Pollution, String>>[];
    _seriesLineData = <charts.Series<Sales, int>>[];
    _tabController = TabController(length: 2, vsync: this);
    _generateData();
    // the .then part means that the init function waits until the model is
    // loaded before doing the first set state
    loadMyModel().then((value) {
      setState(() {});
    });
  }
  
   // when is this called?
  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }


  @override
  Widget build(BuildContext context) {
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
                      "10 year risk",
                    ),
                    Spacer(),
                    Text(
                      "${calculateRisk(15)}%", //getAge()
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
                        'Sales for the first 5 years',
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
                              new charts.ChartTitle('Sales',
                                  behaviorPosition:
                                      charts.BehaviorPosition.start,
                                  titleOutsideJustification: charts
                                      .OutsideJustification.middleDrawArea),
                              new charts.ChartTitle(
                                'Departments',
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

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}
