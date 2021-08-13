import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prostate_predict/constants.dart';
import 'package:prostate_predict/screens/riskhome_screen.dart';
import '../widgets/screen_widgets.dart';
import '../widgets/homepage_widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';


class HomePage extends StatelessWidget {
  List<RiskSelectOption> specialities = getRiskSelectOptions();
  GlobalKey<ScaffoldState> _key = GlobalKey();
  
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      key: _key,
      extendBodyBehindAppBar: true,
      appBar: HomeAppBar(context, _key),
      endDrawer: buildSideBar(context),
      backgroundColor: kYellow,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 44,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40,),
                  PercentCircle(),
                  SizedBox(height: 60,),
                  RiskListView(riskList: specialities),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
