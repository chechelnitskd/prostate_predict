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

Widget MenuButton(BuildContext context) {
  return IconButton(
      onPressed: () {}, icon: Icon(Icons.menu));
}

PreferredSizeWidget ColorAppBar(BuildContext context) {
  return AppBar(
    leading: BackButton(),
    backgroundColor: Colors.orange,
    elevation: 4,
    actions: [
      HomeButton(context),
      //MenuButton(context),
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

PreferredSizeWidget HomeAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    //actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
  );
}