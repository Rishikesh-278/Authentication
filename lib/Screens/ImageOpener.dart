import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ImageOpener extends StatefulWidget {
  const ImageOpener({Key? key}) : super(key: key);

  @override
  State<ImageOpener> createState() => _ImageOpenerState();
}

class _ImageOpenerState extends State<ImageOpener> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image"),
      ),
      backgroundColor: Colors.black,
      body: Image.network(
        FirebaseAuth.instance.currentUser!.photoURL!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}