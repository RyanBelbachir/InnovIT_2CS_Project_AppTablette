import 'package:flutter/material.dart';
import '../widgets/tabs.dart';
import '../bussiness/drink.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Drink> drinks = List.of([
    Drink("cappuccino", "A mix of cofee, milk and caccao",
        "assets/images/tree.jpg", 40.0, "coffee"),
    Drink("cappuccino", "A mix of cofee, milk and caccao",
        "assets/images/tree.jpg", 40.0, "coffee"),
    Drink("cappuccino", "A mix of cofee, milk and caccao",
        "assets/images/tree.jpg", 40.0, "milk"),
    Drink("cappuccino", "A mix of cofee, milk and caccao",
        "assets/images/tree.jpg", 40.0, "tea"),
  ]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 180, 132, 84),
      body: SafeArea(
        child: Stack(children: [
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/page2", arguments: 323);
              },
              icon: const Icon(
                Icons.settings_outlined,
                color: Colors.black,
                size: 40,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      child: Center(
                          child: Column(
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            height: 80,
                            width: 70,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text(
                            "Welcome to SmartBev",
                            style:
                                TextStyle(fontFamily: "Lobster", fontSize: 32),
                          ),
                          const Text(
                            "Please choose your hot drink",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      )),
                    ),
                  ),
                ),
                Container(
                    height: (MediaQuery.of(context).size.height * 2) / 3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.16),
                            blurRadius: 4.0,
                            spreadRadius: 0,
                            offset: const Offset(
                              0,
                              -4,
                            ),
                          )
                        ],
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20))),
                    child: Tabs(drinks: drinks))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
