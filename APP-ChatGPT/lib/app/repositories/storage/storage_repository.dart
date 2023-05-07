import "package:chat_gpt_app/app/models/message_model.dart";

abstract class StorageRepository {
  Future<List<MessageModel>> getAllMessages();
  Future<void> saveQuestions(List<MessageModel> messages);
}