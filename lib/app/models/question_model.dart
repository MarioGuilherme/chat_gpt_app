import "dart:convert";

import "package:chat_gpt/app/models/message_model.dart";

class QuestionModel {
  final String model;
  final List<MessageModel> messages;
  final double temperature;

  QuestionModel({
    required this.model,
    required this.messages,
    required this.temperature
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
    "model": this.model,
    "messages": this.messages,
    "temperature": this.temperature
  };

  factory QuestionModel.fromMap(Map<String, dynamic> map) => QuestionModel(
    model: map["model"],
    messages: map["messages"],
    temperature: map["temperature"]
  );

  String toJson() => json.encode(this.toMap());
  factory QuestionModel.fromJson(String source) => QuestionModel.fromMap(json.decode(source));
}