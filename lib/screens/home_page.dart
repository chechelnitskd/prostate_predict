import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prostate_predict/constants.dart';
import 'package:prostate_predict/screens/riskhome_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 4,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.purple, Colors.red],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft),
          ),
        ),
      ),
      backgroundColor: kSecondaryColor,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [kSecondaryColor, kGrayColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.3, 0.7])),
        child: SafeArea(
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
            ],
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
