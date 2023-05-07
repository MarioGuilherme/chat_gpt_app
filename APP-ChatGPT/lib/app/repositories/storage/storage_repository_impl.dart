import "dart:convert";

import "package:chat_gpt_app/app/repositories/storage/storage_repository.dart";

import "package:chat_gpt_app/app/models/message_model.dart";
import "package:shared_preferences/shared_preferences.dart";

class StorageRepositoryImpl implements StorageRepository {
  final String _keyStorage = "messages";

  @override
  Future<List<MessageModel>> getAllMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString(this._keyStorage)!;
    return List<MessageModel>.from(jsonDecode(jsonString).map((json) => MessageModel.fromMap(Map<String, String>.from(json))));
  }

  @override
  Future<void> saveQuestions(List<MessageModel> messages) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(this._keyStorage, messages.map((message) => message.toJson()).toList().toString());
  }
}