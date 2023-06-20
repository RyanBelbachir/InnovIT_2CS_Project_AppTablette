import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:innovit_2cs_project_apptablette/styles/theme.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '/widgets/video_player.dart';
import '/widgets/footer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  bool stopVideo = false;
  late String videoUrl;
  late int commandeId;
  double progress = 0;
  Color barColor = CustomColors.blackColor;
  String? preparationError;

  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // get steps in json string format
  Future<String> getSteps(int commandeId) async {
    final url = Uri.parse(
        '${dotenv.env["API_URL"]}/Distributeur/command/steps/$commandeId');
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      //Map<String, dynamic> json = jsonDecode(response.body);
      return response.body;
    } else {
      throw Exception(
          'failed to get steps, error code: ${response.statusCode}');
    }
  }

  void handleSocketData(Socket socket, List<int> data,
      StreamSubscription<List<int>> subscription) async {
    List<int> message = data;
    String decodedMessage = String.fromCharCodes(message);
    print(decodedMessage);
    try {
      final temp = double.parse(decodedMessage);
      if (temp != 100.0) {
        setState(() {
          progress = temp / 100;
        });
      } else {
        setState(() {
          progress = 1;
          barColor = CustomColors.greenColor;
        });
        await socket.close();
        print('Connexion fermée');
        subscription.cancel(); // cancel the subscription
        Timer(const Duration(seconds: 2), () {
          Navigator.of(context).pushNamed("/bonne-appetit");
        });
      }
    } catch (e) {
      // handle errors during preparation
      setState(() {
        preparationError = decodedMessage;
        // to display the error to the user
      });
      await socket.close();
      print('Connexion fermée');
      subscription.cancel(); // cancel the subscription
      Timer(const Duration(seconds: 5), () {
        Navigator.of(context).pushNamed("/home");
      });
    }
  }

  void getProgress() async {
    final data = await getSteps(commandeId);
    const host = '172.20.10.3';
    const port = 5000;

    //final json = jsonEncode(data);

    final Socket socket = await Socket.connect(host, port);
    print('Connecté au serveur $host:$port');

// Envoyer des données au serveur
    socket.write(data);

// Recevoir la réponse du serveur
    late StreamSubscription<List<int>> socketSubscription;
    socketSubscription = socket.listen((List<int> data) {
      handleSocketData(socket, data, socketSubscription);
    });
  }

  Widget desplayPreparationError() {
    if (preparationError != null) {
      return Text(
        "preparation failed : $preparationError",
        style: Fonts.bold24Red,
        textAlign: TextAlign.center,
      );
    } else {
      return Container();
    }
  }

  Future<File> getFile(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$filename');
  }

  Widget percentageText() {
    if (progress == 1) {
      return Text("${(progress * 100).toStringAsFixed(0)}% completed",
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: CustomColors.greenColor));
    } else {
      return Text("${(progress * 100).toStringAsFixed(0)}%",
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: CustomColors.blackColor));
    }
  }

  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    videoUrl = arguments["videoUrl"];
    commandeId = arguments["commandeId"];
    if (!isInitialized) {
      isInitialized = true;
      getProgress();
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: SafeArea(
        child: Stack(children: [
          const Footer(),
          Container(
            padding: Paddings.padding16,
            decoration: BoxDecoration(
              color: CustomColors.bgColor,
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Please wait while your drink is being prepared",
                style: Fonts.bold20,
                textAlign: TextAlign.center,
              ),
              Gaps.customVGap(60),
              LinearPercentIndicator(
                progressColor: barColor,
                backgroundColor: CustomColors.whiteColor,
                lineHeight: 16,
                barRadius: const Radius.circular(20),
                percent: progress,
              ),
              Gaps.gapV16,
              Center(child: percentageText()),
              Gaps.gapV16,
              desplayPreparationError(),
              Gaps.customVGap(90),
              Video(
                url: videoUrl,
              )
            ]),
          ),
        ]),
      )),
    );
  }
}
