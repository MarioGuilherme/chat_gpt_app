import "dart:convert";

import "package:chat_gpt_app/app/models/message_model.dart";

class QuestionModel {
  final String model;
  final List<MessageModel> messages;
  final double temperature;

  QuestionModel({
    required this.model,
    required this.messages,
    required this.temperature
  });

  Map<String, Object> toMap() {
    return <String, Object>{
      "model": model,
      "messages": messages.map((MessageModel m) => m.toMap()).toList(),
      "temperature": temperature
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      model: map["model"]!,
      messages: List<MessageModel>.from(map["messages"].map((Map<String, String> x) => MessageModel.fromMap(x))),
      temperature: map["temperature"]!.toDouble()
    );
  }

  String toJson() => json.encode(toMap());
  factory QuestionModel.fromJson(String source) => QuestionModel.fromMap(json.decode(source));
}