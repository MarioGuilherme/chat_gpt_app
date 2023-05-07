import "package:chat_gpt_app/app/models/role.dart";

extension EnumExtension on Enum {
  String get string => this.toString().split(".").last;
  bool get isUser => this == Role.user;
}