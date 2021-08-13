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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: CircularPercentIndicator(
                      radius: queryData.size.shortestSide * 0.5,
                      lineWidth: queryData.size.shortestSide * 0.05,
                      percent: .79,
                      center: new Text("8/10 Risks Calculated"),
                      progressColor: kGreen,
                    ),
                  ),
                  SizedBox(height: 60,),
                  Container(
                    height: 250,
                    child: ListView.builder(
                        itemCount: specialities.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                          return RiskSelectTile(
                            speciality: specialities[index].speciality,
                            noOfDoctors: specialities[index].noOfDoctors,
                            backColor: specialities[index].backgroundColor,
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
