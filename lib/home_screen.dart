import 'package:flutter/material.dart';
import 'package:application_musique/widget/myscaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MyScaffold(
      name: 'Home',
      body: Center(),
    );
  }
}

