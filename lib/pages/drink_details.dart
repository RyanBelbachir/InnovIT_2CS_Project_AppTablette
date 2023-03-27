import 'dart:convert';
import '../bussiness/commande.dart';
import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_apptablette/helpers/extentions.dart';
import 'package:innovit_2cs_project_apptablette/widgets/back_arrow.dart';
import '/bussiness/drink.dart';
import '/styles/theme.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:http/http.dart' as http;

Future<http.Response> sendSelectedDrink(
    int idRecette, int idIngredient, String quantiy) async {
  final url =
      Uri.parse('https://daf1-105-101-134-89.eu.ngrok.io/Distributeur/command');
  return http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'idRecette': idRecette,
        'idIngredient': idIngredient,
        'quantity': quantiy
      }));
}

class DrinkDetails extends StatefulWidget {
  const DrinkDetails({super.key});

  @override
  State<DrinkDetails> createState() => _DrinkDetailsState();
}

class _DrinkDetailsState extends State<DrinkDetails> {
  late Drink drink;
  Future<Commande>? commande;
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

  Future<Commande> getCommande() async {
    http.Response response =
        await sendSelectedDrink(drink.id, 1, sugar.toString());
    if (response.statusCode == 200) {
      return Commande.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get commande code :  ${response.statusCode} ');
    }
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
                        image: NetworkImage(
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
                          Gaps.customVGap(72),
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
                                onPressed: () {
                                  setState(() {
                                    commande = getCommande();
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FutureBuilder<Commande>(
                                        future: commande,
                                        builder: ((context, snapshot) {
                                          switch (snapshot.connectionState) {
                                            case ConnectionState.waiting:
                                              return Row(
                                                children: const [
                                                  SizedBox(
                                                    width: 24,
                                                    height: 24,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: CustomColors
                                                          .whiteColor,
                                                    ),
                                                  ),
                                                  Gaps.gapH25
                                                ],
                                              );

                                            case ConnectionState.none:
                                              return const Text("");
                                            case ConnectionState.active:
                                              return const Text("");
                                            case ConnectionState.done:
                                              if (snapshot.hasData) {
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback((_) {
                                                  Navigator.of(context)
                                                      .pushNamed("/scan",
                                                          arguments: snapshot
                                                              .data!.id);
                                                });

                                                return const Text("");
                                              } else if (snapshot.hasError) {
                                                return const Text("");
                                              }
                                              return const Text("");
                                          }
                                        })),
                                    const Text(
                                      "Purchase",
                                      style: Fonts.bold24White,
                                    )
                                  ],
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
