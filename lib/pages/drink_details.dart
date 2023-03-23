import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_apptablette/helpers/extentions.dart';
import 'package:innovit_2cs_project_apptablette/widgets/back_arrow.dart';
import '/bussiness/drink.dart';
import '/styles/theme.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';

class DrinkDetails extends StatefulWidget {
  const DrinkDetails({super.key});

  @override
  State<DrinkDetails> createState() => _DrinkDetailsState();
}

class _DrinkDetailsState extends State<DrinkDetails> {
  late Drink drink;
  late double sugar = 2;
  @override
  void initState() {
    super.initState();
  }

  void onChanged(double newSugar) {
    setState(() {
      sugar = newSugar;
    });
  }

  void purchase() {
    Navigator.of(context).pushNamed("/scan", arguments: drink);
  }

  @override
  Widget build(BuildContext context) {
    drink = ModalRoute.of(context)!.settings.arguments as Drink;
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          ColumnSuper(
            innerDistance: -20,
            children: [
              Container(
                height: (MediaQuery.of(context).size.height * 1) / 3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          drink.imageLink,
                        ),
                        fit: BoxFit.cover)),
              ),
              Container(
                  height: (MediaQuery.of(context).size.height * 2) / 3,
                  width: (MediaQuery.of(context).size.width),
                  decoration: Decorations.bodyDecoration,
                  child: Padding(
                      padding: Paddings.padding16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(drink.name.toTitleCase(), style: Fonts.bold40),
                          Gaps.customVGap(10),
                          Text(drink.description.toTitleCase(),
                              style: Fonts.regular16),
                          Gaps.gapV25,
                          const Text("Sugar", style: Fonts.bold32),
                          Gaps.customVGap(20),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: CustomColors.expressoColor,
                              inactiveTrackColor: CustomColors.expressoColor,
                              thumbColor: CustomColors.greenColor,
                              trackHeight: 12,
                              valueIndicatorShape:
                                  const DropSliderValueIndicatorShape(),
                              valueIndicatorColor: CustomColors.expressoColor,
                              thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 15.0),
                              overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 30.0),
                            ),
                            child: Slider(
                              value: sugar,
                              max: 5,
                              onChanged: onChanged,
                              divisions: 5,
                              label: sugar == 0
                                  ? "no sugar"
                                  : sugar == 1
                                      ? "${sugar.round().toString()} spoon"
                                      : "${sugar.round().toString()} spoons",
                            ),
                          ),
                          Gaps.customVGap(48),
                          Center(
                            child: TextButton(
                                style: ButtonStyle(
                                    alignment: Alignment.center,
                                    fixedSize: const MaterialStatePropertyAll(
                                        Size(260, 58)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    )),
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                            CustomColors.greenColor)),
                                onPressed: purchase,
                                child: const Text(
                                  "Purchase",
                                  style: Fonts.bold24White,
                                )),
                          )
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
