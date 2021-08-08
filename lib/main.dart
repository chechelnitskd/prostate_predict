import 'package:flutter/material.dart';
import 'package:prostate_predict/screens/riskhome_screen.dart';
import 'package:provider/provider.dart';
import 'data/user_data.dart';
import 'package:prostate_predict/screens/home_page.dart';

void main() => runApp(
    ChangeNotifierProvider(create: (context) => UserData(), child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Prostate Cancer Risk Calculator';
    return MaterialApp(
      title: appTitle,
      initialRoute: '/', // try naming route without slash
      routes: {
        '/': (context) => HomePage(),
        '/risk_home': (context) => RiskHomeScreen(),
      },
    );
  }
}
