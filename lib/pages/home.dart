import 'package:flutter/material.dart';
import '../widgets/tabs.dart';
import '../bussiness/drink.dart';
import '../styles/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // static data
  final List<Drink> drinks = List.of([
    Drink(
        "cappuccino",
        "An espresso-based coffee drink that originated in Italy and is traditionally prepared with steamed milk foam. Variations of the drink involve the use of cream instead of milk, using non-dairy milk substitutes and flavouring with cinnamon or chocolate powder.",
        "assets/images/cappucino.jpg",
        40.00,
        "coffee",
        "https://medium.com/podiihq/generating-qr-code-in-a-flutter-app-50de15e39830"),
    Drink(
        "cappuccino",
        "A mix of cofee, milk and caccao",
        "assets/images/cappucino.jpg",
        40.00,
        "coffee",
        "https://medium.com/podiihq/generating-qr-code-in-a-flutter-app-50de15e39830"),
    Drink(
        "cappuccino",
        "A mix of cofee, milk and caccao",
        "assets/images/cappucino.jpg",
        40.00,
        "coffee",
        "https://medium.com/podiihq/generating-qr-code-in-a-flutter-app-50de15e39830"),
    Drink(
        "cappuccino",
        "A mix of cofee, milk and caccao",
        "assets/images/cappucino.jpg",
        40.00,
        "coffee",
        "https://medium.com/podiihq/generating-qr-code-in-a-flutter-app-50de15e39830"),
    Drink(
        "cappuccino",
        "A mix of cofee, milk and caccao",
        "assets/images/cappucino.jpg",
        40.00,
        "coffee",
        "https://medium.com/podiihq/generating-qr-code-in-a-flutter-app-50de15e39830"),
    Drink(
        "cappuccino",
        "A mix of cofee, milk and caccao",
        "assets/images/cappucino.jpg",
        40.00,
        "coffee",
        "https://medium.com/podiihq/generating-qr-code-in-a-flutter-app-50de15e39830"),
    Drink(
        "cappuccino",
        "A mix of cofee, milk and caccao",
        "assets/images/cappucino.jpg",
        40.00,
        "coffee",
        "https://medium.com/podiihq/generating-qr-code-in-a-flutter-app-50de15e39830"),
    Drink(
        "cappuccino",
        "A mix of cofee, milk and caccao",
        "assets/images/cappucino.jpg",
        40.00,
        "coffee",
        "https://medium.com/podiihq/generating-qr-code-in-a-flutter-app-50de15e39830"),
    Drink(
        "cappuccino",
        "A mix of cofee, milk and caccao",
        "assets/images/cappucino.jpg",
        40.00,
        "coffee",
        "https://medium.com/podiihq/generating-qr-code-in-a-flutter-app-50de15e39830"),
    Drink(
        "cappuccino",
        "A mix of cofee, milk and caccao",
        "assets/images/cappucino.jpg",
        40.00,
        "milk",
        "https://medium.com/podiihq/generating-qr-code-in-a-flutter-app-50de15e39830"),
    Drink(
        "cappuccino",
        "A mix of cofee, milk and caccao",
        "assets/images/cappucino.jpg",
        40.00,
        "tea",
        "https://medium.com/podiihq/generating-qr-code-in-a-flutter-app-50de15e39830"),
  ]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: CustomColors.bgColor,
          child: Stack(children: [
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/settings");
                  },
                  icon: CustomIcons.settingsIcon),
            ),
            Padding(
              padding: Paddings.paddingTop16,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: Paddings.padding16,
                      child: SizedBox(
                        child: Center(
                            child: Column(
                          children: [
                            Image.asset(
                              "assets/images/logo.png",
                              height: 80,
                              width: 70,
                            ),
                            Gaps.gapV25,
                            const Text(
                              "Welcome to SmartBev",
                              style: Fonts.lobster32,
                            ),
                            const Text(
                              "Please choose your hot drink",
                              style: Fonts.medium20,
                            )
                          ],
                        )),
                      ),
                    ),
                  ),
                  Container(
                      height: (MediaQuery.of(context).size.height * 2) / 3,
                      decoration: Decorations.bodyDecoration,
                      child: Tabs(drinks: drinks))
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
