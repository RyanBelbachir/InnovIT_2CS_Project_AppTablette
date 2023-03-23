import 'package:flutter/material.dart';
import '../styles/theme.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      bottom: 25,
      left: 0,
      right: 0,
      child: Center(
          child: Text("All rights reserved © InnovIt 2023",
              style: Fonts.regular16)),
    );
  }
}
