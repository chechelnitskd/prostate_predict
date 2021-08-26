import 'package:flutter/material.dart';
import 'package:prostate_predict/screens/form_screen.dart';
import 'package:prostate_predict/screens/results_screen.dart';
import 'package:prostate_predict/screens/risk_history_screen.dart';
import 'package:prostate_predict/screens/riskhome_screen.dart';
import 'package:prostate_predict/screens/skin_cancer_screen.dart';
import 'package:prostate_predict/screens/skin_cancer_screen2.dart';
import 'package:provider/provider.dart';
import 'data/user_data.dart';
import 'package:prostate_predict/screens/home_page.dart';

void main() => runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserHealthData()),
          ChangeNotifierProvider(create: (context) =>UserHistory()),
        ],
        child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Prostate Cancer Risk Calculator';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      initialRoute: 'home', // try naming route without slash
      routes: {
        '/': (context) => HomePage(),
        'home': (context) => HomePage(),
        'risk_home': (context) => RiskHomeScreen(), // don't need this
        'prostate_form': (context) => FormScreen(),
        'results': (context) => ResultsScreen(),
        'risk_history': (context) => RiskHistoryScreen(),
        'skin_cancer_input': (context) => SkinCancerScreen(),
        'test2': (context) =>SkinCancerScreen2(),
      },
    );
  }
}


