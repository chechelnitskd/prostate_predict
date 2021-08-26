import 'package:flutter/material.dart';
import 'sidebar_widgets.dart';

Widget HomeButton(BuildContext context) {
  return IconButton(
    /// CHANGED THIS:
      onPressed: () {
        Navigator.of(context)
            .popUntil(ModalRoute.withName('home'));
      },
      icon: Icon(Icons.home));
}

Widget MenuButton(BuildContext context, GlobalKey<ScaffoldState> globalKey) {
  return IconButton(
      onPressed: () {
        globalKey.currentState!.openEndDrawer();
      }, icon: Icon(Icons.menu));
}

// future make this a class
PreferredSizeWidget ColorAppBar(BuildContext context, GlobalKey<ScaffoldState> globalKey) {
  return AppBar(
    leading: BackButton(),
    backgroundColor: Colors.orange,
    elevation: 4,
    actions: [
      HomeButton(context),
      MenuButton(context, globalKey),
    ],

    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.purple, Colors.red],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft),
      ),
    ),
  );
}

PreferredSizeWidget HomeAppBar(BuildContext context, GlobalKey<ScaffoldState> globalKey) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [MenuButton(context, globalKey)],
  );
}

Widget buildSideBar(BuildContext context) {
  return SideBar();
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