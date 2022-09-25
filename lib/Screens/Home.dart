import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:authentication/components/drawer.dart';

String quote = "";
String author = "";

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      drawer: const SafeDrawer(),
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
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Text(quote,
                                style: const TextStyle(fontSize: 17))),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 250),
                          child: Text(
                            "- $author",
                            style: const TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "API Calls on refresh  ⬆",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}