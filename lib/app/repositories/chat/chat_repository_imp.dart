import "dart:developer";

import "package:dio/dio.dart";

import "package:chat_gpt/app/models/answer_model.dart";
import "package:chat_gpt/app/repositories/chat/chat_repository.dart";

class ChatRepositoryImpl extends ChatRepository {
  final Dio dio;

  ChatRepositoryImpl({
    required this.dio
  });

  @override
  Future<AnswerModel> askAQuestion(String question) async {
    try {
      final Response<dynamic> result = await this.dio.post("/completions", data: <String, Object>{
        "model": "gpt-3.5-turbo",
        "messages": <Map<String, Object>>[
          <String, String>{
            "role": "user",
            "content": question
          }
        ],
        "temperature": 0.8
      });
      return AnswerModel.fromMap(result.data);
    } on DioError catch (e, s) {
      log("Erro ao fazer pergunta ao CHAT GPT", error: e, stackTrace: s);
      throw Exception("Erro ao fazer pergunta ao CHAT GPT");
    }
  }
}