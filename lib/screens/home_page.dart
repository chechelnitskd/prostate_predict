import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prostate_predict/constants.dart';
import 'package:prostate_predict/screens/riskhome_screen.dart';
import '../widgets/screen_widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';

/// Move this somewhere else later; here just for testing
class SpecialityModel{

  //String imgAssetPath;
  String speciality;
  int noOfDoctors;
  Color backgroundColor;
  SpecialityModel({//required this.imgAssetPath,
    required this.speciality, required this.noOfDoctors,
    required this.backgroundColor});
}

class SpecialistTile extends StatelessWidget {

  //final String imgAssetPath;
  final String speciality;
  final int noOfDoctors;
  final Color backColor;
  SpecialistTile({//required this.imgAssetPath,
    required this.speciality,
    required this.noOfDoctors,
    required this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              color: Colors.white,
              fontSize: 20
          ),),
          SizedBox(height: 6,),
          Text("$noOfDoctors Doctors", style: TextStyle(
              color: Colors.white,
              fontSize: 13
          ),),
          //Image.asset(imgAssetPath, height: 160,fit: BoxFit.fitHeight,)
        ],
      ),
    );
  }
}

List<SpecialityModel> getSpeciality(){

  List<SpecialityModel> specialities = [];//new List<SpecialityModel>();

  //1
  SpecialityModel specialityModel = new SpecialityModel(speciality: "Cough & Cold", noOfDoctors: 10, backgroundColor: Color(0xffFBB97C));
  specialities.add(specialityModel);
  //2
  specialities.add(new SpecialityModel(speciality: "Heart Specialist", noOfDoctors: 17, backgroundColor: Color(0xffF69383)));
  specialities.add(new SpecialityModel(speciality: "Heart Specialist", noOfDoctors: 17, backgroundColor: Color(0xffF69383)));
  specialities.add(new SpecialityModel(speciality: "Heart Specialist", noOfDoctors: 17, backgroundColor: Color(0xffF69383)));

  return specialities;
}



class HomePage extends StatelessWidget {
  List<SpecialityModel> specialities = getSpeciality();
  GlobalKey<ScaffoldState> _key = GlobalKey();
  
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      key: _key,
      extendBodyBehindAppBar: true,
      appBar: HomeAppBar(context, _key),
      endDrawer: SideBar(context),
      backgroundColor: kYellow,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Center(
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
                SizedBox(height: 20,),
                Container(
                  height: 250,
                  child: ListView.builder(
                      itemCount: specialities.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return SpecialistTile(
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(36.0),
          ),
          color: Color(0xFF46A0AE),
        ),
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(CupertinoIcons.cube),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new RiskHomeScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(CupertinoIcons.cube),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new RiskHomeScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(CupertinoIcons.cube),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new RiskHomeScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
