import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_apptablette/widgets/back_arrow.dart';

import '../viewmodels/techdata.dart';
import '../styles/theme.dart';
import '../widgets/percentage.dart';

class Recipents extends StatefulWidget {
  const Recipents({super.key});

  @override
  State<Recipents> createState() => _RecipentsState();
}

class _RecipentsState extends State<Recipents> {
  final List<TechData> recipients = List.from(const [
    TechData(name: "Goblets", percentage: 0.29),
    TechData(name: "Spoons", percentage: 0.9),
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
                      Text("Recipients’ levels", style: Fonts.bold24)
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
                          children: recipients
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
