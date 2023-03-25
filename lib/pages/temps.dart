import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_apptablette/widgets/back_arrow.dart';
import 'package:innovit_2cs_project_apptablette/widgets/temp.dart';

import '../styles/theme.dart';

class Temps extends StatefulWidget {
  const Temps({super.key});

  @override
  State<Temps> createState() => _TempsState();
}

class _TempsState extends State<Temps> {
  final List<TempData> temperatures = const [
    TempData(component: "component1", temperature: 70, maxTemp: 60),
    TempData(component: "component2", temperature: 55, maxTemp: 60),
    TempData(component: "component3", temperature: 100, maxTemp: 90),
    TempData(component: "component4", temperature: 40, maxTemp: 50),
  ];
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
                    children: const [
                      CustomIcons.recIcon,
                      Gaps.gapV25,
                      Text("Temperatures", style: Fonts.bold24)
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
                        children: temperatures.toList(),
                      ))),
            ],
          ),
          const Back()
        ]),
      ),
    );
  }
}
