import 'package:flutter/material.dart';

import '../styles/theme.dart';

class SettingsCard extends StatefulWidget {
  final String route;
  final Icon icon;
  final String name;
  const SettingsCard({
    super.key,
    required this.icon,
    required this.route,
    required this.name,
  });

  @override
  State<SettingsCard> createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: Paddings.padding8,
      decoration: Decorations.cardStyle,
      child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(widget.route);
          },
          child: Ink(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.icon,
                  Gaps.gapH25,
                  Text(widget.name, style: Fonts.bold24),
                  Gaps.gapH25,
                  CustomIcons.forwardIcon
                ]),
          )),
    );
  }
}
