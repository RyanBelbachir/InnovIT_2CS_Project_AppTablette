import 'package:flutter/material.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';

class DrinkCard extends StatefulWidget {
  final String name;
  final String imageLink;
  final String description;
  final String price;
  const DrinkCard(
      {super.key,
      required this.name,
      required this.imageLink,
      required this.description,
      required this.price});

  @override
  State<DrinkCard> createState() => DrinkCardState();
}

class DrinkCardState extends State<DrinkCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
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
      ),
      child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed("/page2", arguments: 3);
          },
          child: Ink(
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: DropShadowImage(
                  image: Image.asset(
                    widget.imageLink,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ),
              const SizedBox(width: 26),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.name,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Outfit',
                              fontSize: 24)),
                      const SizedBox(height: 4),
                      Text(widget.description,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Outfit',
                              fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text("${widget.price.toString()} DA",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Outfit',
                          fontSize: 20))
                ],
              )
            ]),
          )),
    );
  }
}
