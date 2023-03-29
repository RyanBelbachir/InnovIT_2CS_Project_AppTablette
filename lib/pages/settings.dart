import 'package:flutter/material.dart';
import '../styles/theme.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool on = true;
  String machineState = "running";
  Color stateColor = CustomColors.blackColor;
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
                    onPressed: on
                        ? () {
                            setState(() {
                              on = false;
                              machineState = "stopping...";
                              stateColor = CustomColors.redColor;
                            });
                          }
                        : null,
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
                    onPressed: !on
                        ? () {
                            setState(() {
                              on = true;
                              machineState = "starting...";
                              stateColor = CustomColors.greenColor;
                            });
                          }
                        : null,
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
