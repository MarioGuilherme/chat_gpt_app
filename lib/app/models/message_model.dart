import "dart:convert";

class MessageModel {
  final bool isMyMessage;
  final bool isError;
  final String role = "user";
  final String content;

  MessageModel({
    required this.isMyMessage,
    required this.content,
    this.isError = false
  });

  Map<String, String> toMap() => <String, String>{
    "role": this.role,
    "content": this.content
  };

  factory MessageModel.fromMap(Map<String, dynamic> map) => MessageModel(
    content: map["content"],
    isMyMessage: false,
    isError: true
  );

  String toJson() => json.encode(this.toMap());
  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source));
}