import 'package:flutter/material.dart';
import 'package:authentication/components/drawer.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {

  Timer? timer;
  int timeLeft = 5;

  void _StartCountDown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void _StopTimer()
  {
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Timer"),
          centerTitle: true,
        ),
        drawer: const SafeDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                timeLeft.toString(),
                style: const TextStyle(fontSize: 70),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    color: Colors.deepPurple,
                    onPressed: () {
                      _StartCountDown();
                    },
                    child: const Text(
                      "S T A R T",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ), //Start
                  MaterialButton(
                    color: Colors.deepPurple,
                    onPressed: () {
                      _StopTimer();
                    },
                    child: const Text(
                      "P A U S E",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ), //Pause
                ],
              ),
              IconButton(
                iconSize: 50,
                color: Colors.deepPurple,
                  onPressed: () {
                  timeLeft = 5;
                  },
                  icon: const Icon(
                    Icons.restart_alt_sharp,
                  ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            timeLeft = timeLeft + 10;
          },
          child: const Text("+",
          style: TextStyle(fontSize: 35),),
        ),
      ),
    );
  }
}