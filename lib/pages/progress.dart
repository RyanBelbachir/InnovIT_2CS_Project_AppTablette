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
  late String videoUrl;
  late int commandeId;
  double progress = 0;
  Color barColor = CustomColors.blackColor;

  void testSteps() async {
    await getSteps(1).then((value) => print(value));
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

  void getProgress() async {
    const host = '169.254.118.150';
    const port = 5000;
    //final data = {'message': 'Hello, Raspberry Pi!'};
    final data = await getSteps(commandeId);

    //final json = jsonEncode(data);

    Socket.connect(host, port).then((client) {
      print('Connecté au Raspberry Pi');
      client.write(data);
      client.listen((data) {
        print('Données reçues du Raspberry Pi : $data');
        client.close();
      });

      client.done.then((_) {
        print('Déconnecté du Raspberry Pi');
      });
    });
  }

  Future download() async {
    const url =
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4";
    final request = http.Request('GET', Uri.parse(url));
    final response = await http.Client().send(request);
    final contentLength = response.contentLength;
    final file = getFile('file.mp4');
    final bytes = <int>[];
    response.stream.listen((newBytes) {
      bytes.addAll(newBytes);
      setState(() {
        progress = bytes.length / (contentLength as num);
      });
    }, onDone: () async {
      setState(() {
        progress = 1;
        barColor = CustomColors.greenColor;
      });
      Timer(const Duration(seconds: 2), () {
        Navigator.of(context).pushNamed("/bonne-appetit");
      });
    }, onError: print, cancelOnError: true);
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
    testSteps();
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
              Center(
                  child: IconButton(
                      onPressed: () {
                        download();
                      },
                      icon: const Icon(Icons.download))),
              Gaps.customVGap(90),
              Video(url: videoUrl)
            ]),
          ),
        ]),
      )),
    );
  }
}
