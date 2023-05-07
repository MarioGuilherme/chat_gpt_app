import "package:chat_gpt_app/app/models/response_model.dart";

abstract class HttpClient {
  Future<ResponseModel> restRequest({
    required Method method,
    required Endpoint endpoint,
    required String data
  });
}

enum Method {
  get,
  post,
  put,
  delete,
  patch
}

enum Endpoint {
  makeAQuestion,
  reportLog
}