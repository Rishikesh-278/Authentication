import 'package:flutter/material.dart';
import 'Screens/Home.dart';
import 'Screens/Timer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _CurrentIndex = 0;

  void onTapped(int index) {
    setState(() {
      _CurrentIndex = index;
    });
  }

  final Screens = [
    Home(),
    TimerPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screens[_CurrentIndex],
      bottomNavigationBar: BottomBar(context),
    );
  }

  BottomNavigationBar BottomBar(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTapped,
      currentIndex: _CurrentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.watch_later), label: "Timer")
      ],
    );
  }
}
