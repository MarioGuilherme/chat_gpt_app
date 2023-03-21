import "package:chat_gpt/app/models/answer_model.dart";

abstract class ChatRepository {
  Future<AnswerModel> askAQuestion(String question);
}