import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:authentication/components/drawer.dart';
import 'dart:convert';
import 'dart:math';
import 'package:authentication/api_key.dart';

String quote = "";
String author = "";
//String words = "";

class ApiCalls extends StatefulWidget {
  const ApiCalls({Key? key}) : super(key: key);

  @override
  State<ApiCalls> createState() => _ApiCallsState();
}

class _ApiCallsState extends State<ApiCalls> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("ApiCalls"),
          centerTitle: true,
        ),
        drawer: const SafeDrawer(),
        body: RefreshIndicator(
          edgeOffset: 0.1,
          backgroundColor: Colors.black,
          color: Colors.white,
          onRefresh: () async {
            var url = Uri.parse("https://stoic-quotes.com/api/quote");
            var response = await http.get(url);
            print("response status: ${response.statusCode}");
            if (response.statusCode != 200) {
              print("Failed");
            }
            print("response body : ${response.body}");

            var data = jsonDecode(response.body);
            print(data);

            quote = (data["text"]);
            author = (data["author"]);
            //words = (data[Random().nextInt(100)]);
            /*
            This words API generates list of 117 words, The above line of code choose one random word out of 100,
            https://famous-quotes4.p.rapidapi.com/?rapidapi-key=$Api_Key
             */
            //author = (data["quotes"][0]["author"]);

            setState(() {});
          },
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Stoicism quotes",
                    style: TextStyle(fontSize: 22),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, right: 10),
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
      ),
    );
  }
}
