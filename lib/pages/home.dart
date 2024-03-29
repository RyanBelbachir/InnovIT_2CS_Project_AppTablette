import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:innovit_2cs_project_apptablette/widgets/footer.dart';
import '../widgets/tabs.dart';
import '../viewmodels/drink.dart';
import '../styles/theme.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:http/http.dart' as http;
import '../utils/functions.dart';

Future<List<Drink>> fetchDrinks() async {
  final url = Uri.parse(
      '${dotenv.env["API_URL"]}/Distributeur/drinks?distributeurId=0A1Z4');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List myList = jsonDecode(response.body);
    return myList.map((e) => Drink.fromJson(e)).toList();
  } else {
    throw Exception('failed to load drinks,error code: ${response.statusCode}');
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Drink>> drinks;
  late Future<String> codeVerou;
  @override
  void initState() {
    super.initState();
    drinks = fetchDrinks();
    codeVerou = fetchVerouCode();
  }

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
                child: FutureBuilder(
                    future: codeVerou,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return IconButton(
                            onPressed: () {
                              screenLock(
                                  title: const Text("Please enter the PIN code",
                                      style: Fonts.bold24White),
                                  footer: const Padding(
                                    padding: EdgeInsets.only(top: 64),
                                    child: Footer(),
                                  ),
                                  maxRetries: 3,
                                  context: context,
                                  correctString: snapshot.data!,
                                  onUnlocked: () {
                                    notifyMaintenanceMode();
                                    Navigator.of(context)
                                        .pushNamed("/settings");
                                  },
                                  retryDelay: const Duration(seconds: 60));
                            },
                            icon: CustomIcons.settingsIcon);
                      } else if (snapshot.hasError) {
                        return const Text("");
                      }
                      return const Text("");
                    })),
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
                      child: FutureBuilder(
                        future: drinks,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Tabs(drinks: snapshot.data!);
                          } else if (snapshot.hasError) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                  child: Text(
                                "${snapshot.error}",
                                style: Fonts.bold24Red,
                              )),
                            );
                          }
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: const Center(
                                child: CircularProgressIndicator(
                              color: CustomColors.darkCoffeeColor,
                            )),
                          );
                        },
                      ))
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
