import "dart:developer";

import "package:dio/dio.dart";

import "package:chat_gpt_app/app/core/http/http_client.dart";
import "package:chat_gpt_app/app/models/message_model.dart";
import "package:chat_gpt_app/app/models/response_model.dart";
import "package:chat_gpt_app/app/repositories/chat/chat_repository.dart";

class ChatRepositoryImpl implements ChatRepository {
  final HttpClient httpClient;

  ChatRepositoryImpl({required this.httpClient});

  @override
  Future<MessageModel> makeAQuestion(List<MessageModel> messages) async {
    try {
      final ResponseModel result = await this.httpClient.restRequest(
        method: Method.post,
        endpoint: Endpoint.makeAQuestion,
        data: messages.map((message) => message.toJson()).toList().toString()
      );
      MessageModel newMessage = MessageModel.fromMap(Map<String, String>.from(result.data));
      return newMessage;
    } on DioError catch (e, s) {
      log("Erro ao fazer pergunta ao CHAT GPT", error: e, stackTrace: s);
      throw Exception("Erro ao fazer pergunta ao CHAT GPT");
    }
  }
}