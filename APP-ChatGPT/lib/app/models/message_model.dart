import "dart:convert";

import "package:chat_gpt_app/app/core/extensions/enum_extension.dart";
import "package:chat_gpt_app/app/core/extensions/string_extension.dart";
import "package:chat_gpt_app/app/models/role.dart";

class MessageModel {
  final Role role;
  final String content;
  final bool isError;

  MessageModel({
    required this.role,
    required this.content,
    this.isError = false
  });

  Map<String, String> toMap() {
    return <String, String>{
      "role": role.string,
      "content": content
    };
  }

  factory MessageModel.fromMap(Map<String, String> map) {
    return MessageModel(
      role: map["role"]!.toEnumRole,
      content: map["content"]!
    );
  }

  String toJson() => json.encode(this.toMap());
  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source));
}