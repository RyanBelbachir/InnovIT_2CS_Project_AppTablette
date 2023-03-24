import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_apptablette/styles/theme.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '/widgets/video_player.dart';
import '/widgets/footer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  double progress = 0;
  Color barColor = CustomColors.blackColor;

  Future download() async {
    const url =
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4";
    final request = Request('GET', Uri.parse(url));
    final response = await Client().send(request);
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

  Widget percentage() {
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
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        const Footer(),
        Container(
          padding: Paddings.padding16,
          decoration: BoxDecoration(
            color: CustomColors.bgColor,
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            Center(child: percentage()),
            Center(
                child: IconButton(
                    onPressed: () {
                      download();
                    },
                    icon: const Icon(Icons.download))),
            Gaps.customVGap(90),
            const Video(
                url:
                    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4")
          ]),
        ),
      ]),
    ));
  }
}
