import "package:dio/dio.dart";
import "package:dio/native_imp.dart";

class CustomDio extends DioForNative {
  CustomDio() : super(BaseOptions(
    baseUrl: "https://api.openai.com/v1/chat/",
    headers: <String, String>{
      "Authorization": "Bearer "
    },
    connectTimeout: 5000,
    receiveTimeout: 30000
  )) {
    this.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: true,
      error: true,
      request: true
    ));
  }
}