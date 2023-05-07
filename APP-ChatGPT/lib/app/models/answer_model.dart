import "dart:convert";

import "package:chat_gpt_app/app/models/message_model.dart";

class AnswerModel {
  final List<MessageModel> messages;

  AnswerModel({required this.messages});

  Map<String, Object> toMap() {
    return <String, List<MessageModel>>{
      "messages": this.messages
    };
  }

  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    return AnswerModel(
      messages: List<MessageModel>.from(map["messages"].map((x) => MessageModel.fromMap(x)).toList())
    );
  }

  String toJson() => json.encode(toMap());
  factory AnswerModel.fromJson(String source) => AnswerModel.fromMap(json.decode(source));
}