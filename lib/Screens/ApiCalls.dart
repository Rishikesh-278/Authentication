import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'package:authentication/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:authentication/api_key.dart';

String quote = "";
String author = "";
//String words = "";
String jsonR = "";
String data = "";

var url = Uri.parse("https://api.openai.com/v1/completions");

class ApiCalls extends StatefulWidget {
  const ApiCalls({Key? key}) : super(key: key);

  @override
  State<ApiCalls> createState() => _ApiCallsState();
}

class _ApiCallsState extends State<ApiCalls> {

  /*
  static Future<dynamic> answer(
    String? model,
    String? prompt,
    double? temperature,
    int? max_tokens,
    double? top_p,
    double? frequency_penalty,
    double? presence_penalty,
    String? stop,
  ) async {
    Map reqData() => {
          "model": model,
          "prompt": prompt,
          'temperature': temperature,
          'max_tokens': max_tokens,
          'top+p': top_p,
          'frequency_penalty': frequency_penalty,
          'presence_penalty': presence_penalty,
          "stop": ["\n"]
        };
    {
      var response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $ApiKey"
          },
          body: convert.jsonEncode(reqData()));
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    }
  }

   */

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
                  const Text(
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
              TextButton(
                  onPressed: ()  async {
                    print("Works");
                    var response = await http.post(url,
                      body: convert.jsonEncode({
                        "model": "text-davinci-002",
                        "prompt":
                        "Convert movie titles into emoji.\n\nBack to the Future: 👨👴🚗🕒 \nBatman: 🤵🦇 \nTransformers: 🚗🤖 \nStar Wars:",
                        "temperature": 0.8,
                        "max_tokens": 60,
                        "top_p": 1.0,
                        "frequency_penalty": 0.0,
                        "presence_penalty": 0.0,
                        "stop": ["\n"]
                      }),
                        headers: {
                          "Content-Type": "application/json",
                          "Accept": "application/json",
                          "Authorization": "Bearer $ApiKey"
                        },);
                    if (response.statusCode == 200) {
                      var jsonResponse = convert.jsonDecode(response.body);
                      jsonR = jsonResponse.toString();

                      data = (jsonResponse["choices"][0]["text"]);
                      print(data);
                      print(jsonResponse);
                    } else {
                      print(
                          'Request failed with status: ${response.statusCode}');
                    }
                  },
                  child: Text("Press")),
              Container(
                child: Text(data),
              )
            ],
          ),
        ),
      ),
    );
  }
}