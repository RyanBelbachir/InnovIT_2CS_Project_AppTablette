import 'package:flutter/material.dart';
import 'package:innovit_2cs_project_apptablette/styles/theme.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Percentage extends StatefulWidget {
  final String name;
  final double percentage;
  const Percentage({super.key, required this.name, required this.percentage});

  @override
  State<Percentage> createState() => _PercentageState();
}

class _PercentageState extends State<Percentage> {
  late Color barColor;
  @override
  void initState() {
    barColor = widget.percentage == 1
        ? CustomColors.greenColor
        : widget.percentage >= 0.3
            ? CustomColors.blackColor
            : CustomColors.redColor;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: Paddings.padding16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.name,
              style: const TextStyle(
                  color: CustomColors.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Gaps.gapH25,
            LinearPercentIndicator(
              width: (MediaQuery.of(context).size.width) * 3 / 5,
              progressColor: barColor,
              backgroundColor: Colors.grey.withOpacity(0.2),
              lineHeight: 16,
              center: Text(
                "${(widget.percentage * 100).toStringAsFixed(0)}%",
                style: TextStyle(
                    color: widget.percentage > 0.4
                        ? CustomColors.whiteColor
                        : CustomColors.blackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              barRadius: const Radius.circular(20),
              percent: widget.percentage,
            ),
          ],
        ));
  }
}
