import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_apptablette/pages/bonne_appetit.dart';
import 'package:innovit_2cs_project_apptablette/pages/progress.dart';
import 'package:innovit_2cs_project_apptablette/styles/theme.dart';
import 'pages/home.dart';
import 'pages/drink_details.dart';
import 'pages/settings.dart';
import 'pages/scan.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/home": (_) => const HomePage(),
        "/bonne-appetit": (_) => const BonneAppetit(),
        "/progress": (_) => const Progress(),
        "/scan": (_) => const Scan(),
        "/drink-details": (_) => const DrinkDetails(),
        "/settings": (_) => const Settings()
      },
      theme: ThemeData(
          primaryColor: const Color(0xff251201),
          fontFamily: 'Outfit',
          colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: CustomColors.blackColor,
              onPrimary: CustomColors.blackColor,
              secondary: CustomColors.expressoColor,
              onSecondary: CustomColors.expressoColor,
              error: CustomColors.redColor,
              onError: CustomColors.redColor,
              background: CustomColors.bgColor,
              onBackground: CustomColors.bgColor,
              surface: CustomColors.bgColor,
              onSurface: CustomColors.bgColor)),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
