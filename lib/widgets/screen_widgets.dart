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