import 'package:flutter/material.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:innovit_2cs_project_apptablette/utils/extentions.dart';
import '../styles/theme.dart';
import '../viewmodels/drink.dart';

class DrinkCard extends StatefulWidget {
  final Drink drink;
  const DrinkCard({
    super.key,
    required this.drink,
  });

  @override
  State<DrinkCard> createState() => DrinkCardState();
}

class DrinkCardState extends State<DrinkCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Paddings.padding8,
      decoration: Decorations.cardStyle,
      child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed("/drink-details", arguments: widget.drink);
          },
          child: Ink(
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              ClipRRect(
                borderRadius: Borders.borderRadius20,
                child: DropShadowImage(
                  image: Image.network(
                    widget.drink.imageLink,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  scale: 0.1,
                  borderRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ),
              Gaps.gapH25,
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.drink.name.toTitleCase(),
                          style: Fonts.bold24),
                      const SizedBox(height: 4),
                      Text(widget.drink.description.substring(0, 30),
                          style: Fonts.light14),
                    ],
                  ),
                  Gaps.gapV25,
                  Text("${widget.drink.price.toString()} DA",
                      style: Fonts.medium20)
                ],
              )
            ]),
          )),
    );
  }
}
