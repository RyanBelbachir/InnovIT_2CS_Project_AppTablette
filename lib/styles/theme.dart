import 'package:flutter/material.dart';

class CustomColors {
  // colors
  static final Color bgColor = const Color(0xffE4C49C).withOpacity(0.2);
  static const Color expressoColor = Color(0xffE4C49C);
  static const Color darkCoffeeColor = Color(0xffB48454);
  static const Color whiteColor = Color(0xffFBFBFB);
  static const Color blackColor = Color(0xff251201);
  static const Color greenColor = Color(0xff04542C);
  static const Color lightGreenColor = Color(0xff0A9A52);
  static const Color redColor = Color(0xff9A1E0D);
  static const Color lightRedColor = Color(0xffEF2F14);
}

class Borders {
  static const BorderRadius borderRadius =
      BorderRadius.all(Radius.circular(20));
}

class Fonts {
  static const TextStyle bold40 = TextStyle(
      fontFamily: "Outfit",
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: CustomColors.blackColor);
  static const TextStyle bold24 = TextStyle(
      fontFamily: "Outfit",
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: CustomColors.blackColor);
  static const TextStyle bold24White = TextStyle(
      fontFamily: "Outfit",
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: CustomColors.whiteColor);
  static const TextStyle bold24Red = TextStyle(
      fontFamily: "Outfit",
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: CustomColors.whiteColor);
  static const TextStyle bold24Green = TextStyle(
      fontFamily: "Outfit",
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: CustomColors.whiteColor);
  static const TextStyle medium20 = TextStyle(
      fontFamily: "Outfit",
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: CustomColors.blackColor);
  static const TextStyle regular20 = TextStyle(
      fontFamily: "Outfit",
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: CustomColors.blackColor);
  static const TextStyle light14 = TextStyle(
      fontFamily: "Outfit",
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: CustomColors.blackColor);
  static const TextStyle lobster32 = TextStyle(
      fontFamily: "Lobster", fontSize: 32, color: CustomColors.blackColor);
}

class Paddings {
  static const EdgeInsets paddingTop16 = EdgeInsets.only(top: 16);
  static const EdgeInsets padding16 = EdgeInsets.all(16);
  static const EdgeInsets padding8 = EdgeInsets.all(8);
}

class Gaps {
  static const Widget gap25 = SizedBox(
    height: 25,
  );
  static const Widget gap16 = SizedBox(
    height: 16,
  );
}

class Decorations {
  static Decoration cardStyle = BoxDecoration(
    color: const Color(0xffE4C49C).withOpacity(0.2),
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
          color: Colors.black.withOpacity(0.1), // shadow color
          blurRadius: 14, // shadow radius
          offset: const Offset(0, 0), // shadow offset
          spreadRadius: 0,
          blurStyle: BlurStyle.normal)
    ],
  );
  static Decoration bodyDecoration = BoxDecoration(
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
          topRight: Radius.circular(20), topLeft: Radius.circular(20)));
}

class CustomIcons {
  static const Icon backIcon = Icon(Icons.arrow_back_ios);
  static const Icon tempIcon = Icon(
    Icons.device_thermostat,
    color: CustomColors.blackColor,
    size: 62.5,
  );
  static const Icon ingsIcon = Icon(
    Icons.settings_input_component,
    color: CustomColors.blackColor,
    size: 62.5,
  );
  static const Icon recIcon = Icon(
    Icons.radio_button_checked,
    color: CustomColors.blackColor,
    size: 62.5,
  );
}
