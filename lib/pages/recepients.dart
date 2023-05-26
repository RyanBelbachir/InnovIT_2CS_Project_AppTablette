import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_apptablette/widgets/back_arrow.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../viewmodels/techdata.dart';
import '../styles/theme.dart';
import '../widgets/percentage.dart';

class Recipents extends StatefulWidget {
  const Recipents({super.key});

  @override
  State<Recipents> createState() => _RecipentsState();
}

class _RecipentsState extends State<Recipents> {
  late StreamSubscription<List<int>> socketSubscription;
  late Socket socket;
  List<Map<String, dynamic>> recipients = [];

  @override
  void initState() {
    super.initState();
    getTechData();
  }

  @override
  void dispose() async {
    super.dispose();
    socketSubscription.cancel();
    socket.close().then((value) => print('Connexion fermée'));
  }

  void getTechData() async {
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
        recipients =
            (json["recipients"] as List<dynamic>).cast<Map<String, dynamic>>();
      });
    } catch (e) {
      socketSubscription.cancel();
      socket.close();
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final recs = recipients.map((rec) {
      return TechData(
          name: rec["name"],
          percentage: double.parse(rec["level"].toString()) / 100);
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
                          children: recs
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
