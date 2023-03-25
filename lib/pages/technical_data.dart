import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_apptablette/styles/theme.dart';
import 'package:innovit_2cs_project_apptablette/widgets/settings-card.dart';

import '../widgets/back_arrow.dart';

class TechnicalData extends StatefulWidget {
  const TechnicalData({super.key});

  @override
  State<TechnicalData> createState() => _TechnicalDataState();
}

class _TechnicalDataState extends State<TechnicalData> {
  String machineID = "dkonavijrvhfealdnas";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          ColumnSuper(
            innerDistance: -20,
            children: [
              Container(
                  height: (MediaQuery.of(context).size.height * 1) / 3,
                  width: (MediaQuery.of(context).size.width),
                  decoration: BoxDecoration(color: CustomColors.bgColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        height: 80,
                        width: 70,
                      ),
                      Gaps.gapV25,
                      Text(
                        "machine ID : $machineID",
                        style: Fonts.bold20,
                      ),
                    ],
                  )),
              Container(
                  height: (MediaQuery.of(context).size.height * 2) / 3,
                  width: (MediaQuery.of(context).size.width),
                  decoration: Decorations.bodyDecoration,
                  child: Padding(
                      padding: Paddings.padding16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SettingsCard(
                              icon: CustomIcons.ingsIcon,
                              route: "/ingredients",
                              name: "Ingredients’ levels"),
                          Gaps.gapV25,
                          SettingsCard(
                              icon: CustomIcons.recIcon,
                              route: "/recipients",
                              name: "Recipients’ levels"),
                          Gaps.gapV25,
                          SettingsCard(
                              icon: CustomIcons.tempIcon,
                              route: "/temps",
                              name: "Temperatures")
                        ],
                      ))),
            ],
          ),
          const Back()
        ]),
      ),
    );
  }
}
