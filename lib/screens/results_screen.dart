import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
//import 'package:prostate_predict/screens/form_screen.dart';
import 'package:prostate_predict/functions/calculations.dart';
import 'package:prostate_predict/widgets/screen_widgets.dart';
import 'form_screen.dart';
import 'home_page.dart';
import 'package:provider/provider.dart';
import '../data/user_data.dart';
import 'package:tflite/tflite.dart';
import '../functions/loading.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../widgets/screen_widgets.dart';

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

  final Loading _loading = Loading();
  final Calculations _calculations = Calculations();
  GlobalKey<ScaffoldState> _key = GlobalKey();

  bool factorsSet = false;
  //maybe implement as a dictionary
  int? age, psa;
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
      new Risk(0, double.parse(calculateRisk(0))),
      new Risk(5, double.parse(calculateRisk(5))),
      new Risk(10, double.parse(calculateRisk(10))),
      new Risk(15, double.parse(calculateRisk(15))),
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
    age = Provider.of<UserHealthData>(context, listen: false).getAge();
    psa = Provider.of<UserHealthData>(context, listen: false).getPSA();
    if (age == null || psa == null) {
      print("did not set -- input null");
      return false;
    } else {
      return true;
    }
  }

  String calculateRisk(int year) {

    return (_calculations.applyStaticModel(
                yrs: year,
                age: age,
                psa: psa,
                tStage: tStage,
                gradeGroup: gradeGroup,
                treatmentType: treatmentType,
                ppcBiopsy: ppcBiopsy,
                brca: brca,
                comorbidity: comorbidity) *
            100)
        .toStringAsFixed(2);
  }



  @override
  void initState() {
    super.initState();
    _seriesData = <charts.Series<Pollution, String>>[];
    _seriesLineData = <charts.Series<Risk, int>>[];
    _tabController = TabController(length: 2, vsync: this);
    factorsSet = setAllFactors(context);
    _generateData();

    try {
      // this ends up kind of being the same result as having it inside the build
      // function for now, because we build this every time we update the input
      _loading.loadMyModel().then((value) {
        setState(() {});
      });
    } catch (e) {
      print("Model did not load");
    }

  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    if (factorsSet) {
      return Scaffold(
        key: _key,
        appBar: AppBar(
          leading: BackButton(),
          backgroundColor: Color(0xff1976d2),
          elevation: 4,
          actions: [
            HomeButton(context),
            MenuButton(context, _key),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.purple, Colors.red],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft),
            ),
          ),
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
        endDrawer: buildSideBar(context),
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

class Risk {
  int yearval;
  double percent;

  Risk(this.yearval, this.percent);
}
