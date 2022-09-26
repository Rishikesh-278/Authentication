import 'package:authentication/Screens/ImageOpener.dart';
import 'package:authentication/Screens/Timer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../AuthService.dart';

class SafeDrawer extends StatefulWidget {
  const SafeDrawer({Key? key}) : super(key: key);

  @override
  State<SafeDrawer> createState() => _SafeDrawerState();
}

class _SafeDrawerState extends State<SafeDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: 250,
        backgroundColor: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 50),
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ImageOpener()));
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              FirebaseAuth.instance.currentUser!.photoURL!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        FirebaseAuth.instance.currentUser!.displayName!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  AuthService().signOut();
                },
                child: const Text("Log out")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TimerPage()));
                },
                child: Text("Timer"))
          ],
        ),
      ),
    );
  }
}
