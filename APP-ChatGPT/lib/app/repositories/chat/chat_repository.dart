import "package:chat_gpt_app/app/models/message_model.dart";

abstract class ChatRepository {
  Future<MessageModel> makeAQuestion(List<MessageModel> myQuestion);
}