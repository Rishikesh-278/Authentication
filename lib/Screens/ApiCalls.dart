import 'dart:convert' as convert;
import 'dart:convert';
import 'package:authentication/api_key.dart';
import 'package:authentication/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

String quote = ""; //The quote
String author = ""; //Author of the Stoicism
String jsonR = ""; //A String to Convert the JSON response to String
String data = ""; //A String to extract the Emojis from the JSON response
String outPutString = "";

double currentSliderValue = 1;
double ApiTop_p = 1;
double ApiMax_tokens = 60;
double ApiTemperature = 0.8;

var url = Uri.parse("https://api.openai.com/v1/completions");

class ApiCalls extends StatefulWidget {
  const ApiCalls({Key? key}) : super(key: key);

  @override
  State<ApiCalls> createState() => _ApiCallsState();
}

class _ApiCallsState extends State<ApiCalls> {
  TextEditingController movieController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  /*
   ButtonDisable() {
    if (movieController.text == "${movieController.text}")
    {
      TextButton(
        onPressed: () async {
          var response = await http.post(
            url,
            body: convert.jsonEncode({
              "model": "text-davinci-002",
              "prompt":
                  "Convert movie titles into emoji.\n\n${movieController.text}:",
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
            },
          );

          if (response.statusCode == 200) {
            var jsonResponse = convert.jsonDecode(response.body);
            jsonR = jsonResponse.toString();

            data = (jsonResponse["choices"][0]["text"]);
            //Extracting the Emoji from the JSON response
            print(data);

            if (data == "") {
              print("Error");
            }
            print(jsonResponse);
          } else {
            print('Request failed with status: ${response.statusCode}');
          }
          setState(() {
            outPutString = data; //Displays the emojis
          });
        },
        child: Text("Submit"),
      );
    }
    else
      {
        TextButton(
          onPressed: () async {
            var response = await http.post(
              url,
              body: convert.jsonEncode({
                "model": "text-davinci-002",
                "prompt":
                "Convert movie titles into emoji.\n\n${movieController.text}:",
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
              },
            );

            if (response.statusCode == 200) {
              var jsonResponse = convert.jsonDecode(response.body);
              jsonR = jsonResponse.toString();

              data = (jsonResponse["choices"][0]["text"]);
              //Extracting the Emoji from the JSON response
              print(data);

              if (data == "") {
                print("Error");
              }
              print(jsonResponse);
            } else {
              print('Request failed with status: ${response.statusCode}');
            }
            setState(() {
              outPutString = data; //Displays the emojis
            });
          },
          child: Text("Submit"),
        );
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
            {
              ApiTemperature = 0.5;
              ApiTop_p = 0.5;
              ApiMax_tokens = 30;
            }
            {
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
            }
            movieController.clear(); //To clear the text from the text field
            outPutString = ""; //TO clear the outut
            /*
            {
              var Imgurl = Uri.parse("https://thisartworkdoesnotexist.com/");
              var ImgResponse = await http
                  .get(Imgurl, headers: {"Content-Type": "image/jpeg"});
              print(ImgResponse);
              if (ImgResponse.statusCode == 200) {
                print("Image workss");
              }
            }
             */
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
                              child: GestureDetector(
                            onLongPress: () {
                              {
                                Clipboard.setData(ClipboardData(text: quote));
                                const snackBar = SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.grey,
                                  content: Text("Quote copied",
                                      textAlign: TextAlign.center),
                                  duration: Duration(seconds: 1),
                                  width: 200,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Text(quote,
                                style: const TextStyle(fontSize: 17)),
                          )),
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
              /*
              TextButton(
                  onPressed: () async {
                    print("Works");
                    var response = await http.post(
                      url,
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
                      },
                    );
                    if (response.statusCode == 200) {
                      var jsonResponse = convert.jsonDecode(response.body);
                      jsonR = jsonResponse.toString();

                      data = (jsonResponse["choices"][0]["text"]);
                      print(Rusty);

                      print(jsonResponse);
                    } else {
                      print(
                          'Request failed with status: ${response.statusCode}');
                    }
                  },
                  child: const Text("Press")),
      */
              const SizedBox(height: 30),
              const Center(
                  child: Text(
                "Movie titles to emoji",
                style: TextStyle(fontSize: 30),
              )),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: movieController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Movie/TV show name"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Please use the sliders",style: TextStyle(fontSize: 20),),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "temperature",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    //margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Text(
                        ApiTemperature.toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  )
                ],
              ), //max_tokens and value
              Slider(
                  min: 0.0,
                  max: 1,
                  label: currentSliderValue.round().toString(),
                  value: ApiTemperature,
                  onChanged: (double value) {
                    setState(() {
                      ApiTemperature = value;
                    });
                  }),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "max_tokens",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    //margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Text(
                        ApiMax_tokens.toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  )
                ],
              ), //max_tokens and value
              Slider(
                  min: 0.0,
                  max: 60.0,
                  label: currentSliderValue.round().toString(),
                  value: ApiMax_tokens,
                  onChanged: (double value) {
                    setState(() {
                      ApiMax_tokens = value;
                    });
                  }), //max_tokens slider
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Top_P",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    //margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: const BorderRadius.all(Radius.circular(5))),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        ApiTop_p.toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  )
                ],
              ), //Top_p and value
              Slider(
                  min: 0.0,
                  max: 1,
                  label: currentSliderValue.round().toString(),
                  value: ApiTop_p,
                  onChanged: (double value) {
                    setState(() {
                      ApiTop_p = value;
                    });
                  }), //Top_p's slider


              Row(children: <Widget>[
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "${(movieController.text)} : $outPutString",
                    style: TextStyle(fontSize: 20),
                    maxLines: 100,
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(left: 150, right: 150),
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () async {
                    var response = await http.post(
                      url,
                      body: convert.jsonEncode({
                        "model": "text-davinci-002",
                        "prompt":
                            "Convert movie titles into emoji.\n\n${movieController.text}:",
                        "temperature": ApiTemperature.toDouble(),
                        "max_tokens": ApiMax_tokens.toInt(),
                        "top_p": ApiTop_p,
                        "frequency_penalty": 0.0,
                        "presence_penalty": 0.0,
                        "stop": ["\n"]
                      }),
                      headers: {
                        "Content-Type": "application/json",
                        "Accept": "application/json",
                        "Authorization": "Bearer $ApiKey"
                      },
                    );
                    if (response.statusCode == 200) {
                      var jsonResponse = convert.jsonDecode(utf8.decode(response.bodyBytes));
                      jsonR = jsonResponse.toString();
                      data = (jsonResponse["choices"][0]["text"]);
                      //Extracting the Emoji from the JSON response
                      print(data);

                      print(response.headers);
                      if (data == "")
                      {
                        print("Error");
                      }
                      print(jsonResponse);
                    } else
                    {
                      print(
                          'Request failed with status: ${response.statusCode}');
                    }
                    setState(() {
                      outPutString = data; //Displays the emojis
                    });
                  },
                  child: Text("Submit"),
                ),
              ), //Submit button
            ],
          ),
        ),
      ),
    );
  }
}

//curl -H "Content-Type: application/json" -H "apikey: 0000000000" -d '{"prompt":"A horde of stable robots", "params":{"n":1, "width": 256, "height": 256}}' https://stablehorde.net/api/v2/generate/sync
