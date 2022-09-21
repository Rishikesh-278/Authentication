import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'AuthService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

String quote = "";
String author = "";

class _HomePageState extends State<HomePage> {
  //String? user = FirebaseAuth.instance.currentUser!.email ?? FirebaseAuth.instance.currentUser!.displayName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          centerTitle: true,
        ),
        drawer: SafeArea(
          child: Drawer(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        FirebaseAuth.instance.currentUser!.displayName!,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        FirebaseAuth.instance.currentUser!.email!,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        padding: const EdgeInsets.all(10),
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          'LOG OUT',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        onPressed: () {
                          AuthService().signOut();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: RefreshIndicator(
          edgeOffset: 0.1,
          backgroundColor: Colors.black,
          color: Colors.white,
          onRefresh: () async {
            var url = Uri.parse(
                "https://goquotes-api.herokuapp.com/api/v1/random?count=1");
            var response = await http.get(url);
            print("response status: ${response.statusCode}");
            print("response body : ${response.body}");

            var data = jsonDecode(response.body);
            print(data["quotes"][0]);

            quote = (data["quotes"][0]["text"]);
            author = (data["quotes"][0]["author"]);

            setState(() {});
          },
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                        height: 150,
                        width: 500,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            border: Border.all(width: 0.1),
                            borderRadius: const BorderRadius.all(Radius.circular(5))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(quote,style: const TextStyle(fontSize: 17)),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 250),
                              child: Text("- $author",style: const TextStyle(fontSize: 17),),
                            ),
                          ],
                        ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
    );
  }
}
