import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import '../styles/theme.dart';
import '../widgets/footer.dart';
import 'package:flutter/scheduler.dart';
import 'package:audioplayers/audioplayers.dart';

class BonneAppetit extends StatefulWidget {
  const BonneAppetit({super.key});

  @override
  State<BonneAppetit> createState() => _BonneAppetitState();
}

class _BonneAppetitState extends State<BonneAppetit> {
  late AudioPlayer player;

  void revert(BuildContext context) {
    Timer(const Duration(seconds: 10), () {
      Navigator.of(context).pushNamed("/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) => revert(context));
    player = AudioPlayer();
    player.play(AssetSource("sounds/done.mp3"));
    print("sound played");
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      const Footer(),
      Container(
        width: MediaQuery.of(context).size.width,
        padding: Paddings.padding16,
        decoration: BoxDecoration(
          color: CustomColors.bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Your drink is ready !", style: Fonts.bold24),
              Gaps.customVGap(10),
              const Text("Please retireve your drink", style: Fonts.medium20),
              Gaps.customVGap(100),
              const Text(
                "Bonne Appétit!",
                style: TextStyle(
                    fontFamily: 'Lobster',
                    fontSize: 48,
                    fontWeight: FontWeight.bold),
              ),
              SvgPicture.asset("assets/images/line.svg")
            ],
          ),
        ),
      ),
    ])));
  }
}
