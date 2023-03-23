import 'package:flutter/material.dart';
import '../bussiness/drink.dart';

class DrinkDetails extends StatefulWidget {
  const DrinkDetails({super.key});

  @override
  State<DrinkDetails> createState() => _DrinkDetailsState();
}

class _DrinkDetailsState extends State<DrinkDetails> {
  late Drink drink;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    drink = ModalRoute.of(context)!.settings.arguments as Drink;
    return Scaffold(
      appBar: AppBar(title: Text(drink.name)),
    );
  }
}
