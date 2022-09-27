import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        title: Text("Image",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: GestureDetector(
                  onTap: () {
                    {
                      Clipboard.setData(ClipboardData(
                          text: FirebaseAuth.instance.currentUser!.photoURL!));
                      const snackBar = SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.grey,
                        content:
                        Text('Image URL copied', textAlign: TextAlign.center),
                        duration: Duration(seconds: 1),
                        width: 200,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text(
                    "Copy Image URL",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Image.network(
        FirebaseAuth.instance.currentUser!.photoURL!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fitWidth,
      ),
      backgroundColor: Colors.grey[900],
    );
  }
}