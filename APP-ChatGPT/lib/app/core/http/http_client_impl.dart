import "package:dio/dio.dart";
import "package:flutter/foundation.dart";

import "package:chat_gpt_app/app/core/extensions/enum_extension.dart";
import "package:chat_gpt_app/app/core/http/http_client.dart";
import "package:chat_gpt_app/app/models/response_model.dart";

class HttpClientImpl implements HttpClient {
  late final String _baseUrl;
  final Dio dio;

  HttpClientImpl({required this.dio}) {
    this._baseUrl = kDebugMode
      ? "http://192.168.1.116/API-Gateway-ChatGPT"
      : "https://chat-gpt-app-web.000webhostapp.com/api";
    this.dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: true
    ));
  }

  @override
  Future<ResponseModel> restRequest({
    required Method method,
    required Endpoint endpoint,
    required String data
  }) async {
    Response<dynamic> response = await dio.request(
      "${this._baseUrl}/${endpoint.string}",
      data: data,
      options: Options(method: method.string)
    );
    return ResponseModel.fromMap(response.data);
  }
}
