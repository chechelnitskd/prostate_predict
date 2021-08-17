import 'package:flutter/material.dart';
import 'package:prostate_predict/ui_constants.dart';

class SideBarItem {
  String itemName;
  IconData icon;
  SideBarItem(this.itemName, this.icon);
}

class SideBar extends StatelessWidget {
  const SideBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Container(
        color: kWhite,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: kLightPurple,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Privacy Policy'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Risk History'),
              onTap: () {
                Navigator.pushNamed(context, 'risk_history');
              },
            ),
          ],
        ),
      ),
    );
  }
}