import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:innovit_2cs_project_apptablette/pages/bonne_appetit.dart';
import 'package:innovit_2cs_project_apptablette/pages/progress.dart';
import 'package:innovit_2cs_project_apptablette/pages/recepients.dart';
import 'package:innovit_2cs_project_apptablette/pages/technical_data.dart';
import 'package:innovit_2cs_project_apptablette/pages/temps.dart';
import 'package:innovit_2cs_project_apptablette/pages/unavailable.dart';
import 'package:innovit_2cs_project_apptablette/styles/theme.dart';
import 'package:innovit_2cs_project_apptablette/utils/functions.dart';
import 'pages/home.dart';
import 'pages/drink_details.dart';
import 'pages/ingredients.dart';
import 'pages/settings.dart';
import 'pages/scan.dart';

Future<void> main() async {
  await dotenv.load();
  startLocationTracking();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Timer? timer;
  bool isServerAvailable = true;

  @override
  void initState() {
    super.initState();
    checkServerAvailability();
    startTimer();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 10), (_) {
      checkServerAvailability();
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  Future<void> checkServerAvailability() async {
    try {
      final response = await http
          .get(Uri.parse("${dotenv.env["API_URL"]}/Distributeur/state/0A1Z4"));
      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        if (res["response"] == true) {
          print("In service");
          setState(() {
            isServerAvailable = true;
          });
        } else {
          print("Out of service");
          setState(() {
            isServerAvailable = false;
          });
        }
      } else {
        setState(() {
          isServerAvailable = false;
        });
        throw Exception(
            'failed to check service state,error code: ${response.statusCode}');
      }
    } on http.ClientException catch (clientException) {
      // skip exception to not crash the app
      print(clientException.message);
      print("failed to check service state");
    }
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
          "/settings": (_) => const Settings(),
          "/technical-data": (_) => const TechnicalData(),
          "/recipients": (_) => const Recipents(),
          "/ingredients": (_) => const Ingredients(),
          "/temps": (_) => const Temps()
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
        home: isServerAvailable
            ? const HomePage()
            : Unavailable(onRetry: () => checkServerAvailability()));
  }
}
