import 'package:flutter/material.dart';
import './pages/home.dart';
import './pages/next.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String btnName = "click";
  int navIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {"/page2": (_) => const NextPage()},
      theme: ThemeData(
          primaryColor: const Color(0xff251201), fontFamily: 'Outfit'),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
