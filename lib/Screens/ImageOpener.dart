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
        title: Text("Image"),
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
                        backgroundColor: Colors.blueGrey,
                        content:
                        Text('Image URL copied', textAlign: TextAlign.center),
                        duration: Duration(seconds: 3),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    };
                  },
                  child: const Text(
                    "Copy Image URL",
                  ),
                ),
              )
            ],
          )
        ],
        backgroundColor: Colors.black,
      ),
      body: Image.network(
        FirebaseAuth.instance.currentUser!.photoURL!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fitWidth,
      ),
      backgroundColor: Colors.black,
    );
  }
}

/*

 */
