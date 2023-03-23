import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  late int score;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    score = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(title: Text("$score")),
    );
  }
}
