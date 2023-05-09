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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "role": role.string,
      "content": content,
      "isError": isError
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      role: (map["role"] as String).toEnumRole,
      content: map["content"]!,
      isError: map["isError"] ?? false
    );
  }

  String toJson() => json.encode(this.toMap());
  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source));
}