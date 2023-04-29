import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_apptablette/widgets/back_arrow.dart';
import 'package:innovit_2cs_project_apptablette/widgets/temp.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../styles/theme.dart';

class Temps extends StatefulWidget {
  const Temps({super.key});

  @override
  State<Temps> createState() => _TempsState();
}

class _TempsState extends State<Temps> {
  late StreamSubscription<List<int>> socketSubscription;
  late Socket socket;
  List<Map<String, dynamic>> temperatures = [];

  @override
  void initState() {
    super.initState();
    getTemps();
  }

  @override
  void dispose() async {
    super.dispose();
    socketSubscription.cancel();
    socket.close().then((value) => print('Connexion fermée'));
  }

  void getTemps() async {
    const host = '172.20.10.2';
    const port = 3000;

    socket = await Socket.connect(host, port);
    print('Connecté au serveur $host:$port');

    socketSubscription = socket.listen((List<int> data) {
      handleSocketData(socket, data, socketSubscription);
    });
  }

  void handleSocketData(Socket socket, List<int> data,
      StreamSubscription<List<int>> subscription) async {
    List<int> message = data;
    String decodedMessage = String.fromCharCodes(message);
    print(decodedMessage);
    Map<String, dynamic> json = jsonDecode(decodedMessage);
    try {
      print(json);
      setState(() {
        temperatures = (json["temperatures"] as List<dynamic>)
            .cast<Map<String, dynamic>>();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final temps = temperatures.map((temp) {
      return TempData(
          component: temp["name"], temperature: temp["level"], maxTemp: 80);
    });
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
                        children: temps.toList(),
                      ))),
            ],
          ),
          const Back()
        ]),
      ),
    );
  }
}
