import 'package:flutter/material.dart';

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

Drawer SideBar(BuildContext context) {
  return Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the drawer if there isn't enough vertical
    // space to fit everything.
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Drawer Header'),
        ),
        ListTile(
          title: const Text('Item 1'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Item 2'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
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