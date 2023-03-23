import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_apptablette/styles/theme.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '/widgets/video_player.dart';
import '../widgets/footer.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
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
            Gaps.customVGap(120),
            LinearPercentIndicator(
              progressColor: CustomColors.blackColor,
              backgroundColor: CustomColors.whiteColor,
              center: const Text(
                "80%",
                style: TextStyle(
                    color: CustomColors.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              lineHeight: 16,
              barRadius: const Radius.circular(20),
              percent: 0.8,
              animation: true,
              animationDuration: 1000,
              animateFromLastPercent: false,
            ),
            Gaps.customVGap(120),
            const Video(
                url:
                    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4")
          ]),
        ),
      ]),
    ));
  }
}
