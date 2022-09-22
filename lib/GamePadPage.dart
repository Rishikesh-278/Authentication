import 'package:flutter/material.dart';
import 'package:authentication/BottomBar.dart';

class GamePadPage extends StatefulWidget {
  const GamePadPage({Key? key}) : super(key: key);

  @override
  State<GamePadPage> createState() => _GamePadPageState();
}

class _GamePadPageState extends State<GamePadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GamePad"),
      ),
      body: Center(
        child: Text("GamePage"),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
