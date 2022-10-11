// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    required this.model,
    required this.prompt,
    required this.temperature,
    required this.maxTokens,
    required this.topP,
    required this.frequencyPenalty,
    required this.presencePenalty,
    required this.stop,
  });

  String model;
  String prompt;
  double temperature;
  int maxTokens;
  int topP;
  int frequencyPenalty;
  int presencePenalty;
  List<String> stop;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    model: json["model"],
    prompt: json["prompt"],
    temperature: json["temperature"].toDouble(),
    maxTokens: json["max_tokens"],
    topP: json["top_p"],
    frequencyPenalty: json["frequency_penalty"],
    presencePenalty: json["presence_penalty"],
    stop: List<String>.from(json["stop"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "prompt": prompt,
    "temperature": temperature,
    "max_tokens": maxTokens,
    "top_p": topP,
    "frequency_penalty": frequencyPenalty,
    "presence_penalty": presencePenalty,
    "stop": List<dynamic>.from(stop.map((x) => x)),
  };
}
