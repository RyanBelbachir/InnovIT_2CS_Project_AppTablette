import 'package:flutter/material.dart';
import '../styles/theme.dart';

class Unavailable extends StatelessWidget {
  final VoidCallback onRetry;

  const Unavailable({super.key, required this.onRetry});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(16),
            color: CustomColors.bgColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/alert.png",
                  height: 120,
                  width: 120,
                ),
                Gaps.customVGap(120),
                const Center(
                  child: Text(
                    "Service not available, please come back later",
                    style: Fonts.bold20Red,
                    textAlign: TextAlign.center,
                  ),
                ),
                Gaps.customVGap(45),
                TextButton(
                  style: ButtonStyle(
                      alignment: Alignment.center,
                      fixedSize: const MaterialStatePropertyAll(Size(120, 48)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )),
                      backgroundColor: const MaterialStatePropertyAll(
                          CustomColors.lightRedColor)),
                  onPressed: onRetry,
                  child: const Text(
                    'Retry',
                    style: Fonts.light14white,
                  ),
                )
              ],
            )),
      ),
    );
  }
}
