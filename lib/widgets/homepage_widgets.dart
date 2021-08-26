import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:prostate_predict/ui_constants.dart';
import 'package:prostate_predict/data/user_data.dart';
import 'package:provider/provider.dart';

enum RiskCalculatorType {
  PROSTATE_CALCULATOR,
  SKIN_CANCER,
}

class RiskSelectOption{

  //String imgAssetPath;
  String speciality;
  RiskCalculatorType type;
  Color backgroundColor;
  RiskSelectOption({//required this.imgAssetPath,
    required this.speciality, required this.type,
    required this.backgroundColor});
}

class RiskSelectTile extends StatelessWidget {

  //final String imgAssetPath;
  final String speciality;
  final RiskCalculatorType type;
  final Color backColor;
  RiskSelectTile({//required this.imgAssetPath,
    required this.speciality,
    required this.type,
    required this.backColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (type == RiskCalculatorType.PROSTATE_CALCULATOR) {
          Navigator.pushNamed(context, 'prostate_form');
        }
        else if (type == RiskCalculatorType.SKIN_CANCER) {
          Navigator.pushNamed(context, 'skin_cancer_input');
        }
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
            SizedBox(height: 20,),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: kWhite,
              size: 30.0,
            ),
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
      speciality: "Prostate Cancer Risk Calculator",
      type: RiskCalculatorType.PROSTATE_CALCULATOR,
      backgroundColor: kGreen);
  specialities.add(prostateCalculator);

  RiskSelectOption skinCancerCalculator =
  new RiskSelectOption(
      speciality: "Skin Cancer Risk Calculator",
      type: RiskCalculatorType.SKIN_CANCER,
      backgroundColor: kRed);
  specialities.add(skinCancerCalculator);

  /*
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
*/
  
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
              type: riskList[index].type,
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
    Provider.of<UserHistory>(context, listen: false).getNumRisksCalc();
    int totalRiskOptions =
    Provider.of<UserHistory>(context, listen: false).getTotalRisks();
    double percentCalculated =
    Provider.of<UserHistory>(context, listen: false).getPercent();

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


