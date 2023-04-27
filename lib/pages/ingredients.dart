import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_apptablette/viewmodels/techdata.dart';
import 'package:innovit_2cs_project_apptablette/widgets/back_arrow.dart';
import 'package:innovit_2cs_project_apptablette/widgets/percentage.dart';

import '../styles/theme.dart';

class Ingredients extends StatefulWidget {
  const Ingredients({super.key});

  @override
  State<Ingredients> createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  final List<TechData> ingredients = List.from(const [
    TechData(name: "Coffee", percentage: 0.29),
    TechData(name: "Water", percentage: 0.68),
    TechData(name: "Milk", percentage: 0.74),
    TechData(name: "Sugar", percentage: 0.9),
    TechData(name: "Caccao", percentage: 0.5),
    TechData(name: "Vanilla", percentage: 0.2),
  ]);
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
                      Text("Ingredients’ levels", style: Fonts.bold24)
                    ],
                  )),
              Container(
                  height: (MediaQuery.of(context).size.height * 2) / 3,
                  width: (MediaQuery.of(context).size.width),
                  decoration: Decorations.bodyDecoration,
                  child: Padding(
                      padding: Paddings.padding16,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: ingredients
                              .map((e) => Percentage(
                                  name: e.name, percentage: e.percentage))
                              .toList()))),
            ],
          ),
          const Back()
        ]),
      ),
    );
  }
}
