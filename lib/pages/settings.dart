import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../styles/theme.dart';
import 'package:http/http.dart' as http;

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String machineState = "Maintenance";
  Color stateColor = CustomColors.blackColor;

  Future<void> start() async {
    final url = Uri.parse('${dotenv.env["API_URL"]}/Distributeur/state');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'identifiant': "0A1Z4",
          'idState': 1,
        }));
    if (response.statusCode == 200) {
      setState(() {
        machineState = "Active";
        stateColor = CustomColors.greenColor;
      });
      print("state active notified");
    } else {
      throw Exception('failed to set state to active: ${response.statusCode}');
    }
  }

  void stop() async {
    final url = Uri.parse('${dotenv.env["API_URL"]}/Distributeur/state');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'identifiant': "0A1Z4",
          'idState': 2,
        }));
    if (response.statusCode == 200) {
      setState(() {
        machineState = "Shutdown";
        stateColor = CustomColors.redColor;
      });
      print("state shutdown notified");
    } else {
      throw Exception(
          'failed to set state to shutdown: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: CustomColors.bgColor,
          child: Stack(children: [
            Positioned(
                top: 26,
                left: 26,
                child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                        color: CustomColors.whiteColor, shape: BoxShape.circle),
                    child: Center(
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed("/home");
                          },
                          icon: CustomIcons.backIcon),
                    ))),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("State: ", style: Fonts.bold24),
                      Text(machineState,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: stateColor)),
                    ],
                  ),
                  Gaps.customVGap(40),
                  TextButton(
                    style: ButtonStyle(
                        alignment: Alignment.center,
                        fixedSize:
                            const MaterialStatePropertyAll(Size(358, 58)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                        backgroundColor: const MaterialStatePropertyAll(
                            CustomColors.redColor)),
                    onPressed: () {
                      stop();
                      Navigator.of(context).pushNamed("/unavailable");
                    },
                    child: const Text(
                      "Stop Machine",
                      style: Fonts.bold24White,
                    ),
                  ),
                  Gaps.customVGap(40),
                  TextButton(
                    style: ButtonStyle(
                        alignment: Alignment.center,
                        fixedSize:
                            const MaterialStatePropertyAll(Size(358, 58)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                        backgroundColor: const MaterialStatePropertyAll(
                            CustomColors.greenColor)),
                    onPressed: () {
                      start();
                      Navigator.of(context).pushNamed("/home");
                    },
                    child: const Text(
                      "Start Machine",
                      style: Fonts.bold24White,
                    ),
                  ),
                  Gaps.customVGap(40),
                  TextButton(
                    style: ButtonStyle(
                        alignment: Alignment.center,
                        fixedSize:
                            const MaterialStatePropertyAll(Size(358, 58)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                        backgroundColor: const MaterialStatePropertyAll(
                            CustomColors.blackColor)),
                    onPressed: () {
                      Navigator.of(context).pushNamed("/technical-data");
                    },
                    child: const Text(
                      "Technical data",
                      style: Fonts.bold24White,
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
