import "package:chat_gpt_app/app/models/role.dart";

extension StringExtensions on String {
  Role get toEnumRole => Role.values.firstWhere((Role role) => role.toString() == "Role.$this");
}