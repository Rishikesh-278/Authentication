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
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              //width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.white70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: <Widget> [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(FirebaseAuth
                                      .instance.currentUser!.photoURL!),
                                ),
                                SizedBox(width: 20,),
                                Text(
                                  FirebaseAuth
                                      .instance.currentUser!.displayName!,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(width: 20),

                            const SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
                color: Colors.green,
                child: const Text("Log out"),
                onPressed: () {
                  AuthService().signOut();
                })
          ],
        ),
      ),
    );
  }
}
