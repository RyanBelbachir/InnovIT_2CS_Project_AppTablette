import 'package:flutter/material.dart';

import '../styles/theme.dart';

class TempData extends StatefulWidget {
  final String component;
  final int temperature;
  final int maxTemp;
  const TempData(
      {super.key,
      required this.component,
      required this.temperature,
      required this.maxTemp});

  @override
  State<TempData> createState() => _TempDataState();
}

class _TempDataState extends State<TempData> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: Paddings.padding16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.component,
              style: const TextStyle(
                  color: CustomColors.blackColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "${widget.temperature.toString()}°C",
              style: TextStyle(
                  color: widget.temperature > widget.maxTemp
                      ? CustomColors.redColor
                      : CustomColors.greenColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ));
  }
}
