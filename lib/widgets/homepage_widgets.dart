import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:prostate_predict/constants.dart';
import 'package:prostate_predict/data/user_data.dart';
import 'package:provider/provider.dart';

class RiskSelectOption{

  //String imgAssetPath;
  String speciality;
  int noOfDoctors;
  Color backgroundColor;
  RiskSelectOption({//required this.imgAssetPath,
    required this.speciality, required this.noOfDoctors,
    required this.backgroundColor});
}

class RiskSelectTile extends StatelessWidget {

  //final String imgAssetPath;
  final String speciality;
  final int noOfDoctors;
  final Color backColor;
  RiskSelectTile({//required this.imgAssetPath,
    required this.speciality,
    required this.noOfDoctors,
    required this.backColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'prostate_form');
      },
      child: Container(
        width: 150,
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
            color: backColor,
            borderRadius: BorderRadius.circular(24)
        ),
        padding: EdgeInsets.only(top: 16,right: 16,left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(speciality, style: TextStyle(
                color: kWhite,
                fontSize: 20
            ),),
            SizedBox(height: 6,),
            Text("$noOfDoctors Doctors", style: TextStyle(
                color: kWhite,
                fontSize: 13
            ),),
            //Image.asset(imgAssetPath, height: 160,fit: BoxFit.fitHeight,)
          ],
        ),
      ),
    );
  }
}

List<RiskSelectOption> getRiskSelectOptions(){

  List<RiskSelectOption> specialities = [];//new List<SpecialityModel>();

  // Add Predict Prostate Calculator
  RiskSelectOption prostateCalculator =
  new RiskSelectOption(
      speciality: "Prostate Calculator",
      noOfDoctors: 10,
      backgroundColor: kGreen);
  specialities.add(prostateCalculator);

  // Add examples for now
  RiskSelectOption testA =
  new RiskSelectOption(
      speciality: "Heart Calculator",
      noOfDoctors: 17,
      backgroundColor: kRed);
  specialities.add(testA);

  RiskSelectOption testB =
  new RiskSelectOption(
      speciality: "Heart Specialist",
      noOfDoctors: 17,
      backgroundColor: kRed);
  specialities.add(testB);

  RiskSelectOption testC =
  new RiskSelectOption(
      speciality: "Heart Specialist",
      noOfDoctors: 17,
      backgroundColor: kGreen);
  specialities.add(testC);

  return specialities;
}

class RiskListView extends StatelessWidget {

  final List<RiskSelectOption> riskList;
  RiskListView({Key? key, required this.riskList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: ListView.builder(
          itemCount: riskList.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
            return RiskSelectTile(
              speciality: riskList[index].speciality,
              noOfDoctors: riskList[index].noOfDoctors,
              backColor: riskList[index].backgroundColor,
            );
          }),
    );
  }
}

class PercentCircle extends StatefulWidget {
  PercentCircle({Key? key}) : super(key: key);

  @override
  _PercentCircleState createState() => _PercentCircleState();
}

class _PercentCircleState extends State<PercentCircle> {

  @override
  Widget build(BuildContext context) {
    int numRisksCalculated =
    Provider.of<UserData>(context, listen: false).getNumRisksCalc();
    int totalRiskOptions =
    Provider.of<UserData>(context, listen: false).getTotalRisks();
    double percentCalculated =
    Provider.of<UserData>(context, listen: false).getPercent();

    MediaQueryData queryData = MediaQuery.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: CircularPercentIndicator(
        radius: queryData.size.shortestSide * 0.5,
        lineWidth: queryData.size.shortestSide * 0.05,
        percent: percentCalculated,
        center: new Text("$numRisksCalculated/$totalRiskOptions Risks Calculated"),
        progressColor: kGreen,
      ),
    );
  }
}


