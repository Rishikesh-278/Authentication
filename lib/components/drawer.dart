import 'package:authentication/Screens/ImageOpener.dart';
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
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget> [
                  SizedBox(height: 50),
                  Row(
                    children: <Widget> [
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> const ImageOpener()));},
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text(FirebaseAuth.instance.currentUser!.displayName!,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                    ],
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*
MaterialButton(
color: Colors.green,
child: const Text("Log out"),
onPressed: () {
AuthService().signOut();
})
 */
