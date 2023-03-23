import 'package:flutter/material.dart';
import '../styles/theme.dart';

class Back extends StatelessWidget {
  const Back({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 26,
        left: 26,
        child: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
                color: CustomColors.whiteColor, shape: BoxShape.circle),
            child: Center(
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: CustomIcons.backIcon),
            )));
  }
}
